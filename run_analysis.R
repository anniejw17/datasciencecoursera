# Coursera Data Science: Getting and Cleaning Data
# Course Project

# Categorize the rows by subject and activity
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",col.names="Subject")
n_train <- dim(subject_train)[1]
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",col.names="Subject")
n_test <- dim(subject_test)[1]
# dim(subject_train) # 7352 by 1
# dim(subject_test) # 2947 1
subject <- rbind(data.frame(subject_train),data.frame(subject_test))
levels(subject) <- c(1:30)

# Rename the elements of y_test and y_train to be activity names using plyr's mapvalues
library(plyr); library(data.table); library(dplyr)
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activities <- factor(activity_labels[,2])

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
y_all <- rbind(y_train,y_test)
activity <- mapvalues(y_all[,1], from=c(1:6), to=as.character(activities))
activity <- data.frame(activity)
names(activity) <- "Activity"

# Create a vector for denoting whether a row is testing or training data
# data_type <- data.frame(c(rep("TRAIN",times=n_train),rep("TEST",times=n_test)))
# names(data_type) <- "Data_Type"

# Begin to assemble the tidy data frame by column binding
# col.names <- c("Test/Train", "Subject", "Activity")
# tidy_data <- data.frame(data_type, subject, activity)
tidy_data <- data.frame(subject, activity)
head(tidy_data)

# Extract mean and std measurements from features
features <- read.table("./data/UCI HAR Dataset/features.txt")
# dim(features) # 561 by 2
# tBodyAcc-mean(), -std() are [1:6]
# tGravityAcc-mean(), -std() are [41:46]
# tBodyAccJerk-mean(), -std() are [81:86]
# and so on 

# Pull out the 66 variables that pertain to mean or std, but not meanFreq
feature_names <- c(make.names(features[,2]))
substring <- ".mean..|.std.."
is_mean_std <- grepl(substring, feature_names)
is_mean_freq <- grep("meanFreq", feature_names)
is_mean_std[is_mean_freq] <- FALSE
feature_names <- feature_names[is_mean_std]
# Make names syntactically valid
feature_names <- gsub("...", ".", feature_names,fixed=TRUE)
feature_names <- gsub("..", "", feature_names,fixed=TRUE)

X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
X_all <- rbind(X_train,X_test)
X_mean_std <- X_all[,is_mean_std]
# dim(X_all) # 10299 by 561
# dim(X_mean_std) # 10299 by 66
names(X_mean_std) <- feature_names
tidy_data <- cbind(tidy_data, X_mean_std)
tidy_data <- arrange(tidy_data, Subject, Activity)
# 10299 obs. of 68 variables

# Second, independent data set with averages by the 6 activities and 30 subjects
by_subj_act <- group_by(tidy_data, Subject, Activity)
tidy_data2 <- summarise_each(by_subj_act, funs(mean))
# head(tidy_data2,n=10)

# write.table(tidy_data2, file="tidy_data.txt", row.names=FALSE)
