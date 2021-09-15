#%%
import numpy as np

#%%
# runge-kutta (order four)
# 5.4.1.b
def func1(t, y):
    return 1 + (t - y) ** 2


def sol1(t):
    return t + 1 / (1 - t)

a = 2
b = 3
N = 10
alpha = 1

h = (b - a) / N
t = a
w = alpha
y = sol1(t)
error = abs(y - w)
print('{0:.1f} & {1:.7f} & {2:.7f} & {3} \\\\'.format(t, y, w, error))

for _ in range(N):
    K_1 = h * func1(t, w)
    K_2 = h * func1(t + h / 2, w + K_1 / 2)
    K_3 = h * func1(t + h / 2, w + K_2 / 2)
    K_4 = h * func1(t + h, w + K_3)
    w += (K_1 + 2*K_2 + 2*K_3 + K_4) / 6
    t += h
    y = sol1(t)
    error = abs(y - w)
    print('{0:.1f} & {1:.7f} & {2:.7f} & {3:.7f} \\\\'.format(t, y, w, error))

# 2.0 & 1.0000000 & 1.0000000 & 0.0 \\
# 2.1 & 1.1909091 & 1.1909088 & 0.0000003 \\
# 2.2 & 1.3666667 & 1.3666663 & 0.0000004 \\
# 2.3 & 1.5307692 & 1.5307688 & 0.0000004 \\
# 2.4 & 1.6857143 & 1.6857138 & 0.0000004 \\
# 2.5 & 1.8333333 & 1.8333329 & 0.0000004 \\
# 2.6 & 1.9750000 & 1.9749996 & 0.0000004 \\
# 2.7 & 2.1117647 & 2.1117643 & 0.0000004 \\
# 2.8 & 2.2444444 & 2.2444441 & 0.0000003 \\
# 2.9 & 2.3736842 & 2.3736839 & 0.0000003 \\
# 3.0 & 2.5000000 & 2.4999997 & 0.0000003 \\

#%%
# runge-kutta 4-4
# 5.6.1.c
def func2(t, y):
    return 1 + y / t


def sol2(t):
    return t * np.log(t) + 2 * t

a = 1
b = 2
N = 10
alpha = 2

h = (b - a) / N
t = a
w = alpha
y = sol2(t)
error = abs(y - w)
print('{0:.1f} & {1:.7f} & {2:.7f} & {3} \\\\'.format(t, y, w, error))

tLi = [t]
wLi = [w]
for _ in range(3):
    K_1 = h * func2(t, w)
    K_2 = h * func2(t + h / 2, w + K_1 / 2)
    K_3 = h * func2(t + h / 2, w + K_2 / 2)
    K_4 = h * func2(t + h, w + K_3)
    w += (K_1 + 2*K_2 + 2*K_3 + K_4) / 6
    t += h

    tLi.append(t)
    wLi.append(w)

    y = sol2(t)
    error = abs(y - w)
    print('{0:.1f} & {1:.7f} & {2:.7f} & {3:.7f} \\\\'.format(t, y, w, error))

for _ in range(3, N):
    t += h
    w = wLi[3] + h * (55 * func2(tLi[3], wLi[3]) - 59 * func2(tLi[2], wLi[2]) + 37 * func2(tLi[1], wLi[1]) - 9 * func2(tLi[0], wLi[0])) / 24
    w = wLi[3] + h * (9 * func2(t, w) + 19 * func2(tLi[3], wLi[3]) - 5 * func2(tLi[2], wLi[2]) + func2(tLi[1], wLi[1])) / 24
    y = sol2(t)
    error = abs(y - w)
    print('{0:.1f} & {1:.7f} & {2:.7f} & {3:.7f} \\\\'.format(t, y, w, error))
    
    tLi.pop(0)
    wLi.pop(0)
    tLi.append(t)
    wLi.append(w)

# 1.0 & 2.0000000 & 2.0000000 & 0.0 \\
# 1.1 & 2.3048412 & 2.3048409 & 0.0000003 \\
# 1.2 & 2.6187859 & 2.6187854 & 0.0000005 \\
# 1.3 & 2.9410735 & 2.9410729 & 0.0000007 \\
# 1.4 & 3.2710611 & 3.2710601 & 0.0000010 \\
# 1.5 & 3.6081977 & 3.6081963 & 0.0000014 \\
# 1.6 & 3.9520058 & 3.9520041 & 0.0000017 \\
# 1.7 & 4.3020680 & 4.3020661 & 0.0000020 \\
# 1.8 & 4.6580160 & 4.6580138 & 0.0000022 \\
# 1.9 & 5.0195224 & 5.0195199 & 0.0000025 \\
# 2.0 & 5.3862944 & 5.3862917 & 0.0000027 \\

#%%
# stiff
# 5.11.1.b
def func3(t, y):
    return -20 * (y - t ** 2) + 2 * t


def func3dy(t, y):
    return -20


def sol3(t):
    return t ** 2 + (1 / 3) * np.exp(-20 * t)

a = 0
b = 1
N = 10
alpha = 1 / 3
TOL = 1e-6
M = 10

h = (b - a) / N
t = a
w = alpha
y = sol3(t)
error = abs(y - w)
print('{0:.1f} & {1:.7f} & {2:.7f} & {3} \\\\'.format(t, y, w, error))

for _ in range(N):
    k_1 = w + h * func3(t, w) / 2
    w_0 = k_1
    j = 1
    FLAG = 0
    while FLAG == 0 and j <= M:
        w = w_0 - (w_0 - h * func3(t + h, w_0) / 2 - k_1) / (1 - h * func3dy(t+h, w_0) / 2)
        if abs(w - w_0) < TOL:
            FLAG = 1
        else:
            j += 1
            w_0 = w
    
    if j > M:
        print('The maxmum number of iterations exceeded')
    
    t += h
    y = sol3(t)
    error = abs(y - w)
    print('{0:.1f} & {1:.7f} & {2:.7f} & {3:.7f} \\\\'.format(t, y, w, error))

# 0.0 & 0.3333333 & 0.3333333 & 0.0 \\
# 0.1 & 0.0551118 & 0.0100000 & 0.0451118 \\
# 0.2 & 0.0461052 & 0.0400000 & 0.0061052 \\
# 0.3 & 0.0908263 & 0.0900000 & 0.0008263 \\
# 0.4 & 0.1601118 & 0.1600000 & 0.0001118 \\
# 0.5 & 0.2500151 & 0.2500000 & 0.0000151 \\
# 0.6 & 0.3600020 & 0.3600000 & 0.0000020 \\
# 0.7 & 0.4900003 & 0.4900000 & 0.0000003 \\
# 0.8 & 0.6400000 & 0.6400000 & 0.0000000 \\
# 0.9 & 0.8100000 & 0.8100000 & 0.0000000 \\
# 1.0 & 1.0000000 & 1.0000000 & 0.0000000 \\