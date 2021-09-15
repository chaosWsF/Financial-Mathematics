m = 100;
n = 100;
L = 100;

mu = 0.01;
sigma = 0.5;
r = 0.03;
T = 1;
S0 = 100;
K = 95;

t = linspace(0, T, n+1);
dt = T / n;
muV = zeros(L, 1);

for j=1:L
    S = zeros(n+1, m);
    S(1, :) = S0;
    dB = randn(n, m) * sqrt(dt);
    for i=1:n
        S(i+1, :) = S(i, :) + mu * S(i, :) * dt + sigma * S(i, :) .* dB(i, :);
    end
    V = max(S(n+1, :)-K, 0) * exp(-r*T);
    muV(j) = mean(V);
end

hist(muV)
