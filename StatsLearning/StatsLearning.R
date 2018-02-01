library(tidyverse)
library(reshape2)

#print out working directory
getwd()

#set a new working directory
dir.create("StatsLearning")
setwd("C:/Users/Ismael Martinez/Desktop/AQM/StatsLearning")

#read in advertising data
adsdata <- read.csv("Advertising.csv")

#first few (head) or last few (tail)
head(adsdata)
tail(adsdata)

#structure
str(adsdata)

#number of rows and number of columns
nrow(adsdata)
ncol(adsdata)

#generate some visualization
#ggplot is the plot, + adds the two functions
# and geom_point defines the points
# aes is aesthetic mapping
# table$col
ggplot(data=adsdata) +  #+ must be after first function, not before sec.
  geom_point(mapping = aes(x=adsdata$Radio, y=adsdata$Sales))

ggplot(data=adsdata) +
  geom_point(mapping = aes(x=adsdata$Newspaper, y=adsdata$Sales))

ggplot(data=adsdata) + 
  geom_point(mapping = aes(x=adsdata$TV, y = adsdata$Sales))

#all together

#split up columns

radio <- adsdata$Radio
tv <- adsdata$TV
print <- adsdata$Newspaper
sales <- adsdata$Sales
count <- adsdata$X #X is the index of the row

#create a dataframe with all above points
adsdata_df <- data.frame(radio,tv,print,sales,count)
#create long form of the data
#melt() turns data into molten data frame
adsdata_df.m <- melt(data=adsdata_df,id.vars="sales", measure.vars=c("radio","tv","print"))

#separate columns again
xval <- adsdata_df.m$value
yval <- adsdata_df.m$sales
factors <- adsdata_df.m$variable

#plot all together
ggplot(data=adsdata_df.m) +
  geom_point(mapping=aes(x=xval,y=yval, color=factors)) +
  theme_bw() #theme of non-data display

#---------------------------------------------------
#Second stats visualization example

#read in mpg dataset built-in to R, fuel economy [1999,2008]
mpg

#plot scatterplot
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ,y=hwy))

#print cols and rows in dataset
ncol(mpg)
nrow(mpg)

#add color to 'class'
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ,y=hwy,color=class))

#different aesthetics

#alpha aes control transparency (looks bw)
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ,y=hwy,alpha=class))

#shape aes changes each class to a different shape
ggplot(data=mpg) +
  geom_point(mapping=aes(x=displ,y=hwy,shape=class))

#------------------------------------------------
#returning to adsdata, we do linear regression

# Simple Linear Regression
# lm(y~x,data=mydata) lm stands for linear model
lmSalesRadio <- lm(adsdata$Sales~adsdata$Radio,data=adsdata)
lmAll <- lm(sales ~ value,data=adsdata_df.m) 

#get confidence interval of estimates
confint(lmSalesRadio)

#regression output
summary(lmSalesRadio)

#---------------------------------------------------------
#Let's try to plot the TV points with its linear model line
# attach(adsdata) will remove the need to call the table
lmTV <- lm(adsdata$Sales~adsdata$TV, data=adsdata)
ggplot(data=adsdata) +
  geom_point(mapping=aes(x=adsdata$TV,y=adsdata$Sales)) + 
  geom_abline(slope = coef(lmTV)[2], intercept = coef(lmTV)[1],color="blue")
#plots points with linear model2

