bounds_uncertainty_vol <- function(r, T, S0, K, sigma, eps, delta=0) {
  c <- bspricing(r, T, S0, K, sigma, delta)$call_price
  wid <- K * exp(-r * T) * eps * sqrt(T) / (2 * sigma) * dnorm(
    (log(S0 / K) + (r - sigma ^ 2 / 2) * T) / (sigma * sqrt(T))
  )
  return(list(
    "width" = wid,
    "interval" = c(c - wid, c + wid)
  ))
}
