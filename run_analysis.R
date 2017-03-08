## set the working directory and read the activitylabels into R (convert to the character).
setwd("C:/Users/ted/Desktop/coursera/R/lesson3/projectdata/UCI HAR Dataset")
activitylabels <- read.table("activity_labels.txt")
class(activitylabels[,2])
activitylabels[,2] <- as.character(activitylabels[,2])

## read the feature into R(convert to the character).
features <- read.table("features.txt")
class(features[,2])
features[,2] <- as.character(features[,2])

## find only mean or standard deviation in the feature.
measurements <- grep(".*mean.*|.*std.*",features[,2])
measurementnames <- features[measurements,2]

## read the training data into and column bind the data
xtrain <- read.table("train/X_train.txt")[measurements]
ytrain <- read.table("train/Y_train.txt")
subtrain <- read.table("train/subject_train.txt")
train <- cbind(subtrain,ytrain,xtrain)

## read the test data into R
xtest <- read.table("test/X_test.txt")[measurements]
ytest <- read.table("test/Y_test.txt")
subtest <- read.table("test/subject_test.txt")
test <- cbind(subtest,ytest,xtest)

## merge the train and test data
data <- rbind(train,test)
## names the subject and activity variable
library(reshape2)
colnames(data) <- c("subject","activity",measurementnames)
alldata <- melt(data, id = c("subject","activity"))
## count the mean of activity
alldatamean <- dcast(alldata, subject + activity ~ variable,mean)
## recode the number into character
alldatamean[,2][alldatamean[,2]==c(1,2,3,4,5,6)] <- c("WALKING","WALKING_UPSTAIRS",
                                                      "WALKING_DOWNSTAIRS","SITTING","STANDING",
                                                      "LAYING")
## save as the txt file
write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
