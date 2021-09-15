%% cal area under sin(x) in [0, pi/2]
a = 0;
b = pi/2;
% n = 10;
n = 100;

% 1d
x1 = a + (b - a) * rand(1, n);
S1 = (b - a) * mean(sin(x1));

% 2d
x2 = a + (b - a) * rand(1, n);
y2 = rand(1, n);
m = sum(y2 <= sin(x2));
S2 = m / n * (b - a) * 1;

% dual
x31 = rand(1, n);
x32 = 1 - x31;
x3 = a + (b - a) * [x31, x32];
S3 = (b - a) * mean(sin(x3));

fprintf("num of simu: %d\n", n)
fprintf("1d result: %f\n", S1)
fprintf("2d result: %f\n", S2)
fprintf("dual variables: %f\n", S3)
