## load package for functions
library(plyr)



## only download the file, if it is not yet downloaded to save time and storage space
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
    download.file(fileURL, filename, method="curl")
}

## only unzip if file is not yet there to save storage space
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

## set working directory in new folder
setwd("./UCI HAR Dataset")



##Reading Data

training_values         <- read.table("train/X_train.txt")
training_activities     <- read.table("train/y_train.txt")
training_subjects       <- read.table("train/subject_train.txt")

test_values             <- read.table("test/X_test.txt")
test_activities         <- read.table("test/y_test.txt")
test_subjects           <- read.table("test/subject_test.txt")

features                <- read.table("features.txt", as.is = TRUE)
colnames(features)      <- c("FeatureId", "featureLabel")

activities              <- read.table("activity_labels.txt")
colnames(activities)    <- c("activityId", "activityLabel")


## 1. Merging the test and the train sets, to build one data set named: data
## To keep the information if it was initially training or test, a new coloumn is added:


trainingframe           <- cbind(training_activities,training_values,training_subjects,c("Training"))
colnamestraining        <- colnames(trainingframe)
colnamestraining        <- replace(colnamestraining, 564, "group")
colnames(trainingframe) <- colnamestraining

testframe               <- cbind(test_activities,test_values,test_subjects,c("Test"))
colnamestest            <- colnames(testframe)
colnamestest            <- replace(colnamestest, 564, "group")
colnames(testframe)     <- colnamestest

data                    <- rbind(trainingframe,testframe)

## assign column names
colnames(data) <- c("subject", features[, 2], "activity", "group")



## 2. Only the measurements on the mean and standard deviation for each measurement are needed:

columns <- grepl("subject|activity|mean|std", colnames(data))
data <- data[, columns]



## 3.Now that the data set shrunk down, activityLevels are replaced with descriptive names for the activities:
data$activity <- factor(data$activity, 
                            levels = activities[, 1], labels = activities[, 2])


## 4. Appropriately label the data set with descriptive variable names:

datacolumnnames <- colnames(data)
datacolumnnames <- gsub("[\\(\\)-]", "", datacolumnnames)

## now to make the column names more readable:
datacolumnnames <- gsub("^f", "frequency", datacolumnnames)
datacolumnnames <- gsub("^t", "time", datacolumnnames)
datacolumnnames <- gsub("Acc", "Accelerometer", datacolumnnames)
datacolumnnames <- gsub("Gyro", "Gyroscope", datacolumnnames)
datacolumnnames <- gsub("Mag", "Magnitude", datacolumnnames)
datacolumnnames <- gsub("Freq", "Frequency", datacolumnnames)
datacolumnnames <- gsub("mean", "Mean", datacolumnnames)
datacolumnnames <- gsub("std", "StandardDeviation", datacolumnnames)

colnames(data) <- datacolumnnames


## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.


## averaging columns 2:67 while having 68 columns:
## first column is the subject and the last the activity. We need the average of every column except those two.

meandata <- ddply(data, .(subject, activity), function(x) colMeans(x[, 2:67]))

write.table(meandata, "tidydata.txt", row.name=FALSE)

## setting working directory back to where it was before running the script.
setwd("./..")