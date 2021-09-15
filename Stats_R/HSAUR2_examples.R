for (i in 1:length(meandiffs)) {
  sy <- sample(y)
  meandiffs[i] <- mean(sy[feet]) - mean(sy[metre])
}

cmh_test(classification ~ treatment,
  data = Lanza,
  scores = list(classification = c(0, 1, 6, 17, 30)),
  subset = Lanza$study == "IV"
)

p <- cmh_test(classification ~ treatment,
  data = Lanza,
  scores = list(classification = c(0, 1, 6, 17, 30)),
  subset = Lanza$study == "II", distribution =
    approximate(B = 19999)
)

cmh_test(classification ~ treatment | study,
  data = Lanza,
  scores = list(classification = c(0, 1, 6, 17, 30))
)

anomalies <- c(
  235, 23, 3, 0, 41, 35, 8, 0,
  20, 11, 11, 1, 2, 1, 3, 1
)

clouds_formula <- rainfall ~ seeding +
  seeding:(sne + cloudcover + prewetness + echomotion) +
  time

plot(clouds_fitted, clouds_resid,
  xlab = "Fitted values",
  ylab = "Residuals", type = "n",
  ylim = max(abs(clouds_resid)) * c(-1, 1)
)
abline(h = 0, lty = 2)
text(clouds_fitted, clouds_resid, labels = rownames(clouds))



layout(matrix(1:2, ncol = 2))
plot(y ~ x, data = hubble)
curve(predict(hmod2, newdata = data.frame(x = x)), add = TRUE)
plot(hmod2, which = 1)

ggplot(hubble, aes(x = x, y = y)) + geom_point() + stat_smooth(se = F, method = "lm", formula = y ~ poly(x, 2))
