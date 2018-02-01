# This script uses the Gradient Descent code to maximize the 
# Maximum Likelihood probability function.

#Name: max.log.likelihood
#Purpose: Given a dataset of m observed points (x,y)
# calculate the optimal values b0, b1, s_sq to maximize
# the log.likelihood function
# In: y,x,b0,b1,s_sq (floats)
# Out: b (2item Float), s_sq* (floats)
max.log.likelihood <- function(b,x,y,s_sq){
  alpha <- 0.1
  param <- gradient.descent(log.likelihood,alpha,b,x,y,s_sq)
}

#Name: log.likelihood
#Purpose: Given a dataset of m observed points (x,y),
# calculate the log of the probability of observing the whole dataset
# subject to b0, b1, s_sq
# In: y, x, b (2item Float), s_sq (float)
# Out: log.likelihood (float)
log.likelihood <- function(b,x,y,s_sq){
  constant <- -length(x)/2 - log(2*pi) - length(x)*log(sqrt(s_sq))
  coef <- -1/(2*s_sq)
  sum.likelihood <- sum((y-b[1] - b[2]*x)^2)
  #Add them all together
  constant + coef*sum.likelihood
}

#Name: single.likelihood
#Purpose: For a single point, calculate the probability of observing the 
# response y given x, on the parameters b0, b1 and s_sq.
#In: y (float), x (float), b (2item floats), s_sq (float)
#Out: likelihood <- P(y | x;b0,b1,s_sq)
single.likelihood <- function(b,x,y,s_sq){
  residual <- y - b[1] - b[2]*x
  likelihood <- gaussian(residual,var = s_sq)
}

#Name: gaussian
#Purpose: For a given x, mu and variance, calculate
# the normal probability of observing x
# In: x, mu, var (floats)
# Out: P(x;mu,var)
gaussian <- function(x,mu=0,var=1){
  const <- 1/(sqrt(2*pi*var))
  exponent <- (x-mu)^2/(2*var)
  const*exp(-exponent)
}
