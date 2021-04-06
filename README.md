# gcdwk4
2
# Getting and Cleaning Data Week 4 Assigment
3
This repository contains the submission for the assigment of week 4 of Getting and Cleaning Data Coursera course.
4
- First, download and unzip the datafile into your R working directory
5
- Second, download and execute the "run_analysis.R" file
6
- Finally, execute the code to get the tidy data file "Tidydata.txt" in your working directory
7
​
8
# Data description
9
The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. The variable in the data Y indicates activity type the subjects performed during recording.
10
​
11
# Code explanation
12
The code combined training dataset and test dataset, and extracted partial variables to create another dataset with the averages of each variable for each activity.
13
​
14
# New dataset
15
The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.
16
​
17
The code was written based on the instruction of this assignment
18
​
19
The R script called "run_analysis.R" does the following:
20
- Merges the training and the test sets to create one data set.
21
- Extracts only the measurements on the mean and standard deviation for each measurement. 
22
- Uses descriptive activity names to name the activities in the data set
23
- Appropriately labels the data set with descriptive variable names. 
24
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
