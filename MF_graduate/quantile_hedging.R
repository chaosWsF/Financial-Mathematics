quantile_hedging <- function(mu, r, T, S0, K, sigma, epsilon) {
  alpha <- (mu - r) / (sigma ^ 2)
  if (alpha <= 1) {
    y1 <- (log(S0 / K) + sigma ^ 2 / 2 * T) / (sigma * sqrt(T))
    y2 <- y1 - sigma * sqrt(T)
    b <- qnorm(1 - epsilon) * sqrt(T) + (mu - r) / sigma * T
    y3 <- sigma * sqrt(T)
    y4 <- -b / sqrt(T)
    x0 <- S0 * (pnorm(y1) - pnorm(y3 + y4)) - K * exp(-r * T) * (pnorm(y2) - 
                                                                   pnorm(y4))
    return(list(
      "b" = b,
      "x0" = x0
    ))
  } else {
    print("Unusual")
  }
}
