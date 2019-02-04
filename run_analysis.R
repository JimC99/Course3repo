# run_analysis.R
# This script implements my solution to the Coursera 'Getting and Cleaning Data'
# programming assignment course project.
#
library(dplyr)
#
# Read all of the relevant files into data frames.
X_train <-tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt",
                            sep="",stringsAsFactors=F,header=F))
y_train <-tbl_df(read.table("./UCI HAR Dataset/train/y_train.txt",
                            sep="",stringsAsFactors=F,header=F))
subject_train <-tbl_df(read.table("./UCI HAR Dataset/train/subject_train.txt",
                            sep="",stringsAsFactors=F,header=F))
X_test <-tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt",
                            sep="",stringsAsFactors=F,header=F))
y_test <-tbl_df(read.table("./UCI HAR Dataset/test/y_test.txt",
                            sep="",stringsAsFactors=F,header=F))
subject_test <-tbl_df(read.table("./UCI HAR Dataset/test/subject_test.txt",
                            sep="",stringsAsFactors=F,header=F))
features <-tbl_df(read.table("./UCI HAR Dataset/features.txt",
                            sep="",stringsAsFactors=F,header=F))
activity_labels <-tbl_df(read.table("./UCI HAR Dataset/activity_labels.txt",
                            sep="",stringsAsFactors=F,header=F))
#
# Combine the observational ('X') data frames, keeping only the mean and stdev 
# acceleration columns for x, y, and z directions. Extract column headers for 
# the observational data from the 'features' data frame.
X_bind <- rbind(X_train, X_test)
X_bind <- select(X_bind, V1:V6)
names(X_bind) <- features$V2[1:6]
#
# Remove problematic characters from column names.
names(X_bind) <- gsub("[()]", "", names(X_bind))
names(X_bind) <- gsub("-", "", names(X_bind))
#
# Combine the activity label ('y') data frames, and rename the activity label 
# column as 'label'.
y_bind <- rbind(y_train, y_test)
names(y_bind) <- "label"
#
# Combine the 'subject' data frames, and rename the subject number
# column as 'subject'.
subject_bind <- rbind(subject_train, subject_test)
names(subject_bind) <- "subject"
#
# Combine the subject, activity, and observational data frames by columns.
tablbind1 <- cbind(subject_bind, y_bind, X_bind)
names(activity_labels) <- c("label", "activity")
# 
# Add a column of descriptive activity names corresponding to the 'label' values.
tablbind2 <- merge(tablbind1, activity_labels, by = "label")
#
# Rename the observational data fields with more descriptive variable names.
colnames(tablbind2)[colnames(tablbind2)=="tBodyAccmeanX"] <- "x_direction_mean_acceleration"
colnames(tablbind2)[colnames(tablbind2)=="tBodyAccmeanY"] <- "y_direction_mean_acceleration"
colnames(tablbind2)[colnames(tablbind2)=="tBodyAccmeanZ"] <- "z_direction_mean_acceleration"
colnames(tablbind2)[colnames(tablbind2)=="tBodyAccstdX"] <- "x_direction_stddev_acceleration"
colnames(tablbind2)[colnames(tablbind2)=="tBodyAccstdY"] <- "y_direction_stddev_acceleration"
colnames(tablbind2)[colnames(tablbind2)=="tBodyAccstdZ"] <- "z_direction_stddev_acceleration"
#
# Create a data frame that omits the now-extraneous 'label' column. Write the result to disk
# as a csv file.
tidy_data <- select(tablbind2, subject, activity, x_direction_mean_acceleration, 
                    y_direction_mean_acceleration, z_direction_mean_acceleration, 
                    x_direction_stddev_acceleration, y_direction_stddev_acceleration, 
                    z_direction_stddev_acceleration)
write.csv(tidy_data, "tidy_data_table.csv", row.names=FALSE)
#
# Create a data frame of mean values of each of the six observational variables summarized by 
# unique subject-activity combination. Write the result to disk as a csv file.
summ_tabl <- tidy_data %>% group_by(subject, activity) %>% 
                     summarise_at(vars("x_direction_mean_acceleration", "y_direction_mean_acceleration", 
                     "z_direction_mean_acceleration", "x_direction_stddev_acceleration", 
                     "y_direction_stddev_acceleration", "z_direction_stddev_acceleration"), mean)
write.csv(summ_tabl, "summmary_mean_table.csv", , row.names=FALSE)