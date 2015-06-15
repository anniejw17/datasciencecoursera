# datasciencecoursera
This README is for the course project in Getting and Cleaning data. It describes how the `run_analysis.R` script works. Additional information about the data can be found in the code book. 

# `run_analysis.R`

## Raw data
This script was written to obtain, clean, and arrange data containing acceleration information from the gyro of a mobile phone. The data is organized into `.txt` files containing 
* Subject information for training and test data (which subject is associated with each observation)
* Information about which activity was being performed for each observation
* The actual measurements and their statistical estimates, such as mean and standard deviation
* The names of the measurements, stored in a separate `.txt` file

As the script progresses, it reads in the .txt files as necessary and manipulates them to create a tidy data set

## Categorize the rows by subject and activity
First, the script reads in `subject_train.txt` and `subject_test.txt` to obtain the mapping of which subjects performed each observation. They are merged into a data frame called `subject` using `rbind`. 

Next, the script reads the labels of the activities; these will be used to replace the hard-to-read values in `y_train.txt` and `y_test.txt`, e.g. "WALKING" instead of "2". The two data sets are merged into a single data frame using `rbind`, and `mapvalues` is used to convert numbers into activity labels. 

## Create the basic tidy data set
The tidy data set is now initialized with the Subject and Activity labels by using `cbind` to column-bind the two data frames. 

## Extract mean and standard deviation measurements' names
The project instructions state that, of the 561 features recorded or calculated, we are only concerned with ones pertaining to the mean and standard deviation of a type of measurement. This specification excludes features with ambiguous names, such as "meanFreq", because the mean Frequency value is not a measure of the mean of the value. As `features_info.txt` states, meanFreq is the "weighted average of the frequency components to obtain a mean frequency". This is not a mean of the measurement itself, so it is excluded. This leaves us with 66 features to include.

These 66 features were extracted from the 561 total features using the `grepl` command, which takes a string that you're looking for (in this case "-mean()" or "-std()" but not "meanFreq()") and creates a vector saying the element of your target vector is TRUE if it contains your string or FALSE if it doesn't. I took several steps, including using `make.names` to make the names syntactically valid, then getting T/F for the feature_names data frame. I then took the subset of the 561 feature names using vectors with logical terms for "yes, it contains mean or std" (`is_mean_std`) and "no, it contains meanFreq, throw it out" (`is_mean_freq`). 

## Extract mean and standard deviation values 
Once we know where the relevant measurements are, we can select those columns from the actual data. This is done by reading in `X_train.txt` and `X_test.txt` and merging them into a data frame using `rbind`, as before. In this exercise, I always called the training document, then the test document; this placed training data on top of test data, so my values did not get mixed up across Subject, Activity, and the measurements. 

The full data frame (10,299 by 561) is subsetting using the same `is_mean_std` logical vector used previously. This extracts the 66 columns with relevant measurements. These columns are bound to the existing `tidy_data` data frame using `cbind`. The data frame is then arranged using `arrange`, so that all of Subject 1's data for Activity 1 is listed first, then Subject 1, Activity 2, and so on down to Subject 30, Activity 6. This sets up the data set nicely for the final step of the project. 

## Create a second, independent data set with averages by the 6 activities and 30 subjects
Now that we have a tidy data set with many values for each Subject and Activity, we wish to take the mean of all observations for each Subject-Activity combination. Because there are 30 subjects and 6 activities, we will end up with a data frame containing 180 observations of 68 variables: A Subject and Activity category and 66 average values. 

This is done using the `dplyr` package's `summarise_each` function. First, we group the data using `group_by`, then use `summarise_each` to take the mean of the groups across every feature column. The result is `tidy_data2`, the second and more compact data set. 

The final step is to write the data frame to a `.txt` file for upload.

# `Codebook.md`

Additional information about the real-life meaning of the features/variables can be found in the code book markdown. 
