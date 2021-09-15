# Example for Alphabet Inc. (GOOG)
current_date <- as.Date("2021-04-09")
expiry_date <- as.Date("2021-04-30")
T2M <- as.vector(expiry_date - current_date) / 365
S <- 2285.88
K <- 2230
imv <- 33.79 / 100
rf <- 1.662 / 100
c_actual <- 102.03

c <- bspricing(rf, T2M, S, K, imv)$call_price

tmp <- bachelier_pricing(0, T2M, S, K, imv*S, 0.02)
bspricing(0, T2M, S, K, imv)$call_price
bounds_uncertainty_vol(0, T2M, S, K, imv, 0.02)

# Risk measure, March 26
xs <- c(
  33, 128, 6, 267, -82, -38,
  123, 217, -78, 327, 22, 126, 
  43, -73, -208, 137, -46, -205,
  202, 40
)
lambda <- 0.02
mu <- mean(xs)
sigma <- sd(xs)

q <- qnorm(lambda)
VaR_xs <- -(mu + q * sigma)
# -(47.05 + 145.10 * (-2.054))

x0 <- mu + q * sigma
AVaR_xs <- ((x0 - mu) * lambda + sigma * dnorm(q)) / lambda - x0
# 47.05 + 145.10 * (-2.054)
# ((-250.985 - 47.05) * pnorm(-2.054) + 145.10 * dnorm(-2.054)) / lambda + 250.985

xs <- c(
  0.0051,
  0.0247, -0.0123, 0.0316, -0.0075, 0.0119, 0.0048, -0.0096, 0.0167, 0.0075
)
lambda <- 0.05
mu <- mean(xs)
sigma <- sd(xs)

q <- qnorm(lambda)
VaR_xs <- -(mu + q * sigma)
# -(47.05 + 145.10 * (-2.054))

x0 <- mu + q * sigma
AVaR_xs <- ((x0 - mu) * lambda + sigma * dnorm(q)) / lambda - x0
