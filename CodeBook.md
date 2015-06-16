This Code Book explains the features included in the tidy data set for Getting and Cleaning Data - course project. The information contained in it is modified and updated information from files available to us at the beginning of the project, specifically `features_info.txt` and `README.txt`. 

## Overview
From `README.txt`: 
> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50 Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. 

> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

>For each record it is provided:

> * Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> * Triaxial Angular velocity from the gyroscope. 
> * A 561-feature vector with time and frequency domain variables. 
> * Its activity label. 
> * An identifier of the subject who carried out the experiment.

## Data Info
Data was obtained from the 30 subjects performing 6 activities. Each observation (2,947 test observations and 7,352 training observations) is associated with a subject number (between 1 and 30) and an activity. The raw inertial signals are stored in a separate folder, but for this project we used the processed statistics from the raw signals. These statistics are described in the features information below. 

## Features Info
From `features_info.txt`:
> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

> These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

> tBodyAcc-XYZ
> tGravityAcc-XYZ
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ
> tBodyGyroJerk-XYZ
> tBodyAccMag
> tGravityAccMag
> tBodyAccJerkMag
> tBodyGyroMag
> tBodyGyroJerkMag
> fBodyAcc-XYZ
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccMag
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag

For each signal, a set of variables was estimated. These include mean, standard deviation, minimum, maximum, median absolute deviation, etc. For the purposes of this course project, we only extracted the statistics of mean and standard deviation for each signal. This resulted in 66 features total. 

Each feature name takes the form tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-std()-X, and so on. When converting these feature names into a form for tidy data, we needed to make them syntactically valid in R. This was done by replacing the hyphens - with periods . and eliminating parentheses. The final labels are formatted as tBodyAcc.mean.X, tBodyAcc.mean.Y, etc. 

After extracting the mean and standard deviations of each measurement for each observation, the data table was further reduced by taking the mean of all observations for each subject/activity combination. The titles of the features remained the same, but now the data set was reduced to 180 observations instead of 10,299. 
