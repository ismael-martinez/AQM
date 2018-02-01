library(tidyverse)
library(reshape2)

#print working directory, find out where 
getwd()

#set working directory

setwd("/Users/dharuravi/Documents/StatLearning")

# use ?function() in console below for more information about anything.

#read in data
adsdata <- read.csv("Advertising.csv")

#look at first few records 
head(adsdata)

#or last few records
tail(adsdata)

str(adsdata)

ncol(adsdata)

nrow(adsdata)

#generate some visulizations 
ggplot(data=adsdata) +
  geom_point(mapping = aes(x=adsdata$TV, y=adsdata$Sales))

ggplot(data=adsdata) +
  geom_point(mapping = aes(x=adsdata$Radio, y=adsdata$Sales))

ggplot(data=adsdata) +
  geom_point(mapping = aes(x=adsdata$Newspaper, y=adsdata$Sales))

#all together

#split up columns 
radio     <- adsdata$Radio
tv        <- adsdata$TV
newspaper <- adsdata$Newspaper
sales <- adsdata$Sales
count <- adsdata$X

#create data frame 
adexp <- data.frame(radio, tv, newspaper, sales)

#create long-form of data
adexp.m <- melt(adexp, id.vars = "sales", measure.vars = c("radio", "tv", "newspaper"))

#break up columns again
xval <- adexp.m$value
yval <- adexp.m$sales
factors <- adexp.m$variable

#one plot to rule them all
ggplot(data = adexp.m) +
    geom_point(mapping = aes(x = xval, y=yval, color = factors)) +
    theme_bw()


#-----------------------------------------------------
#another example belowwhere visualizations are really useful

#read mpg dataset which exists in the packadge 
mpg

#make a scatterplot
ggplot(data=mpg) + 
  geom_point(mapping = aes(x=displ, y= hwy))

#find number of columns in dataset
ncol(mpg)

#find number of rows in dataset
nrow(mpg)

#add color levels to the scatterplot
ggplot(data=mpg) + 
  geom_point(mapping = aes(x=displ, y= hwy, color = class))

#different asthetics 

#alpha asthetic controls transparancey of the plots
ggplot(data=mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, alpha = class))

#shape asthetic controls the shape of each point
ggplot(data=mpg) +
  geom_point(mapping = aes(x=displ, y=hwy, shape = class))
#------------------------------------------------------------
# Back to the Ads data
# Simple linear regression

# lm(y~x, data = yourdata)
lmSalesRadio <- lm(adsdata$Sales ~ adsdata$Radio, data = adsdata)

# get confidence intervals for coefficient estimates
confint(lmSalesRadio)

# Regression output 
summary(lmSalesRadio)


