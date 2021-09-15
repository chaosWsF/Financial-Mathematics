# in_sample_period <- n
in_sample_period <- 756

## fit garch model
hngarch <- function(a, b, c, w, lambda, index = in_sample_period) {
    v_t <- vector("double", index + 1)
    v_t[1] <- var(r[1:index])
    for (i in seq(1, index)) {
        v_t[i+1] <- w + b * v_t[i] + 
            a * (r[i] - rf - lambda * v_t[i] - c * v_t[i]) ^ 2 / v_t[i]
    }
    return(v_t[-1])
}

hn_minuslogl <- function(params) {
    a <- params[1]
    b <- params[2]
    c <- params[3]
    w <- params[4]
    lambda <- params[5]
    v_t <- hngarch(a, b, c, w, lambda)
    r_t <- r[1:length(v_t)]
    sum(log(v_t) + (r_t - rf - lambda * v_t) ^ 2 / v_t)
}

# init_par <- c(7.46e-6, 8.001e-1, 10, 3.402e-5, 3.308)
# init_par <- c(7.46e-6, 8.001e-1, -5, 3.402e-5, 3.217)
# init_par <- c(7.46e-6, 0.5, -5, 3.402e-4, 2.1)
# init_par <- c(7.46e-6, 0.4, -5, 3.402e-4, 2.1)
init_par <- c(5e-3, 0.4, -5, 3.402e-4, 2.1)

opt_info <- nlm(hn_minuslogl, init_par)
params <- opt_info$estimate
hnlogl <- -0.5 * (opt_info$minimum + in_sample_period * log(2 * pi))
# write.table(c(params, hnlogl), 'clipboard', sep = '\t', row.names = FALSE, col.names = FALSE)
v_t <- hngarch(params[1], params[2], params[3], params[4], params[5], index = n)
hnvar <- data.frame(date = vix$date, hnvar = v_t)

## option pricing formula
phi_star <- function(u, S, v, tau) {
    a <- params[1]
    b <- params[2]
    c <- params[3] + params[5] + 0.5
    w <- params[4]
    lambda <- -0.5

    A <- 0i
    B <- 0i
    for (j in seq(1, tau)) {
        A <- A + 1i * u * rf + w * B - 0.5 * log(1 - 2 * a * B)
        B <- 1i * u * (lambda + c) - 0.5 * c ^ 2 + b * B + (1i * u - c) ^ 2 / (2 * (1 - 2 * a * B))
    }

    (S ^ (1i * u)) * exp(A + B * v)
}

integrand <- function(u, S, v, K, tau) {
    phi1 <- K ^ (-1i * u) * phi_star(u-1i, S, v, tau) / (1i * u)
    phi2 <- K ^ (-1i * u) * phi_star(u, S, v, tau) / (1i * u)
    Re(phi1) - K * Re(phi2)
}
inj <- function(S, v, K, tau) {
    # integrate(integrand, lower = 0, upper = Inf, S = S, v = v, K = K, tau = tau)$value
    integrate(integrand, lower = 0, upper = 1000, S = S, v = v, K = K, tau = tau)$value
}
v.inj <- Vectorize(inj)

hnprice <- function(S, v, K, tau) {
    0.5 * (S - K * exp(-rf * tau)) + exp(-rf * tau) / pi * v.inj(S, v, K, tau)
}
