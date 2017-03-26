March 25, 2017

Original data 
==================================================================
The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

==================================================================================

The above dataset was downloaded and used to create a merged tidy dataset with the final means and standard deviations of the measurements extracted for each subject(total 30 observations) for each activity they performed in the experiment.(6 activities). Final dataset has 180 observations(30 subjects x 6 activities each)and 20 variables.
Note- The means and standard deviations extracted from the original 561 features is only for the measurements for the complete window . Individual means and standard deviations for each X, Y and Z signals were not extracted. So the total number of variables is 20(2 ids and 18 features).

In addition, another tidy dataset(finalmelt) that has a single record per subject per activity per variable is provided. This has 3240 observations of 4 variables.Details are in codebook.md

==================================================================================

The following files are included-
--ReadMe.txt --explains the analysis files 
--Codebook.md --describes the variables, the data, and any transformations or work that you performed to clean up the data 
--run_analysis.R --Script that performs the analysis on the data

The output files, written in the current directory as the output of run_analysis.R script, are included as follows-
--output.txt
--finalmelt.txt

Steps to be performed
source('run_analysis.R')

Notes- Data will be downloaded and unzipped in the current working directory when the run_analysis.R is executed
Packages  dplyr and tidyr is required and will be loaded from the script, but needs to be installed if not already installed using install.packages function

run_analysis.R does the following. Details about each step is in codebook.md
1)Merges the training(X_train.txt) and the test sets(X_test.txt) to create one data set(full_dataset).
2)Extracts only the measurements on the mean and standard deviation for each measurement(new_reqd_df). 
3)Uses descriptive activity names to name the activities in the data set(arr_full_df)
4)Appropriately labels the data set with descriptive variable names. 
5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.(finalmelt)






