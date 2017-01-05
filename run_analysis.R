## Load required packages

library(dplyr)
library(data.table)
library(reshape2)
##setwd("D:/Desktop")

filename <- "getdata_dataset.zip"

##------------------------Download and unzip the dataset:--------------------------------------------
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}
##------------------------Loading activity and features information----------------------------------------
ActivityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
class(ActivityLabels$V1)
class(ActivityLabels$V2)
colnames(ActivityLabels) <- c('ActivityId','ActivityType')
## Change the second column from factor to character type
ActivityLabels[,2] <- as.character(ActivityLabels[,2])
Features <- read.table("UCI HAR Dataset/features.txt")
View(Features)
class(Features$V2)
## Change the second column from factor to character type
Features[,2] <- as.character(Features[,2])
unique(Features$V2)
## Extracting only the mean and std related information
featuresimpt <- grep(".*mean.*|.*std.*", Features[,2])
## Get the column names of the indices thrown out by grep(indicating mean and std related fields)
featuresimpt.names <- Features[featuresimpt,2]


#-------------------------Reading the training datasets------------------------------------------------
train <- read.table("UCI HAR Dataset/train/X_train.txt")
trainA <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainS <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(train) <- Features[,2] 
colnames(trainA) <-"ActivityId"
colnames(trainS) <- "SubjectId"
train_final <- cbind(trainS, trainA, train)
View(train_final)

#-------------------------Reading the testing datasets----------------------------------------------------
test <- read.table("UCI HAR Dataset/test/X_test.txt")
testA <- read.table("UCI HAR Dataset/test/Y_test.txt")
testS <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(test) <- Features[,2] 
colnames(testA) <-"ActivityId"
colnames(testS) <- "SubjectId"
test_final <- cbind(testS, testA, test)
View(test_final)

## Merging training and testing data together and re-labelling everything
Final_Data <- rbind(train_final, test_final)
## Filter only those columns in the final dataset, which have mean or std in them as in the variable featuresimpt.names
feature_label <- c("SubjectId","ActivityId",featuresimpt.names)
Final_Data <- Final_Data[,feature_label]
View(Final_Data)

## Export!
write.table(Final_Data, "tidy_final.txt", row.names = FALSE, quote = FALSE)
