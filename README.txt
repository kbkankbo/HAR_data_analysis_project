
March 25, 2017

Original data 
==================================================================
The data represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

=======================================================================================================================================================================

The following files are included and available for download-
--ReadMe.txt --explains the analysis files 
--Codebook.md --describes the variables, the data, and any transformations or work that you performed to clean up the data 
--run_analysis.R --Script that performs the analysis on the data

The output files, written in the current directory as the output of run_analysis.R script, are included as follows-
--output.txt ( data frame new_reqdt2 of 180 observations and 20 variables)
--finalmelt.txt (data frame finalmelt of 3240 observations of 4 variables)

Steps to be performed in Git bash and Rstudio
git clone https://github.com/kbkankbo/HAR_data_analysis_project.git
source('run_analysis.R')

Notes- Data will be downloaded and unzipped in the current working directory when the run_analysis.R is executed
Packages  dplyr and tidyr is required and will be loaded from the script, but needs to be installed if not already installed using install.packages function

run_analysis.R does the following. Details about each step is in codebook.md
1)Merges the training(X_train.txt) and the test sets(X_test.txt) to create one data set(full_dataset).
2)Extracts only the measurements on the mean and standard deviation for each measurement(new_reqd_df). 
3)Uses descriptive activity names to name the activities in the data set(arr_full_df)
4)Appropriately labels the data set with descriptive variable names. 
5)From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.(finalmelt)




