import numpy as np
from scipy.linalg import solve

# 8.1 5(3)
x1 = np.array([4.0, 4.2, 4.5, 4.7, 5.1, 5.5, 5.9, 6.3, 6.8, 7.1])
y1 = np.array([102.56, 113.18, 130.11, 142.05, 167.53, 195.14, 224.87, 256.73, 299.50, 326.72])
polyCoeff1 = np.polyfit(x1, y1, 3)
poly1 = np.poly1d(polyCoeff1)
error1 = np.sum((poly1(x1) - y1) ** 2)
print(poly1)
print(error1)

# 8.2 example1
A = np.array([
    [1, 1/2, 1/3],
    [1/2, 1/3, 1/4],
    [1/3, 1/4, 1/5]
])
b = np.array([2/np.pi, 1/np.pi, (np.pi**2 - 4)/(np.pi**3)])
polyCoeff2 = solve(A, b)[::-1]
poly2 = np.poly1d(polyCoeff2)
print(poly2)

