bspricing <- function(r, T, S0, K, sigma, delta=0) {
  S0 <- S0 * exp(-delta * T)
  K <- K * exp(-r * T)
  
  y1 <- (log(S0 / K) + sigma ^ 2 / 2 * T) / (sigma * sqrt(T))
  y2 <- y1 - sigma * sqrt(T)
  
  p1 <- pnorm(y1)
  p2 <- pnorm(y2)
  
  c <- S0 * p1 - K * p2
  p <- c - S0 + K
  
  return(list(
    "call_price" = c, "put_price" = p,
    "Phi(y+)" = p1, "Phi(y-)" = p2,
    "y+" = y1, "y-" = y2
  ))
}
