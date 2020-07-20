---
title: "CodeBook - Getting and Cleaning Data Project"
author: "Ivor"
date: "7/20/2020"
---

# Data

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


# Data Processing

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ```TidyDataSet.txt```

# Variables

Source files:  
```activity_labels``` = six activity codes and corresponding activity names  
```features``` = feature names for X_test, X_train  
```subject_test``` = test set subject number  
```X_test``` = test set feature measurements  
```y_test``` = test set activity  
```Subject_train``` = train set subject number  
```X_train``` = train set feature measurements  
```y_train``` = train set activity  

Combined data sets  
```TestMerge``` = ```subject_test```, ```y_test```, ```X_test``` combined, by columns  
```TrainMerge``` = ```subject_train```, ```y_train```, ```X_train``` combined, by columns  
```DataAll``` = ```TestMerge```, ```TrainMerge```, combined by rows  
```DataAll2``` = Subsetting ```DataAll``` relevant to Mean and Standard Deviation as described in column names  

TidyDataSet  
```TidyDataSet``` = data set with average of each variable, by activity, by subject  













