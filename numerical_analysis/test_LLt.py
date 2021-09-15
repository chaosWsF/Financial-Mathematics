from report5_codes import linearSys, array2latex
from time import perf_counter
import numpy as np

A = np.array([
    [4, 0, 2, 1],
    [0, 3, -1, 1],
    [2, -1, 6, 3],
    [1, 1, 3, 8]
])
x_actual = np.array([1, .5, -3, 2.3]).T
b = A.dot(x_actual)

print(array2latex(A))
print(x_actual)
print(b)

t0 = perf_counter()
testClass1 = linearSys(A, b)
print(testClass1.LU_Decompose()[0])
print('LU')
print('Spend time: %.5f seconds' % (perf_counter() - t0))

t0 = perf_counter()
testClass2 = linearSys(A, b)
print(testClass2.LLt_Decompose())
print('LLt')
print('Spend time: %.5f seconds' % (perf_counter() - t0))