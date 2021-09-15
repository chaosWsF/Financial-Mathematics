## volatility estimation
nweeks <- ceiling(n / 5)
bsvol <- vector("double", nweeks)
for (i in seq(1, nweeks)) {
    if (5 * i <= n) {
        bsvol[i] <- sd(r[(5*i-4):(5*i)])
    } else {
        bsvol[i] <- sd(r[(5*i-4):n])
    }
}
bsvol <- rep(bsvol, c(rep(5, nweeks - 1), n %% 5))
bsvol <- data.frame(date = vix$date, bsvol = bsvol)

## bs pricing formula
bsprice <- function(S, K, tau, sigma, r) {
    d1 <- (log(S / K) + (r + 0.5 * sigma ^ 2) * tau) / (sigma * sqrt(tau))
    d2 <- d1 - sigma * sqrt(tau)
    S * pnorm(d1) - K * exp(-r * tau) * pnorm(d2)
}