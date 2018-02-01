# We write a gradient descent code in R for finding the beta 
# parameters in a linear model

#Func: gradient.descent
# Purpose: Using the single.gradient.descent function, repeat it until
# the estimates change very little
# In: func(function), alpha (float), x_0 (float vector), b (float vector), y (float vector)
# Out: x* (float)
gradient.descent <- function(func, alpha, b,x,y,s){
  b <- c(b,s)
  b.prev <- b
  repeat{
    mv <- single.gradient.descent(func,alpha,b.prev[1:2],x,y,b[3])
    b <- b.prev + mv
    if(all(abs(func(b[1:2],x,y,b[3])-func(b.prev[1:2],x,y,b[3])) < 0.0001)){ #barely changed from prev iter.
      break
    }else{
      b.prev <- b
    }
  }
  b # Our optimal point
}

# Func: single.gradient.descent
# Purpose: Given a learning rate alpha and a point x_0, calculate the 
# negative gradient at x_0 times alpha and set our new point to 
# x_1 = x_0 -alpha*grad
# In: func (function), alpha (float), x_0 (float vector), b (float vector), y (float vector)
# Out: x_1 (float vector)
single.gradient.descent <- function(func, alpha, b,x,y,s){
  grad <- partial.derivative(func,b,x,y,s)

  #return - grad (steepest descent) * alpha (learning rate)
  #alpha*grad.avg
  alpha*grad
} 

  #Func: partial.derivative
  #Purpose: Given a function f(x) of some array x_i, i=1,..,n
  # return the array c(partial(x_1),partial(x_2),..,partial(x_3))
  # In: func (function), x(float vector), y,z
  # Out: p (float vector)
  partial.derivative <- function(func,b,x,y,s){
    epsilon <- 0.00001 # very small value close to 0
    #estimate the gradient using linear approximation
    b <- c(b,s)
    m <- length(b)
    p <- 1:m
    b.left <- b
    b.right <- b
    for(i in 1:m){
      #Set left and right points
      b.left[i] <- b[i] - epsilon
      b.right[i] <- b[i] + epsilon
      #approximate partial  
      
    }
    p <- (func(b.right[1:2],x,y,b.right[3]) - func(b.left[1:2],x,y,b.left[3]))/(2*epsilon) #vector of partial derivatives
    p
  
    }
  


