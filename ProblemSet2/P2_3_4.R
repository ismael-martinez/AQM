
# Read in BreastCancer.csv
bcData <- read.csv('BreastCancer.csv')
K_ind <- c(2,3,4,5,10,20,30,40,50,100,233,350)
#train_error <- numeric(length(K_ind))
#test_error <- numeric(length(K_ind))
train_error <- c()
test_error <- c()
nr <- nrow(bcData)
for(K in K_ind){
  misclassified.test = numeric(K)
  misclassified.train = numeric(K)
  #split dataset into K equal parts
  for(i in 1:K){
    #Connect terms 1,..,i-1,i+1,..,K
    testSet = ceiling(((i-1)*(nr/K)+1)):ceiling(((i-1)*(nr/K)+(nr/K)))
    test <- bcData[testSet,]
    train <- bcData[-testSet,]
    
    #Fits the train data to a binomial or sigmoid
    bc.fit <- glm(Class ~ ., family = 'binomial', data = train)
    
    #bc.fit probabilities of test set
    bc.probs.test <- predict(bc.fit,newdata=test, type = "response")
    bc.probs.train <- predict(bc.fit,newdata=train,type = "response")
    #binary classifier, 0.5 threshold
    bc.preds.test <- ifelse(bc.probs.test > 0.5, 1, 0)
    bc.preds.train <- ifelse(bc.probs.train > 0.5, 1, 0)
    
    #dataframe of prediction
    bc.df.test <- data.frame(pred = bc.preds.test, true = test$Class) #pred and fit are column names
    bc.df.test <- rbind(bc.df.test,c(1,1),c(0,0))
    bc.df.train <- data.frame(pred = bc.preds.train, true = train$Class) #pred and fit are column names
    bc.df.train <- rbind(bc.df.train,c(1,1),c(0,0))
    #results
    #add one positive then remove it after to avoid edge case
    bc.t.test <- table(bc.df.test)
    bc.t.train <- table(bc.df.train)
    misclassified.test[i] <- (bc.t.test[1,2] + bc.t.test[2,1])/(sum(bc.t.test)-2)
    misclassified.train[i] <- (bc.t.train[1,2] + bc.t.train[2,1])/(sum(bc.t.test)-2)
  }
  # From the K test partitions, calculate the mean
  print(length(misclassified.test))
  test_error <- c(test_error,mean(misclassified.test))
  train_error <- c(train_error,mean(misclassified.train))
}
max(test_error)
min(test_error)
max(train_error)
min(train_error)


plot(K_ind,test_error,col="blue",ylim=c(0,11))
points(K_ind,train_error,col="red",ylim=c(0.,11.))
