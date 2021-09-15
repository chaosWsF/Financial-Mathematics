## error measures
rmse <- function(est, obs) sqrt(mean((est - obs) ^ 2))
mae <- function(est, obs) mean(abs(est - obs))
arpe <- function(est, obs) mean(abs((est - obs) / obs))
model_accu <- function(est, obs) {
    err_ind <- list(rmse, mae, arpe)
    res <- vector("double", length(err_ind))
    for (i in seq_along(err_ind)) {
        func <- err_ind[[i]]
        res[i] <- func(est, obs)
    }
    return(res)
}

## in-sample
in_sample <- function(est, obs, index) {
    res <- c(
        model_accu(est[!index], obs[!index]),
        model_accu(est[index], obs[index]),
        model_accu(est, obs)
    )
    matrix(res, nrow = 3, byrow = TRUE)
}

## bs
df <- inner_join(options, bsvol, by = 'date')
bs_est <- bsprice(df$vix, df$strike, df$maturity, df$bsvol, rf)
isdeep <- df$moneyness > 1.3
bs_results <- in_sample(bs_est, df$price, isdeep)
# write.table(bs_results, 'clipboard', sep = '\t', row.names = FALSE, col.names = FALSE)

## hn
df <- inner_join(options, hnvar, by = 'date')
hn_est <- hnprice(df$vix, df$hnvar, df$strike, df$maturity)
isdeep <- df$moneyness > 1.3
hn_results <- in_sample(hn_est, df$price, isdeep)
# write.table(hn_results, 'clipboard', sep = '\t', row.names = FALSE, col.names = FALSE)

## out-of-sample
df <- inner_join(options, hnvar, by = 'date')
hn_est_oos <- hnprice(df$vix, df$hnvar, df$strike, df$maturity)
df$est <- hn_est_oos
mat_cols <- list(1:in_sample_period, (in_sample_period+1):n, 1:n)
hn_results_oos <- matrix(0, 3, 3)
for (i in seq_along(mat_cols)) {
    subdf <- df[mat_cols[[i]],]
    subdf1 <- filter(subdf, moneyness <= 1.3)
    subdf2 <- filter(subdf, moneyness > 1.3)
    hn_results_oos[, i] <- c(
        rmse(subdf1$est, subdf1$price), 
        rmse(subdf2$est, subdf2$price), 
        rmse(subdf$est, subdf$price)
    )
}
# write.table(hn_results_oos, 'clipboard', sep = '\t', row.names = FALSE, col.names = FALSE)
