import numpy as np
import matplotlib.pyplot as plt
import math

def robot_print(robot_states,step,color="r"):
    """ print out the states of a trailer """
    # trailer_states = np array of shape (number_of_states,number_of_steps)
    (number_of_states, number_of_steps) = np.shape(robot_states)
    size=0.01

    for i in range(0,step):
        x = robot_states[0,i]
        y = robot_states[1, i]
        dx = math.cos(robot_states[2, i])*size
        dy = math.sin(robot_states[2, i])*size

        plt.arrow(x, y, dx, dy, fc=color, ec=color, head_width=0.01, head_length=0.02)

if __name__ == '__main__':
    """ example when executed on its own """
    example = np.array([[0,0,math.pi/4],[0.5,0.5,math.pi/2]])

    plt.figure(0)
    robot_print(example.T,[0, 1],[0, 1])
