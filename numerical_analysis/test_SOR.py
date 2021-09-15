from report6_codes import linearSys
import numpy as np
from numpy.linalg import norm

A = np.array([
        [-1, 0, 0, np.sqrt(2)/2, 1, 0, 0, 0], 
        [0, -1, 0, np.sqrt(2)/2, 0, 0, 0, 0],
        [0, 0, -1, 0, 0, 0, .5, 0],
        [0, 0, 0, -np.sqrt(2)/2, 0, -1, -.5, 0],
        [0, 0, 0, 0, -1, 0, 0, 1],
        [0, 0, 0, 0, 0, 1, 0, 0],
        [0, 0, 0, -np.sqrt(2)/2, 0, 0, np.sqrt(3)/2, 0],
        [0, 0, 0, 0, 0, 0, -np.sqrt(3)/2, -1]
    ])
b = np.array([0, 0, 0, 0, 0, 10000, 0, 0])
sol = linearSys(A, b)

XO = np.ones([8, 1])
N = 30
TOL = 1e-2

# print('SOR:', sol.SOR(XO, N, TOL, 1.25))

for w in range(0, 21):
    w = w / 10
    x = sol.SOR(XO, N, TOL, w)
    print(w, norm(A.dot(x) - b, np.inf))