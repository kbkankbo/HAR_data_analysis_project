# 3/26/2017
# Download the data

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "projdata.zip", method ="curl")
unzip("projdata.zip")

# Read all the data 8 files
features <- read.table("./UCI HAR Dataset/features.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

#Combine the train data with the labels and subjects
complete_train <- cbind(subject_train,y_train, X_train)

#Combine the test data with its y labels and subjects
complete_test <- cbind(subject_test,y_test, X_test)

# Merge both the test and the train datasets to create a complete dataset by rbind
full_dataset <- rbind(complete_test,complete_train)

# When I tried to create a data tibble of the full_dataset using dplyr package it did not create as the first 3 columns had the same name V1. So I changed the column names of the first 2 columns as follows-
names(full_dataset)[1]<- "Subject"
names(full_dataset)[2]<- "Activity" 

options(warn=-1);
suppressMessages(library(dplyr));
suppressMessages(library(tidyr));


# Arrange according to the subject id in ascending order
full_df <- tbl_df(full_dataset)
arr_full_df <- arrange(full_df,Subject)


# Rename the activity levels with the corresponding names 

arr_full_df$Activity<- as.factor(arr_full_df$Activity)
arr_full_df$Activity <- recode(arr_full_df$Activity, "1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"= "SITTING", "5"= "STANDING", "6"="LAYING")


#Extract only all the means and standard deviation columns from the df
#Extract the names(values) from features_df as follows-
features_df <- tbl_df(features)

# Select the required columns and name the columns
col_names<- grep("?mean\\(\\)$|?std\\(\\)$",features_df$V2,ignore.case = TRUE, value = TRUE)
col_indices <-grep("?mean\\(\\)$|?std\\(\\)$",features_df$V2)
actual_col_indices <- col_indices+2
new_reqd_df <- select(arr_full_df, Subject,Activity, num_range("V",actual_col_indices))

#Colnames changed as follows
names(new_reqd_df)[3:20] <- col_names

new_reqd_df$Subject <- as.factor(new_reqd_df$Subject)
#group by
new_reqdt1 <- group_by(new_reqd_df,Subject, Activity)

# Summarise each column

new_reqdt2 <- summarise_each(new_reqdt1,funs(mean))
View(new_reqdt2)

# Another independent tidy dataset
finalmelt <- gather(new_reqdt2,"Variable","Value",3:20)
View(finalmelt)

#Write the output to file
write.table(new_reqdt2,"./output.txt", sep = "\t")
write.table(finalmelt,"./finalmelt.txt", sep ="\t")
