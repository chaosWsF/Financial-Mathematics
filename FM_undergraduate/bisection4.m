function bisection4(f, a, b, tol, num)

    if ~exist('tol', 'var') || isempty(tol)
        tol = 1e-6;
    end
    
    if ~exist('f', 'var') || isempty(f)
        f = @sin;
    end
    
    if ~exist('num', 'var') || isempty(num)
        num = 50;
    end
    
    if ~exist('a', 'var') || isempty(a)
        a = -1;
    end
    
    if ~exist('b', 'var') || isempty(b)
        b = 1;
    end
    
    if f(a) * f(b) >= 0
        disp("Please make sure f(a)*f(b)<0")
        return
    end

    c = (a + b) / 2;
    n = 1;

    while abs(f(c)) > tol && n <= num
        if f(a) * f(c) >0
            a = c;
        else
            b = c;
        end
        c = (a + b) / 2;
        n = n + 1;
    end

    if n > num
        disp("Not find the root.")
    else
        fprintf("The root of function is %f\n", c)
    end
    
