
# Read in BreastCancer.csv
bcData <- read.csv('BreastCancer.csv')
K <- 10 #10-fold cross validation
nr <- nrow()
misclassified = numeric(K)
#split dataset into K equal parts
for(i in 1:K){
  #Connect terms 1,..,i-1,i+1,..,K
  testSet = ceiling(((i-1)*(nr/K)+1)):ceiling(((i-1)*(nr/K)+(nr/K)))
  test <- bcData[testSet,]
  train <- bcData[-testSet,]
  
  #Fits the train data to a binomial or sigmoid
  bc.fit <- glm(Class ~ ., family = 'binomial', data = train)
  
  #bc.fit probabilities of test set
  bc.probs <- predict(bc.fit,newdata=test, type = "response")
  
  #binary classifier, 0.5 threshold
  bc.preds <- ifelse(bc.probs > 0.5, 1, 0)
  
  #dataframe of prediction
  bc.df <- data.frame(pred = bc.preds, true = test$Class) #pred and fit are column names
  #results
  bc.t <- table(bc.df)
  falseNeg <- bc.t[1,2] / (bc.t[1,2] + bc.t[1,1])
  falsePos <- bc.t[2,1] / (bc.t[2,1] + bc.t[2,2])
  misclassified[i] <- (bc.t[1,2] + bc.t[2,1])/sum(bc.t)
}
# From the K test partitions, calculate the mean
mean(misclassified)
