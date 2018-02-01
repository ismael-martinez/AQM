# For a given true set Y and an estimate set Y_hat = X'b, 
# return the values of b that minimizes the sum of squares

#Func: min.RSS 
#Purpose: To calculate the b values that produce the minimum RSS
#In: b (float vector), x (float 2D vector), y (float vector)
#Out: b* (float vector)
min.RSS <- function(x,y){
  b <- coef(lm(Sales~TV + Radio + Newspaper,data=adsdata))+1 #initial guess is important
  b <- gradient.descent(RSS,0.0001,b,x,y)
  b
}

#Func: RSS
#Purpose: To calculate the RSS of a function and its estimate
#In: b (float vector), x (float 2D vector), y (float vector)
#Out: RSS (float)
RSS <- function(b,x,y){
  res <- residual(b,x,y)
  sum(res^2)
}

#Func: residual
#Purpose: For a single point, find the residual given b
#In: y(float), x(float vector), b (float vector)
#Out: Residual (float)
residual <- function(b,x,y){
  x.extend <- cbind(1,x) #add a 1 to multiply again b_0
  y - x.extend%*%b
}
