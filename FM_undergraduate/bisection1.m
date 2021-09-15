% a = -1;
% b = 2.134;
% a = 1;
% b = 4;
a = 1;
b = 2;

if sin(a) * sin(b) > 0
    disp("Please make sure f(a)*f(b)<0")
    return
end

c = (a + b) / 2;
tol = 1e-6;
num = 50;
% num = 100;
n = 1;

while abs(sin(c)) > tol && n <= num
    if sin(a) * sin(c) >0
        a = c;
    else
        b = c;
    end
    c = (a + b) / 2;
    n = n + 1;
end

fprintf("The root of sine function is %f\n", c)