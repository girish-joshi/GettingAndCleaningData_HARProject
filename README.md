# GettingAndCleaningData_HARProject
This repository contains file related to Project submission for Getting and Cleaning Data (https://class.coursera.org/getdata-011) course project

The objective of this task is to recreate the UCI HAR data from a Training and Test set.
The R code is in file named run_analysis.R
The code contains a function named run_analysis() which processes the UCI HAR data and returns a Data Frame which has summary statistics (mean) for the the variable and for each subject and for each Activity. A detailed description of the UCI HAR data is available in the Readme.txt file in the UCI HAR folder.

To run this file in R, one needs to change the R working directory to the same directory in which the UCI HAR data folder is present. It is assumed that the folder "UCI HAR Dataset" is present in the working directory which has the various files such as features.txt, activity_labels.txt etc and the test and the train folders.

The detials of the function run_analysis() are as below:
Step 1 - Finds out a list of features of interest, i.e. only those feature names containing either a "-mean()" or a "-std()" in the name are selected.
Step 2 - Train data is read only for those columns of interest into 3 separate data frames for X, y and Subject. These 3 data frames are then merged into a single Train data frame using cbind()
Step 3 - Test data is read only for those columns of interest into 3 separate data frames for X, y and Subject. These 3 data frames are then merged into a single Test data frame using cbind()
Step 4 - Train and Test data frames are then merged using rbind()
Step 5 - This data from step 4 is then joined (using merge() function) on the ActivityID to get Activity Names
Step 6 - The descriptive names for the variables selected in Step 1 are then applied on the data frame from Step 5
Step 7 - On the data frame from Step 6, summary statistic of "mean" is computed for each of the 30 Subjects and for each of the 6 activities. This is done using aggregate() function

Finally the data frame from step 7 is returned to the callee.







