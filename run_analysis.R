##1. You should create one R script called run_analysis.R that does the following. 
library(plyr)
#Set working directory
setwd("C:/Users/USER/Desktop/Coursera/Getting Cleaning Data/UCI HAR Dataset")

#Get training dataset
x_train <- read.table("./train/X_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
y_train <- read.table("./train/y_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)

#Get testing dataset
x_test <- read.table("./test/X_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
y_test <- read.table("./test/y_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)

#Get training and testing subjects
subject_train <- read.table("./train/subject_train.txt", header=FALSE, sep="", stringsAsFactors=FALSE)
subject_test <- read.table("./test/subject_test.txt", header=FALSE, sep="", stringsAsFactors=FALSE)


#Get activity labels
activity_labels <- read.table("activity_labels.txt", header=FALSE, sep="", stringsAsFactors=FALSE)

#Get features
features <- read.table("features.txt", header=FALSE, sep="", stringsAsFactors=FALSE)


##2. Merges the training and the test sets to create one data set.

#Combine train and test datasets, apply column names from features and add subject column
xy_train <- cbind(x_train, y_train)
xy_test <- cbind(x_test, y_test)
xy_all <- rbind(xy_train, xy_test)

#add column names
colnames(xy_all) <- c(features$V2, "activity_code")



##3. Extracts only the measurements on the mean and standard deviation for each measurement. 

xy_all <- xy_all[, c(grep("mean", colnames(xy_all), fixed=TRUE), grep("std", colnames(xy_all), fixed=TRUE), grep("activity_code", colnames(xy_all), fixed=TRUE))]


##4. Uses descriptive activity names to name the activities in the data set
##and
##5. Appropriately labels the data set with descriptive variable names. 

#Combine subject data sets and add to xy_all
subject_all <- rbind(subject_train, subject_test)
xy_all$subject <- subject_all$V1

#Add descriptive col names to activity_labels and join into dataset
colnames(activity_labels) = c("activity_code", "activity")
xy_all <- join(xy_all, activity_labels, by="activity_code")


##6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

xy_all_mean <- ddply(xy_all, .(subject, activity), numcolwise(mean))
write.csv(xy_all_mean, file='tidy_data.txt')