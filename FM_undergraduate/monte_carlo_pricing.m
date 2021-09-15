m = 10000;
% m = 100;
n = 100;
mu = 0.01;
r = 0.03;
sigma = 0.5;
T = 1;
S0 = 100;
K = 95;

t = linspace(0, T, n+1);
dt = T / n;
dB = randn(n, m) * sqrt(dt);
S = zeros(n+1, m);
S(1, :) = S0;

for i=1:n
    S(i+1, :) = S(i, :) + mu * S(i, :) * dt + sigma * S(i, :) .* dB(i, :);
end

V = max(S(n+1, :)-K, 0) * exp(-r*T);
muV = mean(V);
stdV = std(V);
c1 = muV - 1.96 * stdV / sqrt(m);
c2 = muV + 1.96 * stdV / sqrt(m);
fprintf("Option price: %f\n", muV)
fprintf("95\% Conf Int [%f, %f]\n", c1, c2)
