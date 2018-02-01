# Run classification on the Breast Cancer dataset
# Given a set of data, we want to classify the output y
# as either a 0 (benign) or a 1 (malignant)

bc.fulldata <- read.csv("breastcancer.csv")
bc.data <- bc.fulldata[ ,-1] # all rows, all - 1st column ('-' means subtract)

#fit the data to a sigmoid or "binomial" family glm

# '.' means all columns (except Y)
bc.fit <- glm(Class~., family="binomial",data=bc.data)

summary(bc.fit) 

# predict classification probabilties
bc.probs <- predict(bc.fit, type = "response") #response gives probabilities

#binary classifier
bc.pred <- ifelse(bc.probs > 0.5, 1, 0) 

# the 'y' variable, regardless of name
# The dataframe below has the classification for every indexed point
# 'pred' and 'true' are the names of the table columns
bc.df <- data.frame(pred = bc.pred, true = bc.fit$y) 

#Results in a table (want 0,0 and 1,1)
table(bc.df)
