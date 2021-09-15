% m = 10;
m = 20;
n = 100;
mu = 0.01;
sigma = 0.5;
t = linspace(0, 1, n+1);
dt = 1 / n;
dB = randn(n, m) * sqrt(dt);
S = zeros(n+1, m);
S(1, :) = 100;

for i=1:n
    S(i+1, :) = S(i, :) + mu * S(i, :) * dt + sigma * S(i, :) .* dB(i, :);
end

plot(t, S)
