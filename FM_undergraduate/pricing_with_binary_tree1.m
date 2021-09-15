function pricing_with_binary_tree1(S0, K, T, r, n, sigma)
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
    V(n+1, :) = max(K - S(n+1, :), 0);    % put option
    % V(n+1, :) = max(S(n+1, :) - K, 0);    % call option
    for j=n:-1:1
        for k=1:j
            V1 = K - S(j, k);    % put option
            % V1 = S(j, k) - K;   % call option
            V2 = exp(-r*t)*(p*V(j+1, k)+(1-p)*V(j+1, k+1));
            V(j, k) = max(V1, V2);
            if V1 > V2
                fprintf("%d,%d exercise\n", j, k)
            end
        end
    end
    disp(V)
end
