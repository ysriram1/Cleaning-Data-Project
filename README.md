The file “run_analysis.R” runs a code in R that cleans and summarizes the following data:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The following link describes the data at length:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Once the R code is run, it will automatically download the necessary files and output the final tidy data text files to the working directory.

The purpose of the R code is to produce a final output file: 
-	At first a tidy dataset that neatly shows combined train and test data and with the correct column names with the test subject number and activity name rows is generated. All the columns have been provided with descriptive names. This dataset only shows the mean and standard deviation feature variables.
-	Using this dataset, the final output file, “proj_data_mean.txt”, is created by summarizing the mean values for every feature variable in the previously created tidy dataset for each unique test subject and activity name. This file can be found in the repository.

Here is the basic functioning of this R Code:
(Further details can be found in the Code itself)

Step 1: Saves the raw data to working directory and unzips.

Step 2: Combines Test Subject numbers and Activity Numbers to the test and train data. 

Step 3: Adds Column names to the training and test data files

Step 4: Merges training and test data sets to form one data set

Step 5: Installs dplyr package to extract only mean and standard deviation variables from data set

Step 6: Changes Activity numbers to Activity names

Step 7: Installs the reshape2 package to melt and cast the data to obtain the mean of each of the feature values for every unique test subject and activity combination.





