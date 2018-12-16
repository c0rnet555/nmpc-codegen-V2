# import math
import casadi as cd
import numpy as np

class Robot_model:
    def system_equation(self,x,u):
        px_dot 	   = ( u[0]*np.cos(x[2]) )
        py_dot     = ( u[0]*np.sin(x[2]) )
        theta_dot  = ( u[1] )

        x_dot = cd.vertcat(px_dot, py_dot, theta_dot)

        return x_dot

def main():
    initial_state = np.array([0., 0., 0.])
    input         = np.array([1., 1.])

    rm            = Robot_model()
    robot         = rm.system_equation(initial_state, input)

    print(robot)

if __name__ == "__main__":
    main()

