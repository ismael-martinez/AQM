#Question 3 - Interpretability
#Given a set of considerations, find the best marketing plan to optimize sales

adsdata <- read.csv("Advertising.csv")
#add a Budget col to the table
Budget <- rowSums(adsdata[2:4])
adsdata.bg <- cbind(adsdata,Budget)

#We look at the relationship between Budget and Sales
adsdata.bg.fit <- lm(Sales~Budget,data=adsdata.b)
ggplot(adsdata.bg) +
  geom_point(mapping=aes(x=adsdata.bg$Budget, y=adsdata.bg$Sales)) +
  geom_abline(slope=coef(adsdata.bg.fit)[2],intercept=coef(adsdata.bg.fit)[1])
#Yes, it is approximately linear with a slope of ~0.04869

#We look at the effect on sales each medium has
#TV
ggplot(adsdata.bg) +
  geom_point(mapping=aes(x=adsdata.bg$TV, y=adsdata.bg$Sales)) +
  geom_abline(slope=coef(lm(Sales~TV,data=adsdata.bg))[2],intercept=coef(lm(Sales~TV,data=adsdata.bg))[1])
#Radio
ggplot(adsdata.bg) +
  geom_point(mapping=aes(x=adsdata.bg$Radio, y=adsdata.bg$Sales)) +
  geom_abline(slope=coef(lm(Sales~Radio,data=adsdata.bg))[2],intercept=coef(lm(Sales~Radio,data=adsdata.bg))[1])
#Newspaper
ggplot(adsdata.bg) +
  geom_point(mapping=aes(x=adsdata.bg$Newspaper, y=adsdata.bg$Sales)) +
  geom_abline(slope=coef(lm(Sales~Newspaper,data=adsdata.bg))[2],intercept=coef(lm(Sales~Newspaper,data=adsdata.bg))[1])

#Look at the variance of each fit
lmTv <- lm(Sales~TV, data=adsdata.bg)
lmRadio <- lm(Sales~Radio, data=adsdata.bg)
lmNP <- lm(Sales~Newspaper, data=adsdata.bg)

lmTv.sd <- summary(lmTv)$coefficients[1:2,2]
lmRadio.sd <- summary(lmRadio)$coefficients[1:2,2]
lmNP.sd <- summary(lmNP)$coefficients[1:2,2]
 
lmMatrix.sd <- matrix(data=c(lmTv.sd, lmRadio.sd, lmNP.sd),ncol=2,byrow=TRUE)
rownames(lmMatrix.sd) <- c("Tv","Radio","Newspaper")
colnames(lmMatrix.sd) <- c("Intercept","Slope")

# We can see from the below matrix that TV has the lowest std dev 
# of the mediums for both Intercept at Slope
lmMatrix.sd


lmTv.b <- summary(lmTv)$coefficients[1:2,1]
lmRadio.b <- summary(lmRadio)$coefficients[1:2,1]
lmNP.b <- summary(lmNP)$coefficients[1:2,1]

lmMatrix.b <- matrix(data=c(lmTv.b, lmRadio.b, lmNP.b),ncol=2,byrow=TRUE)
rownames(lmMatrix.b) <- c("Tv","Radio","Newspaper")
colnames(lmMatrix.b) <- c("Intercept","Slope")

# We can also see the coefficients of the slope and intercept to see its
#effect on sales. We'll notice that Radio has the highest slope
lmMatrix.b

#As noted in class, Newspaper may be colinear with Tv and Sales,
#making the confidence interval for sd wider. By examining the 
#correlation matrix below, we see that Radio and Newspaper have a corr
#of 0.3, which could explain colinearity.
xcol <- adsdata[2:4]
cor(xcol)

adsdata.all.fit <- lm(Sales ~ TV + Radio + Newspaper, data = adsdata)
# TV = 149, Radio = 22, Newspaper = 25
sale1 <- data.frame(TV=149, Radio=22,Newspaper=25)
predict(adsdata.all.fit,sale1) 
#TV = 149, Radio = 60, Newspaper = 25
sale2 <- data.frame(TV=149, Radio=60,Newspaper=25)
predict(adsdata.all.fit,sale2) 
#TV = 155, Radio = 54, Newspaper = 25
sale3 <- data.frame(TV=155, Radio=54,Newspaper=25)
predict(adsdata.all.fit,sale3) 
#From our above coefficients, we seem to have a negative slope on Newspaper
# We don't want any of that
#Based on sale2 and 3, we want to maximize Radio

#We want to maximize data on on Radio, however we're missing a key piece
#which is that of exposure. That means, how many people will hear the ad
#on radio, how many will see on TV, how many will read. Given the data
#provided, we can only assume the exposure is equal for all three.

#Given this assumption, we want to allocate the full budget to Radio.

#However, this assumption is incorrect. The better way to do it is as follows:
#Given a budget of B, we find the amount of people who listen to the radio
#and the number of people who watch TV (we ignore NP since it has a neg rel)
#If the number of people who only watch TV is t, the people who only 
#listen to radio is r, and the people who both watch TV and listen to radio
#is tr, then we have a total exposure of t + tr + r. We then allocate the 
#budget as TV: (t/[t+tr+r])*B, Radio: ([t + tr]/[t+tr+r])*B