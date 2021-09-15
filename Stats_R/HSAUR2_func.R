rmse <- function(estimated.values, accurate.value) {
  error.rmse <- sqrt(mean((estimated.values - accurate.value)**2))
  return(error.rmse)
}

mae <- function(estimated.values, accurate.value) {
  error.mae <- mean(abs(estimated.values - accurate.value))
  return(error.mae)
}


sR <- function(used.data) {
  x <- used.data$x
  y <- used.data$y
  lmod <- lm(y ~ x - 1, data = used.data)
  beta <- coef(lmod)
  hatMat <- lm.influence(lmod)$hat
  r <- (y - beta * x) / (sd(beta * x) * sqrt(1 - hatMat))
  return(r)
}


## plot for womensrole in capter logistic regression
myplot <- function(role.fitted) {
  f <- womensrole$gender == "Female"
  plot(womensrole$education, role.fitted,
    type = "n",
    ylab = "Probability of agreeing",
    xlab = "Education", ylim = c(0, 1)
  )
  lines(womensrole$education[!f], role.fitted[!f], lty = 1)
  lines(womensrole$education[f], role.fitted[f], lty = 2)
  lgbtxt <- c("Fitted (Males)", "Fitted (Females)")
  legend("topright", lgbtxt, lty = 1:2, bty = "n")
  y <- womensrole$agree / (womensrole$agree +
    womensrole$disagree)
  text(womensrole$education, y, ifelse(f, "\\VE", "\\MA"),
    family = "HersheySerif", cex = 1.25
  )
}
