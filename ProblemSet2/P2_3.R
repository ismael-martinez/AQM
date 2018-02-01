#1. 
# Read in BreastCancer.csv
bcData <- read.csv('BreastCancer.csv')

#Fits the data to a binomial or sigmoid
bc.fit <- glm(Class ~ ., family = 'binomial', data = bcData)

#bc.fit probabilities
bc.probs <- predict(bc.fit, type = "response")

#binary classifier, 0.5 threshold
bc.preds <- ifelse(bc.probs > 0.5, 1, 0)

#dataframe of prediction
bc.df <- data.frame(pred = bc.preds, true = bc.fit$y) #pred and fit are column names
#results
bc.t <- table(bc.df)
falseNeg <- bc.t[1,2] / (bc.t[1,2] + bc.t[1,1])
falsePos <- bc.t[2,1] / (bc.t[2,1] + bc.t[2,2])
misclassified <- (bc.t[1,2] + bc.t[2,1])/sum(bc.t)
