import numpy as np


class linearSys:
    def __init__(self, A, b):
        self.A = A
        self.b = b
        self.n = A.shape[0]
        self.L = np.eye(self.n)
        self.U = np.eye(self.n)
        self.x = np.zeros([self.n, 1])
        self.y = np.zeros([self.n, 1])
    
    def LU_Decompose(self):
        if self.A[0, 0] != 0:
            self.L[0, 0] = self.A[0, 0]
            self.U[0, 1:] = self.A[0, 1:] / self.L[0, 0]
            self.L[1:, 0] = self.A[1:, 0] / self.U[0, 0]
            for i in range(1, self.n - 1):
                self.L[i, i] = self.A[i, i] - np.dot(self.L[i, 0:i], self.U[0:i, i])
                if self.L[i, i] != 0:
                    self.U[i, i+1:] = (self.A[i, i+1:] - np.dot(self.L[i, 0:i], self.U[0:i, i+1:])) / self.L[i, i]
                    self.L[i+1:, i] = (self.A[i+1:, i] - np.dot(self.L[i+1:, 0:i], self.U[0:i, i])) / self.U[i, i]
                else:
                    return 'Factorization impossible at l{0}{0}'.format(i+1)
            
            self.L[-1, -1] = self.A[-1, -1] - np.dot(self.L[-1, 0:-1], self.U[0:-1, -1])
            if self.L[-1, -1] == 0:
                print('A is singular')
            
            self.y[0] = self.b[0] / self.L[0, 0]
            for i in range(1, self.n):
                self.y[i, 0] = (self.b[i] - np.dot(self.L[i, 0:i], self.y[0:i, 0])) / self.L[i, i]
            
            self.x[-1] = self.y[-1] / self.U[-1, -1]
            for i in range(self.n - 2, -1, -1):
                self.x[i, 0] = (self.y[i, 0] - np.dot(self.U[i, i+1:], self.x[i+1:, 0])) / self.U[i, i]
            
            return self.x, self.L, self.U
        else:
            return 'Factorization impossible at a11'

    def LLt_Decompose(self):
        self.L[0, 0] = np.sqrt(self.A[0, 0])
        self.L[1:, 0] = self.A[1:, 0] / self.L[0, 0]
        for i in range(1, self.n - 1):
            self.L[i, i] = np.sqrt(self.A[i, i] - np.sum(self.L[i, 0:i] ** 2))
            self.L[i+1:, i] = (self.A[i+1:, i] - np.sum(self.L[i+1:, 0:i] * self.L[i, 0:i], axis=1)) / self.L[i, i]
        self.L[-1, -1] = np.sqrt(self.A[-1, -1] - np.sum(self.L[-1, 0:-1] ** 2))
        self.y[0] = self.b[0] / self.L[0, 0]
        for i in range(1, self.n):
            self.y[i, 0] = (self.b[i] - np.dot(self.L[i, 0:i], self.y[0:i, 0])) / self.L[i, i]
        
        self.x[-1] = self.y[-1] / self.L[-1, -1]
        for i in range(self.n - 2, -1, -1):
            self.x[i, 0] = (self.y[i, 0] - np.dot(self.L[i+1:, i], self.x[i+1:, 0])) / self.L[i, i]
        
        return self.x


def array2latex(arr):
    s = ''
    for k in range(len(arr)):
        row = arr[k]
        if k < len(arr) - 1:
            s += ' & '.join(map(str, row)) + ' \\\\\n'
        else:
            s += ' & '.join(map(str, row))
    return s


if __name__ == '__main__':
    # A = np.array([[1,1,0,3], [2,1,-1,1], [3,-1,-1,2], [-1,2,3,-1]])
    # b = np.array([1, 1, -3, 4])
    A = np.array([[1,1,0,3], [2,1,-1,1], [3,-1,-1,2], [-1,2,3,-1]])
    b = np.array([8, 7, 14, -7])
    sol = linearSys(A, b)
    try:
        # x, L, U = sol.LU_Decompose()
        x, L, U = sol.LLt_Decompose()
        print('Solution:', x.T)
        print('L=\n', array2latex(L))
        print('U=\n', array2latex(U))
    except ValueError:
        print(sol.LU_Decompose())
