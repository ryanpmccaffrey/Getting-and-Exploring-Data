# Manually set working directory to "UCI HAR Dataset" folder 

training = read.csv("train/X_train.txt", sep="", header=FALSE)
training[,562] = read.csv("train/Y_train.txt", sep="", header=FALSE)
training[,563] = read.csv("train/subject_train.txt", sep="", header=FALSE)

testing = read.csv("test/X_test.txt", sep="", header=FALSE)
testing[,562] = read.csv("test/Y_test.txt", sep="", header=FALSE)
testing[,563] = read.csv("test/subject_test.txt", sep="", header=FALSE)

activityLabels = read.csv("activity_labels.txt", sep="", header=FALSE)
features = read.csv("features.txt", sep="", header=FALSE)

features[,2] = gsub("-mean", "Mean", features[,2])
features[,2] = gsub("-std", "Std", features[,2])
features[,2] = gsub("[-()]", '', features[,2])

# Combine training and testing datasets
combinedData=rbind(training,testing)

# Select only features with "Mean" and "Std" attributes
selectCols <- grep("Mean|Std",features[,2])
features <- features[selectCols,]

# Add two more columns for "Activity" and "Subject", then reduce dataset
selectCols <- c(selectCols, 562, 563)
combinedData <- combinedData[,selectCols]

# Add column names to dataset
colnames(combinedData) <- c(features$V2, "Activity", "Subject")
colnames(combinedData) <- tolower(colnames(combinedData))

count = 1
for (currentActivityLabel in activityLabels$V2) {
  combinedData$activity <- gsub(count, currentActivityLabel, combinedData$activity)
  count <- count + 1
}

combinedData$activity <- as.factor(combinedData$activity)
combinedData$subject <- as.factor(combinedData$subject)

tidy = aggregate(combinedData, by=list(activity = combinedData$activity, subject=combinedData$subject), mean)
tidy[,90] = NULL
tidy[,89] = NULL
write.table(tidy, "tidy.txt", sep="\t",row.name=FALSE)

