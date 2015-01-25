### Getting and Cleaning Data Project
rm(list = ls())

## Saving and unzipping project data
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./zipfile.zip")
files <- unzip("./zipfile.zip")

## Part 1: Merging Test and Train datasets after adding row and column labels

# Reading all necessary test and train datasets
Train_data <- read.table(files[27])
Train_testsubject <- read.table(files[26])
Train_activitynumber <- read.table(files[28])

Test_data <- read.table(files[15])
Test_testsubject <- read.table(files[14])
Test_activitynumber <- read.table(files[16])

# Adding colnames to train data, activity, test subject data sets
Names_main <- make.names(as.character(read.table(files[2])[,2]),unique=TRUE)
colnames(Train_data) <- Names_main

colnames(Train_testsubject) <- c("Test_Subject")

colnames(Train_activitynumber) <- c("Activity_Number")

# Merging Train Data
Train_Final <- cbind(Train_testsubject, Train_activitynumber, Train_data)

# Adding colnames to test data, activity, test subject data sets
colnames(Test_data) <- Names_main

colnames(Test_testsubject) <- c("Test_Subject")

colnames(Test_activitynumber) <- c("Activity_Number")

# Merging Test Data
Test_Final <- cbind(Test_testsubject, Test_activitynumber, Test_data)
rm(Test_data, Train_data, Test_testsubject, Test_activitynumber, Train_testsubject, Train_activitynumber)

# Merging Train and Test Data
Data <- rbind(Train_Final, Test_Final)
rm(Test_Final, Train_Final)

## Part 2: Selecting only mean and std columns from Data
# Load dplyr package
install.packages("dplyr")
library(dplyr)

#Selecting only mean and std to get required dataset
meanstd_data <- select(Data,Test_Subject, Activity_Number, contains("mean"), contains("std"))
rm(Data)

## Part 3: Changing Activity Numbers to Descriptive Activity Names
# Accessing the Activity Names lookup file
Lookup_Table <- read.table(files[1])
colnames(Lookup_Table) <- c("Activity_Number", "Activity_Name")

# Merging Activity Names with Activity Numbers in meanstd_data and removing activity numbers
ActivityNames_data <- merge(Lookup_Table, meanstd_data, all=TRUE)[,-1]

rm(meanstd_data, Lookup_Table)

## Part 4: Appropriately labeling the data set with descriptive data names
# *** Already performed in previous steps!***

## Part 5: Create new table with average mean and stddev values for each subject-activity combination
# Convert all numeric rows from character to numberic class
Converted_data <- data.frame(ActivityNames_data[,1:2],apply(ActivityNames_data[,3:88], 2, as.numeric))

# Install and load reshape package
install.packages("reshape2")
library(reshape2)

# Melt and cast Converted Data to get needed dataset
dataMelt <- melt(Converted_data, id=c("Activity_Name","Test_Subject") )
dataCast <- dcast(dataMelt, Activity_Name + Test_Subject ~  variable, mean)

rm(ActivityNames_data, dataMelt)

## Writing file to computer
write.table(dataCast, "./proj_data_mean.txt", row.name=FALSE, sep="\t")
