m = 10;
for j=1:m
    n = 100;
    t = linspace(0, 1, n+1);
    dt = 1 / n;
    dB = randn(n, 1) * sqrt(dt);
    B = zeros(n+1, 1);

    for i=1:n
        B(i+1) = B(i) + dB(i);
    end

    plot(t, B)
    hold on
end
hold off
