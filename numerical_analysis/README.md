# Numerical-Analysis

## Report 1: Solutions of Equations in One Variable

- Newton's
- Horner's
  - Newton + polynomial evaluation
- Muller's
  - replace secant method with parabola (three initial values)
  - complex roots

## Report 2: Interpolation and Polynomial Approximation

interpolation; the approximation of a complicated function by a simple function

- Newton’s Divided-Difference Formula
- Hermite Polynomials Using Divided Differences
- spline curves (piecewise polynomial)
  - Runge’s phenomenon (oscillate erratically)
  - cubic spline

## Report 3: Numerical Differentiation and Integration

- Composite Simpson's Rule
- Romberg Integration
- Composite Gaussian Quadrature
    - Gaussian-Legendre ploynominal

## Report 4: Initial-Value Problems for Ordinary Differential Equations

- Runge-Kutta Method
- Multistep
- Stiff ODE

## Report 5: Direct Methods for Solving Linear Systems

`array2latex`

- LU factorization
- LLT factorization
- Band Matrix
- `scipy.linalg.solve`

## Report 6: Iterative Techniques in Matrix Algebra

solving linear systems iteratively

`numpy.linalg.norm`

- Jacobi Method
- Gauss-Seidel Method
- SOR Method

## Report 7: Approximation Theory

approximate functions or discrete data

- Discrete Least Squares Approximation
  - `numpy.polyfit`
- Hilbert matrix for continuous functions
  - `scipy.linalg.solve`
- Orthogonal Polynominals
  - Legendre ploynominals
  - Chebyshev Polynominals
  - `from numpy.polynomial import *`
