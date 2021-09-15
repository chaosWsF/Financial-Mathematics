leland_pricing <- function(r, T, S0, K, sigma, lambda, N, delta=0) {
  dt <- T / N
  sig_sq_tilde <- (sigma ^ 2) * (1 + lambda * sqrt(8 / (pi * dt * sigma ^ 2)))
  sig_tilde <- sqrt(sig_sq_tilde)
  c <- bspricing(r, T, S0, K, sig_tilde, delta)$call_price
  return(list(
    "sigma~2" = sig_sq_tilde,
    "call_price" = c
  ))
}
