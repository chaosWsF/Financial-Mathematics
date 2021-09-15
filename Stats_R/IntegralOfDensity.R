## Graph of normal probabiliy density function, with comb of intervals.
meanval <- 0.0 # specify mean
sdval <- 0.2 # specify std
xlow <- meanval - 3 * sdval # specify low end of x-axis
xhigh <- meanval + 3 * sdval # specify high end of x-axis
dx <- 0.02 # specify min width of x-axis

x <- seq(from = xlow, to = xhigh, by = dx)
y <- (1 / (sdval * sqrt(2 * pi))) * exp(-.5 * ((x - meanval) / sdval)^2)

plot(x, y,
     type = "h", lwd = 1, cex.axis = 1.5,
     xlab = "x", ylab = "p(x)", cex.lab = 1.5,
     main = "Normal Probabiliy Density", cex.main = 1.5
)
lines(x, y)

area <- sum(dx * y)
text(-sdval, .9 * max(y), bquote(paste(mu, " = ", .(meanval))), adj = c(1, .5))
text(-sdval, .8 * max(y), bquote(paste(sigma, " = ", .(sdval))), adj = c(1, .5))
text(sdval, .9 * max(y), bquote(paste(Delta, "x = ", .(dx))), adj = c(0, .5))
text(sdval, .8 * max(y), bquote(
     paste(sum(, x, ), " ", Delta, "x p(x) = ", .(signif(area, 3)))
), adj = c(0, .5))
