% a = -1;
% b = 2.134;
a = 1;
b = 4;
c = (a + b) / 2;
tol = 1e-6;
% num = 50;
num = 100;
n = 1;
while abs(sin(c)) > tol
    if sin(a) * sin(c) >0
        a = c;
    else
        b = c;
    end
    c = (a + b) / 2;
    n = n + 1;
    
    if n > num
        break
    end
end

disp(c)