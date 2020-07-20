## --------------------------------------------------------------
## 1.Merges the training and the test sets to create one data set
## --------------------------------------------------------------

#Download dataset
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

#Unzip dataSet
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Read all files
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
features <- read.table('./data/UCI HAR Dataset/features.txt')
activity_labels = read.table('./data/UCI HAR Dataset/activity_labels.txt')

#Change column names
colnames(x_train) <- features[,2]
colnames(y_train) <-"activitylabel"
colnames(subject_train) <- "subjectlabel"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activitylabel"
colnames(subject_test) <- "subjectlabel"

colnames(activity_labels) <- c('activitylabel','activity')

#Merge Datasets
TrainMerge <- cbind(x_train, y_train, subject_train)
TestMerge <- cbind(x_test, y_test, subject_test)
DataAll <- rbind(TrainMerge, TestMerge)

## --------------------------------------------------------------
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## --------------------------------------------------------------

#read column Names
colNames <- colnames(DataAll)

#create relevant indexes
MeanSD <- (grepl("activitylabel" , colNames) |
             grepl("subjectlabel" , colNames) |
             grepl("mean.." , colNames) |
             grepl("std.." , colNames) )

DataAll2 <- DataAll[ , MeanSD == TRUE]

## --------------------------------------------------------------
## 3. Uses descriptive activity names to name the activities in the data set
## --------------------------------------------------------------

DataAll2 <- merge(DataAll2, activity_labels, by='activitylabel', all.x=TRUE)


## --------------------------------------------------------------
## 4. Appropriately labels the data set with descriptive variable names.
## --------------------------------------------------------------
names(DataAll2)<-gsub("Acc", "Accelerometer", names(DataAll2))
names(DataAll2)<-gsub("Gyro", "Gyroscope", names(DataAll2))
names(DataAll2)<-gsub("BodyBody", "Body", names(DataAll2))
names(DataAll2)<-gsub("Mag", "Magnitude", names(DataAll2))
names(DataAll2)<-gsub("^t", "Time", names(DataAll2))
names(DataAll2)<-gsub("^f", "Frequency", names(DataAll2))
names(DataAll2)<-gsub("tBody", "TimeBody", names(DataAll2))
names(DataAll2)<-gsub("-mean()", "Mean", names(DataAll2), ignore.case = TRUE)
names(DataAll2)<-gsub("-std()", "STD", names(DataAll2), ignore.case = TRUE)
names(DataAll2)<-gsub("-freq()", "Frequency", names(DataAll2), ignore.case = TRUE)
names(DataAll2)<-gsub("angle", "Angle", names(DataAll2))
names(DataAll2)<-gsub("gravity", "Gravity", names(DataAll2))

## --------------------------------------------------------------
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## --------------------------------------------------------------

library (dplyr)
TidyDataSet <- DataAll2
TidyDataSet <- group_by(TidyDataSet, subjectlabel, activity)

TidyDataSet <- summarise_all(TidyDataSet, funs(mean))
write.table(TidyDataSet, "TidyDataSet.txt", row.name=FALSE)
