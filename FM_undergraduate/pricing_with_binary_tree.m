function pricing_with_binary_tree(S0, K, T, r, n, sigma)
    S = zeros(n+1, n+1);
    S(1, 1) = S0;
    t = T / n;
    u = exp(sigma * sqrt(t));
    d = 1 / u;
    p = (exp(r*t) - d) / (u - d);
    for i=1:n
        S(i+1, 1) = S(i, 1) * u;
        S(i+1, 2:i+1) = S(i, 1:i) * d;
    end
    V(n+1, :) = max(K - S(n+1, :), 0);
    for j=n:-1:1
        V(j, 1:j) = max(K - S(j, 1:j), exp(-r*t)*(p*V(j+1, 1:j)+(1-p)*V(j+1, 2:j+1)));
    end
%     disp(S)
    disp(V)
end
    