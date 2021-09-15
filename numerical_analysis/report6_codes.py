import numpy as np
from numpy.linalg import norm


class linearSys:
    def __init__(self, A, b):
        self.A = A
        self.b = b
        self.n = b.shape[0]
        self.x = np.zeros([self.n, 1])
    
    def JacobiIterative(self, XO, N, TOL):
        k = 1
        while k <= N:
            for i in range(self.n):
                self.x[i, 0] = (self.b[i] - np.dot(self.A[i, :], XO[:, 0]) + self.A[i, i] * XO[i, 0]) / self.A[i, i]
            
            indicator = norm(self.x - XO)
            if indicator < TOL:
                return self.x.reshape((-1,))
            
            k += 1
            XO = self.x
        
        return 'Maximum number of iterations exceeded'
    
    def GaussSeidelIterative(self, XO, N, TOL):
        k = 1
        while k <= N:
            for i in range(self.n):
                self.x[i, 0] = (self.b[i] - np.dot(self.A[i, 0:i], self.x[0:i, 0]) - np.dot(self.A[i, i+1:], XO[i+1:, 0])) / self.A[i, i]
            
            indicator = norm(self.x - XO)
            if indicator < TOL:
                return self.x.reshape((-1,))
            
            k += 1
            XO = self.x
        
        return 'Maximum number of iterations exceeded'
        
    
    def SOR(self, XO, N, TOL, omiga):
        k = 1
        while k <= N:
            for i in range(self.n):
                self.x[i, 0] = (1 - omiga) * XO[i, 0] + omiga * (self.b[i] - np.dot(self.A[i, 0:i], self.x[0:i, 0]) - np.dot(self.A[i, i+1:], XO[i+1:, 0])) / self.A[i, i]
            
            indicator = norm(self.x - XO, np.inf)
            if indicator < TOL:
                return self.x.reshape((-1,))
            
            k += 1
            XO = self.x
        
        return 'Maximum number of iterations exceeded'


if __name__ == '__main__':
    # A = np.array([
    #     [10, -1, 2, 0], 
    #     [-1, 11, -1, 3],
    #     [2, -1, 10, -1],
    #     [0, 3, -1, 8]
    # ])
    # b = np.array([6, 25, -11, 15])
    # XO = np.zeros([4, 1])
    A = np.array([
        [4, 3, 0], 
        [3, 4, -1],
        [0, -1, 4]
    ])
    b = np.array([24, 30, -24])
    XO = np.ones([3, 1])
    N = 30
    TOL = 1e-6
    sol = linearSys(A, b)
    print('Jacobi:', sol.JacobiIterative(XO, N, TOL))
    print('Gauss-Seidel:', sol.GaussSeidelIterative(XO, N, TOL))
    print('SOR:', sol.SOR(XO, N, TOL, 1.241))