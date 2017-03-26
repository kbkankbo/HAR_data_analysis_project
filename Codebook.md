Getting and Cleaning Data Course Project
=================================================================================
This code book that describes the variables, the data, and any transformations or work that was performed to clean up the data.

Eight data files used for merging and creating the tidy dataset are as follows-

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Following files from the original dataset were not used-

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 


 Steps performed in run_analysis.R to transform the data and their structures and variables are as follows-

1) Download the data and unzip the file. This is stored in destination file projdata.zip in the current working directory

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "projdata.zip", method ="curl")
unzip("projdata.zip")
=================================================================================
2) Read the 8 data files
features <- read.table("./UCI HAR Dataset/features.txt")
str(features)
'data.frame':	561 obs. of  2 variables:
 $ V1: int  1 2 3 4 5 6 7 8 9 10 ...
 $ V2: Factor w/ 477 levels "angle(tBodyAccJerkMean),gravityMean)",..: 243 244 245 250 251 252 237 238 239 240 ...

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
'data.frame':	7352 obs. of  561 variables:
 $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
 $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
 $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...

y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
'data.frame':	7352 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
'data.frame':	7352 obs. of  1 variable:
 $ V1: int  1 1 1 1 1 1 1 1 1 1 ...

y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
'data.frame':	2947 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
'data.frame':	2947 obs. of  561 variables:
 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
'data.frame':	2947 obs. of  1 variable:
 $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
'data.frame':	6 obs. of  2 variables:
 $ V1: int  1 2 3 4 5 6
 $ V2: Factor w/ 6 levels "LAYING","SITTING",..: 4 6 5 2 3 1
=================================================================================

3) Combine the train data with the labels and subjects
complete_train <- cbind(subject_train,y_train, X_train)
'data.frame':	7352 obs. of  563 variables:
 $ V1  : int  1 1 1 1 1 1 1 1 1 1 ...
 $ V1  : int  5 5 5 5 5 5 5 5 5 5 ...
 $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
 $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
=================================================================================

4) Combine the test data with its y labels and subjects
complete_test <- cbind(subject_test,y_test, X_test)
'data.frame':	2947 obs. of  563 variables:
 $ V1  : int  2 2 2 2 2 2 2 2 2 2 ...
 $ V1  : int  5 5 5 5 5 5 5 5 5 5 ...
 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
=================================================================================

5) Merge both the test and the train datasets to create a complete dataset by rbind
full_dataset <- rbind(complete_test,complete_train)
'data.frame':	10299 obs. of  563 variables:
 $ Subject : int  2 2 2 2 2 2 2 2 2 2 ...
 $ Activity: int  5 5 5 5 5 5 5 5 5 5 ...
 $ V1      : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2      : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ V3      : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ..
=================================================================================

6)Change the column names of the first 2 columns as follows-
names(full_dataset)[1]<- "Subject"
names(full_dataset)[2]<- "Activity" 
=================================================================================

7) #Load the dplyr, and tidyr packages, Needs to be installed if it does not exist

options(warn=-1);
suppressMessages(library(dplyr));
suppressMessages(library(tidyr))

=================================================================================

8) Arrange according to the subject id in ascending order
full_df <- tbl_df(full_dataset)
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	10299 obs. of  563 variables:
 $ Subject : int  2 2 2 2 2 2 2 2 2 2 ...
 $ Activity: int  5 5 5 5 5 5 5 5 5 5 ...
 $ V1      : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2      : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ V3      : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...

arr_full_df <- arrange(full_df,Subject)
=================================================================================

9) Rename the activity levels with the corresponding names 
arr_full_df$Activity <- as.factor(arr_full_df$Activity)
arr_full_df$Activity <- recode(arr_full_df$Activity, "1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"= "SITTING", "5"= "STANDING", "6"="LAYING")
str(arr_full_df)
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	10299 obs. of  563 variables:
 $ Subject : int  1 1 1 1 1 1 1 1 1 1 ...
 $ Activity: Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
 $ V1      : num  0.289 0.278 0.28 0.279 0.277 ...
 $ V2      : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ V3      : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
=================================================================================

10) Extract only all the means and standard deviation columns from the df
#Extract the names(values) from features_df as follows-
features_df <- tbl_df(features)

# Select the required columns and name the columns
col_names<- grep("?mean\\(\\)$|?std\\(\\)$",features_df$V2,ignore.case = TRUE, value = TRUE)

col_names
 [1] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
 [3] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
 [5] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
 [7] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
 [9] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
[11] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
[13] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
[15] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
[17] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()" 

col_indices <-grep("?mean\\(\\)$|?std\\(\\)$",features_df$V2)

col_indices
 [1] 201 202 214 215 227 228 240 241 253 254 503 504 516 517 529 530 542 543

actual_col_indices <- col_indices+2

actual_col_indices
 [1] 203 204 216 217 229 230 242 243 255 256 505 506 518 519 531 532 544 545

new_reqd_df <- select(arr_full_df, Subject,Activity, num_range("V",actual_col_indices))

#Colnames changed as follows
names(new_reqd_df)[3:20] <- col_names

new_reqd_df$Subject <- as.factor(new_reqd_df$Subject)

Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	10299 obs. of  20 variables:
 $ Subject                    : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Activity                   : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
 $ tBodyAccMag-mean()         : num  -0.958 -0.978 -0.988 -0.986 -0.991 ...
 $ tBodyAccMag-std()          : num  -0.946 -0.979 -0.986 -0.986 -0.991 ...
 $ tGravityAccMag-mean()      : num  -0.958 -0.978 -0.988 -0.986 -0.991 ...
 $ tGravityAccMag-std()       : num  -0.946 -0.979 -0.986 -0.986 -0.991 ...

#group by
new_reqdt1 <- group_by(new_reqd_df,Subject, Activity)

Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':	10299 obs. of  20 variables:
 $ Subject                    : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 1 1 1 1 ...
 $ Activity                   : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 5 5 5 5 5 5 5 5 5 5 ...
 $ tBodyAccMag-mean()         : num  -0.958 -0.978 -0.988 -0.986 -0.991 ...
 $ tBodyAccMag-std()          : num  -0.946 -0.979 -0.986 -0.986 -0.991 ...
 $ tGravityAccMag-mean()      : num  -0.958 -0.978 -0.988 -0.986 -0.991 ...
 $ tGravityAccMag-std()       : num  -0.946 -0.979 -0.986 -0.986 -0.991 ...
 $ tBodyAccJerkMag-mean()     : num  -0.995 -0.993 -0.991 -0.993 -0.996 ...
=================================================================================

11) Summarise each column

 new_reqdt2 <- summarise_each(new_reqdt1,funs(mean))

Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':	180 obs. of  20 variables:
 $ Subject                    : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 2 2 2 2 ...
 $ Activity                   : Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
 $ tBodyAccMag-mean()         : num  -0.297 -0.388 -0.1 -0.931 -0.983 ...
 $ tBodyAccMag-std()          : num  -0.1856 -0.2898 0.0705 -0.9424 -0.9824 ...
 $ tGravityAccMag-mean()      : num  -0.297 -0.388 -0.1 -0.931 -0.983 ...
 $ tGravityAccMag-std()       : num  -0.1856 -0.2898 0.0705 -0.9424 -0.9824 ...
 $ tBodyAccJerkMag-mean()     : num  -0.1287 -0.5209 -0.0611 -0.9845 -0.9936 ...
 $ tBodyAccJerkMag-std()      : num  -0.1036 -0.4363 -0.0813 -0.9842 -0.9917 ...
=================================================================================

12) Another independent tidy dataset
finalmelt <- gather(new_reqdt2,"variable","values",3:20)

Classes ‘grouped_df’, ‘tbl_df’, ‘tbl’ and 'data.frame':	3240 obs. of  4 variables:
 $ Subject : Factor w/ 30 levels "1","2","3","4",..: 1 1 1 1 1 1 2 2 2 2 ...
 $ Activity: Factor w/ 6 levels "WALKING","WALKING_UPSTAIRS",..: 1 2 3 4 5 6 1 2 3 4 ...
 $ variable: chr  "tBodyAccMag-mean()" "tBodyAccMag-mean()" "tBodyAccMag-mean()" "tBodyAccMag-mean()" ...
 $ values  : num  -0.297 -0.388 -0.1 -0.931 -0.983 ...
 - attr(*, "vars")=List of 1
  ..$ : symbol Subject
 - attr(*, "drop")= logi TRUE
 - attr(*, "indices")=List of 30
  ..$ : int  0 1 2 3 4 5 180 181 182 183 ...
  ..$ : int  6 7 8 9 10 11 186 187 188 189 ...
  ..$ : int  12 13 14 15 16 17 192 193 194 195 ...
  ..$ : int  18 19 20 21 22 23 198 199 200 201 ...
  ..$ : int  24 25 26 27 28 29 204 205 206 207 ...
  ..$ : int  30 31 32 33 34 35 210 211 212 213 ...
=================================================================================

13) Write the output file

write.table(new_reqdt2,"./output.txt", sep = "\t")
write.table(finalmelt,"./finalmelt.txt", sep ="\t")

=========================================================================================================================================


Additional information-
Original features_info file-
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'
Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.






