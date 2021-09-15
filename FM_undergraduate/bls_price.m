r = 0.03;
sigma = 0.5;
S0 = 100;
T = 1;
K = 95;

d1 = (log(S0/K) + (r+0.5*sigma^2)*T) / (sigma*sqrt(T));
d2 = (log(S0/K) + (r-0.5*sigma^2)*T) / (sigma*sqrt(T));

c = S0 * normcdf(d1) - K * exp(-r * T) * normcdf(d2);
disp(c)
c0 = blsprice(S0, K, r, 1, 0.5);
disp(c0)