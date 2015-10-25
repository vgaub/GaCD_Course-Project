# Getting and Cleaning Data
##Course Project
----------------------------
This project deals with extracting and formating [smartphone data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) that was gathered to recognize human activity, i.e. walking, walking upstairs, walking downstairs, sitting, standing and laying. 

A short description of the survey is given at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


The task was to create an R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The presented solution requires the packages '''data.table''' and '''dplyr'''.


###1. Merges the training and test set to create one data set
----------------------------
After reading in the data we can use the functions cbind() and rbind() to merge the data from the traing and test set.
Afterwards we name the columns: The first column displays from which volunteer the data was gathered ("subject").
The second column contains the activity label, coded by an integer ("activity"). This is our target variable.
The other columns are the predictor variables whose names are stored in the file features.txt (feature_names).

```
training_set <- cbind(train_subject, train_y, train_x)
test_set <- cbind(test_subject, test_y, test_x)

data <- rbind(training_set, test_set)

feature_names <- as.character(read.table("./features.txt")[,2])
names(data) <- c("subject", "activity", feature_names)
```


###2. Extracts only the measurements on the mean and standard deviation for each measurement
----------------------------
Now we create a subset that we'll use for calculation later. Therefore I included the variables "subject" and "activity". To extract only variables that are means or standard deviations and to sort the subset by subjects I used the following R code:

```
meanANDstd <- cbind(data[,1:2],data[,grep('mean\\(\\)|std\\(\\)', names(data))])
meanANDstd <- arrange(meanANDstd, subject)
```


###3. Uses descriptive activity names to name the activities in the data set
----------------------------
We extract the activity labels, e.g. "walking", "sitting", from activity_labels.txt.
Next, we factorize the variable "activity" in the table "meanANDstd" and replace the levels 1, 2, etc. with "walking", "walking upstairs" etc.

```
activity_labels <- read.table("./activity_labels.txt")

meanANDstd$activity <- as.factor(meanANDstd$activity)
levels(meanANDstd$activity) <- activity_labels[,2]
```


###4. Appropriately labels the data set with descriptive variable names
----------------------------
Now we replace the abbreviations used in some variable names.

```
names(meanANDstd) <- gsub("^t", "time", names(meanANDstd))
names(meanANDstd) <- gsub("^f", "frequency", names(meanANDstd))
names(meanANDstd) <- gsub("Acc", "Acceleration", names(meanANDstd))
names(meanANDstd) <- gsub("Mag", "Magnitude", names(meanANDstd))
names(meanANDstd) <- gsub("Gyro", "Gyroscope", names(meanANDstd))
```


###5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
----------------------------
Finally, we calculate the mean as required and save the file as "Tidy_Data.txt".

```
tidyData <- data.table(meanANDstd)
tidyData <- tidyData[, lapply(.SD, mean), by = 'subject,activity']

write.table(tidyData, file = "Tidy_Data.txt", row.names = F)
```