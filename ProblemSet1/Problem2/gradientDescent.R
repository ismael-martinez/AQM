# We write a gradient descent code in R for finding the beta 
# parameters in a linear model

#Func: gradient.descent
# Purpose: Using the single.gradient.descent function, repeat it until
# the estimates change very little
# In: func(function), alpha (float), x_0 (float vector), b (float vector), y (float vector)
# Out: x* (float)
gradient.descent <- function(func, alpha, x,y,z){
  x.prev <- x
  repeat{
    mv <- single.gradient.descent(func,alpha,x.prev,y,z)
    x <- x.prev + mv
    if(abs(func(x,y,z)-func(x.prev,y,z)) < 0.0001){ #barely changed from prev iter.
      break
    }else{
      x.prev <- x
    }
  }
  x # Our optimal point
}

# Func: single.gradient.descent
# Purpose: Given a learning rate alpha and a point x_0, calculate the 
# negative gradient at x_0 times alpha and set our new point to 
# x_1 = x_0 -alpha*grad
# In: func (function), alpha (float), x_0 (float vector), b (float vector), y (float vector)
# Out: x_1 (float vector)
single.gradient.descent <- function(func, alpha, x,y,z){
  grad <- partial.derivative(func,x,y,z)

  #return - grad (steepest descent) * alpha (learning rate)
  #-alpha*grad.avg
  -alpha*grad
} 

  #Func: partial.derivative
  #Purpose: Given a function f(x) of some array x_i, i=1,..,n
  # return the array c(partial(x_1),partial(x_2),..,partial(x_3))
  # In: func (function), x(float vector), y,z
  # Out: p (float vector)
  partial.derivative <- function(func,x,y,z){
    epsilon <- 0.00001 # very small value close to 0
    #estimate the gradient using linear approximation
    m <- length(x)
    p <- 1:m
    for(i in 1:m){
      #Set left and right points
      x.left <- x 
      x.left[i] <- x[i] - epsilon
      x.right <- x
      x.right[i] <- x[i] + epsilon  
      #approximate partial  
      p[i] <- (func(x.right,y,z) - func(x.left,y,z))/(2*epsilon)
    }
    p #vector of partial derivatives
  }
  
}

