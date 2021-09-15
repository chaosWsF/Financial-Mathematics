from report5_codes import linearSys
from time import perf_counter
import numpy as np


A1 = np.array([
    [2, 3, -1, .5, 1],
    [3, 2, 4, -3, 2],
    [-1, 4, 2, 1, -.5],
    [.5, -3, 1, 2, 1],
    [1, 2, -.5, 1, 2]
])
A2 = np.array([
    [2, 3, -1, .5, 0],
    [3, 2, 4, -3, 2],
    [-1, 4, 2, 1, -.5],
    [.5, -3, 1, 2, 1],
    [0, 2, -.5, 1, 2]
])
A3 = np.array([
    [2, 3, -1, 0, 0],
    [3, 2, 4, -3, 0],
    [-1, 4, 2, 1, -.5],
    [0, -3, 1, 2, 1],
    [0, 0, -.5, 1, 2]
])
A4 = np.array([
    [2, 3, 0, 0, 0],
    [3, 2, 4, 0, 0],
    [0, 4, 2, 1, 0],
    [0, 0, 1, 2, 1],
    [0, 0, 0, 1, 2]
])

x_actual = np.array([1., 1., 1., 1., 1.]).T
AList = [A1, A2, A3, A4]

for A in AList:
    b = A.dot(x_actual)
    t0 = perf_counter()
    testClass = linearSys(A, b)
    x, _, _ = testClass.LU_Decompose()
    print(A)
    print('Spend time: %.5f seconds' % (perf_counter() - t0))