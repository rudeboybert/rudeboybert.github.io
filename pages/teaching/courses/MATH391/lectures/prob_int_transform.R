# Plot PDF of a Exponential(rate=5) random variable
lambda <- 5
domain <- seq(0, 3, by=0.01)
par(mfrow=c(1,1))
plot(domain, dexp(domain, lambda), type="l", main="PDF of a Exponential(rate=5) RV",
     xlab="x", ylab="f(x)", col="red", lwd=2)

# Simulate Uniform(0,1)
n <- 10^7
y <- runif(n)
par(mfrow=c(1,1))
hist(y, prob=TRUE, main="PDF of Y ~ Unif(0, 1)")

# Define inverse CDF
Finv <- function(u, rate) {
  -log(1-u)/rate
}

# Compare both simulations
par(mfrow=c(1,2))
hist(Finv(y, lambda), prob=TRUE, main="Exp(5) Sim'd using F^-1(y)", xlim=c(0,3),
     xlab="x", ylab="f(x)", breaks=30)
lines(domain, dexp(domain, 5), col="red", lwd=2)
hist(rexp(n, lambda), prob=TRUE, main="Exp(5) Sim'd Directly", xlim=c(0,3),
     xlab="x", ylab="f(x)", breaks=30)
lines(domain, dexp(domain, 5), col="red", lwd=2)

