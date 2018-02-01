# Problem 2- Optimization
# implement gradient descienct and apply to Advertising dataset

adsdata <- read.csv("Advertising.csv")
x <- data.matrix(adsdata[2:4])
y <- data.matrix(adsdata[5])
b <- min.RSS(x,y)
