import sys
sys.path.insert(0, '/home/nick/nmpc-codegen-python/src')
import nmpccodegen as nmpc
import nmpccodegen.tools as tools
import nmpccodegen.models as models
import nmpccodegen.controller as controller
import nmpccodegen.controller.obstacles as obstacles
import nmpccodegen.Cfunctions as cfunctions
import nmpccodegen.example_models as example_models

import numpy as np
import matplotlib.pyplot as plt
import math

import casadi

from robosavvy_setup import prepare_robot,simulate

if __name__ == '__main__':
    step_size=0.05

    # Q and R matrixes determined by the control engineer.
    Q = np.diag([1., 1., 0.01])*0.2
    R = np.diag([1., 1.]) * 0.01

    # Arrays for plotting purposes
    rectangles = []
    circles = []

	# "prepare_robot" is a method from "robosavvy_setup.py"
	# Makes sure all proper files are set up with a demo controller
	# Can be adjusted:
		# Integrator = Runga Kutta
		# Constraints on inputs [v,w]
		# Model (Best to make a new model file)
	# Stage cost and terminal cost are also calculated
	# If Q_ and R_terminal are NOT specified, then no terminal cost is calculated
    robot_controller = prepare_robot(step_size,Q,R)

    robot_controller.horizon = 50 # NMPC parameter
    robot_controller.integrator_casadi = True # optional  feature that can generate the integrating used  in the cost function
    robot_controller.panoc_max_steps = 500 # the maximum amount of iterations the PANOC algorithm is allowed to do.
    robot_controller.min_residual=-3
    robot_controller.lbgfs_buffer_size = 50
    # robot_controller.pure_prox_gradient = True  # this will ignore the lbgfs, only usefull when testing !!!
        
    # Parametric setup to add or remove objects in the surroundings of the robot
    # Object buffer is at the moment: 10 objects
    # Can be adjusted in "example_model.py"
    # Files needed to be adjusted for extra shapes:
    #   - "model.py"
    #   - "model_continuous.py"
    #   - "nmpc.c" -> in kernel
    #   - "nmpc_python.c" -> in kernel
    #   - "nmpc_problem_single_shot.py"
    #   - "simulator.py" -> "def simulate_nmpc"
    for i in range(robot_controller.model.number_of_rect):
        center = casadi.SX.sym("obstacle_rect_center" + str(i),2)
        width  = casadi.SX.sym("obstacle_rect_width" + str(i))
        height = casadi.SX.sym("obstacle_rect_height" + str(i))
            
        # construct rectangular
        robot_controller.add_constraint(obstacles.Rectangular(robot_controller.model,center,width,height))

    for i in range(robot_controller.model.number_of_circle):
        center = casadi.SX.sym("obstacle_circle_center" + str(i),2)
        radius  = casadi.SX.sym("obstacle_radius_width" + str(i))
        
        # construct circle
        robot_controller.add_constraint(obstacles.Circular(robot_controller.model,center,radius))

    # generate the dynamic code
    robot_controller.generate_code()

#######################################################################################################
#######################################################################################################
#### All the above is only needed for the initialisation of the code
#### Future file should contain a build file(the code above)
#### And a run file (code below)
#######################################################################################################
#######################################################################################################

    # simulate everything
    initial_state = np.array([0.6, -0.1,math.pi/4])
    reference_input = np.array([0, 0]) # lambda i : np.array([1.5+0.02*i, 0.7, 0.1])
    reference_state = np.array([0.6, 1.5, 0])
	# Why are there different weightings for the obstacles?
    obstacle_weights =  [100]
    for i in range(robot_controller.model.number_of_rect-1):
        obstacle_weights.append(10000000.)

    for i in range(robot_controller.model.number_of_circle):
        obstacle_weights.append(40.)

    def rectangle(i):
        L = [ (0.6,0.5,0.4,0.5),
              (1, -0.2,0.4,0.5)]
        L+= [(2,2,0.1,0.1)]*(robot_controller.model.number_of_rect-len(L))
        ret = np.array(L).reshape((-1,1))
        return ret

    def circle(i):
        L = [ (0.5,0.25,0.2)]
        L+= [(-10,-10,0.1)]*(robot_controller.model.number_of_circle-len(L))
        ret = np.array(L).reshape((-1,1))
        return ret
    
    state_history = simulate(robot_controller,initial_state,reference_state,reference_state,rectangle,circle,obstacle_weights)
#    state_history = np.zeros((robot_controller.model.number_of_states, k))
#    while i<k:
#        state = simulate(robot_controller,initial_state,reference_state,reference_input,obstacle_weights)
#        state_history[:, i] = np.reshape(state[:], robot_controller.model.number_of_states)
#
#        initial_state = state[:]
#        reference_state = np.array([1.5, 0.7, 0])
#        i+=1

############################################################################################################
# Plot/gif section #

    from matplotlib.animation import FuncAnimation

    fig, ax = plt.subplots()
    fig.set_tight_layout(True)

    # Query the figure's on-screen size and DPI. Note that when saving the figure to
    # a file, we need to provide a DPI for that separately.
    print('fig size: {0} DPI, size in inches {1}'.format(
        fig.get_dpi(), fig.get_size_inches()))

    # Shape of history
    (number_of_states, number_of_steps) = np.shape(state_history)
    if (robot_controller.model.number_of_rect>0):
        a = rectangle(0)
        rec1 = obstacles.Rectangular(robot_controller.model,([a[0],a[1]]),a[2],a[3])
        #rec2 = obstacles.Rectangular(robot_controller.model,([a[4],a[5]]),a[6],a[7])
    if (robot_controller.model.number_of_circle>0):
        a = circle(0)
        circ = obstacles.Circular(robot_controller.model,([a[0],a[1]]),a[2])
    rect1 = rec1.plot()
    #rect2 = rec2.plot()
    #circl = circ.plot()
    ax.add_patch(rect1)
    #ax.add_patch(rect2)
    #ax.add_patch(circl)
    
    def update(i):
        # Plot robot
        arrow = example_models.robot_print(state_history,i)

        # Plot rectangles in space
        a = rectangle(i)
        rect1.set_width(a[2])
        rect1.set_height(a[3])
        rect1.set_xy([a[0],a[1]])
        #rect2.set_width(a[6])
        #rect2.set_height(a[7])
        #rect2.set_xy([a[4],a[5]])

        # Plot circles in space
        a = circle(i)
        #circl.set_radius(a[2])
        #circl.center = ([a[0],a[1]])

        return arrow,rect1#,rect2,circl

    if __name__ == '__main__':
        # FuncAnimation will call the 'update' function for each frame; here
        # animating over 10 frames, with an interval of 200ms between frames.
        anim = FuncAnimation(fig, update, frames=np.arange(0, number_of_steps), interval=200)
        if len(sys.argv) > 1 and sys.argv[1] == 'save':
            anim.save('Robot_1.gif', dpi=80, writer='imagemagick')
        else:
            # plt.show() will just loop the animation forever.
            plt.xlim([0, 1.6])
            plt.ylim([-0.5, 2.])
            plt.xlabel('x')
            plt.xlabel('y')
            plt.title('Robot')
            anim.save('Robot_1.gif', dpi=80, writer='imagemagick')
            plt.show()
