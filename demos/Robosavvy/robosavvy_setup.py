import sys
sys.path.insert(0, '/home/nick/nmpc-codegen-python/src')
import nmpccodegen as nmpc
import nmpccodegen.tools as tools
import nmpccodegen.models as models
import nmpccodegen.controller as controller
import nmpccodegen.Cfunctions as cfunctions
import nmpccodegen.example_models as example_models

import numpy as np
import math
import matplotlib.pyplot as plt

def calculate_horizon(robot_controller,sim,initial_state,reference_state,reference_input,obstacle_weights):
    # -- simulate controller --
    simulation_time = 2
    number_of_steps = math.ceil(simulation_time / robot_controller.model.step_size)
    # setup the weights on a simulator to test
    for i in range(0,len(obstacle_weights)):
        sim.set_weight_constraint(i, obstacle_weights[i])
    for i in range(0,len(reference_state)*robot_controller.horizon):
        sim.set_init_value_solver(0.,i)

    state = initial_state
    state_history = np.zeros((robot_controller.model.number_of_states, robot_controller.horizon))

    (sim_data, full_solution) = sim.simulate_nmpc_multistep_solution(initial_state, reference_state, reference_input,
                                      robot_controller.model.number_of_inputs * robot_controller.horizon)
    print("problem solved in "+str(sim_data.panoc_interations)+" iterations \n")
    inputs = np.reshape(full_solution, (robot_controller.horizon, robot_controller.model.number_of_inputs))

    for i in range(0, robot_controller.horizon):
        state = robot_controller.model.get_next_state_numpy(state, inputs[i,:].T)
        state_history[:, i] = np.reshape(state[:], robot_controller.model.number_of_states)

    print("Final state:")
    print(state)

    return state_history

def prepare_robot(step_size,Q,R,Q_terminal=None,R_terminal=None):
    "construct a simple demo controller"

    # generate static files
    robot_controller_output_location =  "../robot_controller_builds/robot_controller"
    tools.Bootstrapper.bootstrap(robot_controller_output_location, simulation_tools=True)

    # get example model from lib
	# Take get_robot_model for Robosavvy
	# get_trailer_model is for original model
    (system_equations, number_of_states, number_of_inputs, coordinates_indices,number_of_rect,number_of_circle) = nmpc.example_models.get_robot_model()

    integrator = "RK44"  # select a Runga-Kutta  integrator (FE is forward euler)

	# Sets the upper and lower bounds of the inputs and stores them
    constraint_input = cfunctions.IndicatorBoxFunction([-1, -2], [1, 2])  # input needs stay within these borders
    model = models.Model_continious(system_equations, constraint_input, step_size, number_of_states, \
                                    number_of_inputs, coordinates_indices, integrator,number_of_rect,number_of_circle)

    # define the contro
    stage_cost = controller.Stage_cost_QR(model, Q, R)
    if(Q_terminal is None):
        robot_controller = controller.Nmpc_panoc(robot_controller_output_location, model, stage_cost)
    else:
        terminal_cost = controller.Stage_cost_QR(model, Q_terminal, R_terminal)
        robot_controller = controller.Nmpc_panoc(robot_controller_output_location, model, stage_cost,terminal_cost)

    return robot_controller

def simulate(robot_controller,initial_state,reference_state,reference_input,rectangle,circle,obstacle_weights):
    # -- simulate controller --
    simulation_time = 3
    number_of_steps = math.ceil(simulation_time / robot_controller.model.step_size)
    # setup a simulator to test
    sim = tools.Simulator(robot_controller.location)
    for i in range(0,len(obstacle_weights)):
        sim.set_weight_constraint(i, obstacle_weights[i])

    state = initial_state
    state_history = np.zeros((robot_controller.model.number_of_states, number_of_steps))

    for i in range(0, number_of_steps):
        result_simulation = sim.simulate_nmpc(state, reference_state, reference_input, rectangle(i),circle(i)) # reference_input(i)
        print("Step [" + str(i+1) + "/" + str(number_of_steps) + "]: The optimal input is: [" \
              + str(result_simulation.optimal_input[0]) + "," + str(result_simulation.optimal_input[0]) + "]" \
              + " time=" + result_simulation.time_string + " number of panoc iterations=" + str(
            result_simulation.panoc_interations) + " cost=" + str(sim.get_last_buffered_cost()) )
        state_history[:, i] = np.reshape(state[:], robot_controller.model.number_of_states)
        state = robot_controller.model.get_next_state_numpy(state, result_simulation.optimal_input)
    #
    result_simulation = sim.simulate_nmpc(state, reference_state, reference_input,rectangle(i),circle(i)) # reference_input(number_of_steps)

    print("Final state:")
    print(state)

    return state_history

def draw_obstacle_border(h,xlim,number_of_points):
    x = np.asarray(np.linspace(xlim[0],xlim[1],number_of_points))
    y=np.asarray(np.zeros((number_of_points,1)))

    for i in range(0,number_of_points):
        y[i]=h(x[i])

    plt.plot(x,y)
