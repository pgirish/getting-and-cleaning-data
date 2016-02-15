Getting and Cleaning Data: Course Project
Introduction

Goal: 
The goal of this project is to prepare tidy data.

Data:
The data for the project is from the below URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


I created a R script called run_analysis.R that does the following.
1. Merges the training and the test sets to create one data set.
Read all the test and training files: y_test.txt, subject_test.txt and X_test.txt.
Combine the files to a data frame in the form of subjects, labels, the rest of the data.We can use combine the respective data in training and test data sets corresponding to subject, activity and features. The results are stored in subject, activity and features.

2. Extracts only the measurements on the mean and standard deviation for each measurement.Read the features from features.txt and filter it to only leave features that are either means or standard deviations . A new data frame is then created that includes subjects, labels and the described features.

3. Uses descriptive activity names to name the activities in the data set
Read the activity labels from activity_labels.txt and replace the numbers with the text.

4. Appropriately labels the data set with descriptive activity names.

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.Write the new tidy set into a text file called tidy2.txt, formatted similarly to the original files.

Installed Packages:
Requires the plyr & reshape2 packages.


About the raw data

The UCI HAR Dataset must be extracted and..
The UCI HAR Dataset must be availble in a directory called "UCI HAR Dataset"


Lastly, the script will create a tidy data set containing the means of all the columns per test subject and per activity. This tidy dataset will be written to a tab-delimited file called tidy.txt, which can also be found in this repository.


