#Code Book
##The data source
-----------------------
For this Course Project we use smartphone data that was gathered to recognize human activity, i.e. walking, walking upstairs, walking downstairs, sitting, standing and laying. 
The original data can be downloaded at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The original description of the data set can be found at
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


##Data Set Information
-----------------------
To quote from the original description of the data set:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen here:
<a href="http://www.youtube.com/watch?feature=player_embedded&v=XOEN9W05_4A
" target="_blank"><img src="http://img.youtube.com/vi/XOEN9W05_4A/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>



##The original data
-----------------------

The files with the relevant variables and the descriptive files for this project are:

###Descriptive files
* "README.txt":  Information about the data set
* "features_info.txt":  Detailed information about the extracted features, including units
* "features.txt":  List of all features used for prediction
* "activity_labels.txt":  List of the activity names and their corresponding integer code

###Training Set (7352 observations)
* "train/subject_train.txt":  IDs from 21 of the 30 volunteers
* "train/y_train.txt":  target variable
* "train/X_train.txt":  predictor variables

###Test Set (2947 observations)
* "train/subject_test.txt":  IDs from 9 of the 30 volunteers
* "train/y_test.txt":  target variable
* "train/X_test.txt":  predictor variables


##The processed data
* "data":  The merged training and test set
* "meanANDstd": A subset of "data" that contains all variables that are a mean or standard deviation.
* "tidyData": Table that contains the mean of each variable in "meanANDstd" for each activity and each subject (=volunteer).
* "Tidy_Data.txt":  The tidyData table as text file.

