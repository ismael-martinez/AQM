#1. 
# Read in BreastCancer.csv
bcData <- read.csv('BreastCancer.csv')

#Split the data 70/30 into Training and Test set
set.seed(53) # Set Seed so that same sample can be reproduced in future also
# Now Selecting 70% of data as sample from total 'n' rows of the data  
sample <- sample.int(n = nrow(bcData), size = floor(.70*nrow(bcData)), replace = F)
bcTrain <- bcData[sample, ]
bcTest  <- bcData[-sample, ]

#Fits the train data to a binomial or sigmoid
bc.fit <- glm(Class ~ ., family = 'binomial', data = bcTrain)

#bc.fit probabilities of test set
bc.probs <- predict(bc.fit,newdata=bcTest, type = "response")

#binary classifier, 0.5 threshold
bc.preds <- ifelse(bc.probs > 0.5, 1, 0)

#dataframe of prediction
bc.df <- data.frame(pred = bc.preds, true = bcTest$Class) #pred and fit are column names
#results
bc.t <- table(bc.df)
falseNeg <- bc.t[1,2] / (bc.t[1,2] + bc.t[1,1])
falsePos <- bc.t[2,1] / (bc.t[2,1] + bc.t[2,2])
misclassified <- (bc.t[1,2] + bc.t[2,1])/sum(bc.t)
