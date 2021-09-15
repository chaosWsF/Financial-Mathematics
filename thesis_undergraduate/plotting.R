library('ggplot2')
library('gridExtra')

ggplot(vix_total, aes(x = Date, y = VIX.Close)) + geom_line(colour = 'Blue') + 
    geom_hline(yintercept = 80, colour = 'Red', lty = 'dashed') + 
    xlab("日期") + ylab("VIX指数") + theme(panel.background = element_blank())

ggplot(vix, aes(x = date, y = r)) + geom_line() + xlab("日期") + ylab("对数收益率")

p1 <- ggplot(vix, aes(sample = r)) + stat_qq() + stat_qq_line() + xlab("理论值") + ylab("样本值")
p2 <- ggplot(vix, aes(y = r)) + geom_boxplot(outlier.shape = 1) + ylab("对数收益率")
grid.arrange(p1, p2, nrow = 1)

ggacf <- function(series) {
    # autocorrelation plot
    sig_level <- qnorm((1 + 0.95) / 2) / sqrt(sum(!is.na(series)))
    a <- acf(series, plot = FALSE)
    a.2 <- with(a, data.frame(lag, acf))
    g <- ggplot(a.2, aes(x = lag, y = acf)) + xlab('Lag') + ylab('ACF') + 
            geom_segment(aes(xend = lag, yend = 0), size = 1.5, colour = 'darkblue') + 
            geom_hline(yintercept = c(sig_level, -sig_level), lty = 'dashed', colour = 'red')
    
    # fix scale for integer lags
    if (all(a.2$lag %% 1 == 0)) {
        g <- g + scale_x_discrete(limits = seq(1, max(a.2$lag)))
    }
    return(g)
}
ggacf(vix$r)

ggplot(bsvol, aes(date, bsvol)) + geom_line() + xlab("日期") + ylab("波动率")

ggplot(hnvar, aes(date, hnvar)) + geom_line() + xlab("日期") + ylab("方差序列")
