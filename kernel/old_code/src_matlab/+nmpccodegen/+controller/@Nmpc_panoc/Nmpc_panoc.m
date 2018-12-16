classdef Nmpc_panoc
    %NMPC_PANOC Represents the actual controller.
    %   The user should construct an object of this class that represents
    %   his controller, containing the model and all the controller parameters.
    
    properties
        location % Folder location letter control needs to be generated.
        model % Model of the system that the controller controls provided by the constructor.
        dimension_panoc=0; % After generating the controller this attribute will contain the dimension of the optimization problem
        stage_cost % Stage cost provided by the constructor.
        terminal_cost % Optional terminal cost provided by the constructor.
        horizon=10 % The horizon of the controller problem.
        shooting_mode = 'single shot' % At the moment only single shot mode is implemented.
        lbgfs_buffer_size = 50 % The buffer size of the quasi Newton method.
        data_type = 'double precision' % The required precision of the controller, should be either single or double precision.
        panoc_max_steps=20 % The maximum amount of steps the panoc algorithm should take.
        panoc_min_steps=0 % The minimum amount of steps the panoc algorithm should take.
        min_residual=-3 % The power required precision of the residual, the residual will be required to be 10^min_residual
        integrator_casadi=false % Optional feature that can generate if true a integrator in C code.
        pure_prox_gradient=false % If true this will disable the quasi Newton method.
        globals_generator % Contains the global generator object constructed by the constructor
        constraints=[] % Contains the constraints, add new constraints with the add_constraint method.
        number_of_constraints=0 % Contains a number of constraints.
        general_constraints=[] % Contains a general constraints add new constraints with the add_general_constraint method
        shift_input=true % If true, the input horizon will be shifted after returning the optimal input
        cost_function % The casadi cost function generated by the generate_code() method
        cost_function_derivative_combined % The casadi cost/gradient generated by the generate_code() method
        
        % from here on variables only used with general constraints (lagrangian)
        constraint_optimal_value=1e3 % LA: when the weighted constraint is larger stop increasing the weight
        constraint_max_weight=1e5 % LA: max value of the weight on the general constraints
        start_residual=1 % LA: the start residual of the accelerated lagrangian
        max_steps_LA=4 % LA: max amount of outer looops/step of the accelerated lagrangian 
    end
    
    methods(Access =  public)
        function obj = Nmpc_panoc( location_lib,model,stage_cost,terminal_cost)
            % Constructor of controller
            %   -location_lib : Location of the folder in which the control
            %   should be generated.
            %   -model : The discrete or continues model.
            %   -stage_cost : The stage cost object
            %   -terminal_cost : The optional terminal cost of object, if no
            %   -terminal costs is provided than the stage cost will be used as
            %   terminal cost.
            obj.location=location_lib;
            obj.model=model;
            obj.stage_cost=stage_cost;
            if (nargin == 3)
                obj.terminal_cost=[];
            elseif (nargin == 4)
                obj.terminal_cost=terminal_cost;
            else
                disp('error invalid amount of parameters in nmpc_constructor')
            end
            obj.globals_generator = nmpccodegen.controller.Globals_generator([location_lib '/globals/globals_dyn.h']);
        end
        function obj=generate_code(obj)
            % start with generating the cost function
            if(strcmp(obj.shooting_mode,'single shot'))
                if(isempty(obj.general_constraints))
                    obj = obj.generate_cost_function_singleshot();
                else
                    obj = obj.generate_cost_function_singleshot_LA();
                end                
            elseif(strcmp(obj.shooting_mode,'multiple shot'))
                obj = obj.generate_cost_function_multipleshot();
            else
                disp('ERROR in generating code: invalid choice of shooting mode [single shot|multiple shot]');
            end

            obj.globals_generator.generate_globals(obj);

            % optional feature, a c version of the integrator
            if(obj.integrator_casadi)
                obj.generate_integrator();
            end

            obj.model.generate_constraint(obj.location)
            
        end

        function cost = calculate_stage_cost(obj,current_state,input,i,...
                                        state_reference,input_reference)
            % Calculate stage cost at a particular state.This function is
            % used internally.
            if(i==obj.horizon)
                cost=obj.terminal_cost.evaluate_cost(current_state,input,i,state_reference,input_reference);
            else
                cost=obj.stage_cost.evaluate_cost(current_state,input,i,state_reference,input_reference);
            end
        end
        function obj = add_constraint(obj,constraint)
            % Add an constraint to the controller.
            obj.constraints = horzcat(obj.constraints,constraint);
            obj.number_of_constraints=length(obj.constraints);
        end
        function obj = add_general_constraint(obj,general_constraint)
            % Add a general constraint to the control.
            %   general_constraint = This object should be an object of the
            %   class that inherits from the constraint interface more info
            %   at "help nmpccodegen.controller.constraints.Constraint"
            obj.general_constraints = horzcat(obj.general_constraints,general_constraint);
        end
        function number_of_constraints = get_number_of_constraints(obj)
            % get the number of constraints.
            number_of_constraints = length(obj.constraints);
        end
        function cost = generate_cost_constraints(obj,state,input,constraint_weights)
            % Function used internally to calculate the costs of the
            % constraints.
            if(obj.number_of_constraints == 0)
                cost= 0.;
            else
                cost = 0.;
                for i=1:obj.number_of_constraints
                    cost = cost + constraint_weights(i)*...
                        (obj.constraints(i).evaluate_cost(state,input)).^2;
                end
            end
        end
    end
    methods(Access =  private)
        function obj=generate_cost_function_singleshot(obj)
            % Generate the single cost, cost function
            
            ssd = nmpccodegen.controller.Single_shot_definition(obj);
            % generate the cost function in casadi syntax AND generate c
            % code in the background
            [cost_function_, cost_function_derivative_combined_] = ssd.generate_cost_function();

            obj.cost_function = cost_function_;
            obj.cost_function_derivative_combined=cost_function_derivative_combined_;
            obj.dimension_panoc=ssd.dimension;
        end
        function obj=generate_cost_function_singleshot_LA(obj)
            % Generate the Lagrangian accelerated single cost, cost
            % function.
            
            ssd = nmpccodegen.controller.Single_shot_LA_definition(obj);
            % generate the cost function in casadi syntax AND generate c
            % code in the background
            [cost_function_, cost_function_derivative_combined_] = ssd.generate_cost_function();

            obj.cost_function = cost_function_;
            obj.cost_function_derivative_combined=cost_function_derivative_combined_;
            obj.dimension_panoc=ssd.dimension;
        end
        function obj=generate_cost_function_multipleshot(obj)
            % Multiple shot mode is not supported in Matlab.
            disp('Multiple shot is not implemented !');
        end
        function generate_integrator(obj)
            % Generate optional integrator function using casadi
            state = casadi.SX.sym('state', obj.model.number_of_states, 1);
            input = casadi.SX.sym('input', obj.model.number_of_inputs , 1);
            
            integrator = casadi.Function('integrator', {state, input}, {obj.model.get_next_state(state,input)});
            nmpccodegen.controller.Casadi_code_generator.translate_casadi_to_c(integrator,obj.location,'integrator');
        end
    end
    
end
