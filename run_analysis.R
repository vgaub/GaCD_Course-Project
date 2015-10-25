'1. Merges the training and the test sets to create one data set.'
library(dplyr)
library(data.table)

#Loading data
train_subject <- read.table("./train/subject_train.txt", header = F)
train_x <- read.table("./train/X_train.txt", header = F)
train_y <- read.table("./train/Y_train.txt", header = F)

test_subject <- read.table("./test/subject_test.txt", header = F)
test_x <- read.table("./test/X_test.txt", header = F)
test_y <- read.table("./test/Y_test.txt", header = F)

training_set <- cbind(train_subject, train_y, train_x)
test_set <- cbind(test_subject, test_y, test_x)

#Merging training and test set and also renaming columns
data <- rbind(training_set, test_set)

feature_names <- as.character(read.table("./features.txt")[,2])
names(data) <- c("subject", "activity", feature_names)


'2. Extracts only the measurements on the mean and standard deviation 
for each measurement.' 
meanANDstd <- cbind(data[,1:2],data[,grep('mean\\(\\)|std\\(\\)', names(data))])
meanANDstd <- arrange(meanANDstd, subject)


'3. Uses descriptive activity names to name the activities in the data set'
activity_labels <- read.table("./activity_labels.txt")

meanANDstd$activity <- as.factor(meanANDstd$activity)
levels(meanANDstd$activity) <- activity_labels[,2]


'4. Appropriately labels the data set with descriptive variable names.'
names(meanANDstd) <- gsub("^t", "time", names(meanANDstd))
names(meanANDstd) <- gsub("^f", "frequency", names(meanANDstd))
names(meanANDstd) <- gsub("Acc", "Acceleration", names(meanANDstd))
names(meanANDstd) <- gsub("Mag", "Magnitude", names(meanANDstd))
names(meanANDstd) <- gsub("Gyro", "Gyroscope", names(meanANDstd))


'5. From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.'
tidyData <- data.table(meanANDstd)
tidyData <- tidyData[, lapply(.SD, mean), by = 'subject,activity']

write.table(tidyData, file = "Tidy_Data.txt", row.names = F, sep = "\t")