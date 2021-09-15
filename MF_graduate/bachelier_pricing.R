bachelier_pricing <- function(r, T, S0, K, sigma, eps=0) {
  # setting r = 0
  d <- (S0 - K) / (sigma * sqrt(T))
  c <- (S0 - K) * pnorm(d) + sigma * sqrt(T) * dnorm(d)
  p <- c - S0 + K
  
  wid <- eps / (2 * sigma) * sqrt(T) * dnorm(d)
  return(list(
    "call_price" = c, "put_price" = p, 
    "width" = wid,
    "call_interval" = c(c - wid, c + wid)
  ))
}
