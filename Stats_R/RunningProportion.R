## toss a coin N times and compute the running proportion of heads
## we set 'heads' = 1, 'tails' = 0

## if you want to reproduce the results, just uncomment the below
# set.seed(47405)

N <- 500
flipsequence <- sample(x = c(0, 1), prob = c(.5, .5), size = N, replace = TRUE)
r <- cumsum(flipsequence)
n <- 1:N
runprop <- r / n

plot(n, runprop,
     type = "o", log = "x",
     xlim = c(1, N), ylim = c(0.0, 1.0), cex.axis = 1.5,
     xlab = "Flip Number", ylab = "Proportion Heads", cex.lab = 1.5,
     main = "Running Proportion of Heads", cex.main = 1.5
)
lines(c(1, N), c(.5, .5), lty = 3)

# display flipsequence and results in the image
flipletters <- paste(c("T", "H")[flipsequence[1:10] + 1], collapse = "")
displaystring <- paste("Flip Sequence = ", flipletters, "...", sep = "")
text(5, .9, displaystring, adj = c(0, 1), cex = 1.3)
text(N, .3, paste("End Proportion =", runprop[N]), adj = c(1, 0), cex = 1.3)
