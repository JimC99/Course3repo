# run_analysis.R
# This script implements my solution to the Coursera 'Getting and Cleaning Data'
# programming assignment course project. Updated from my previous submission to
# include all 66 "mean" and "std" variables, and not just the six 'acceleration' ones. 
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
# Combine the observational ('X') data frames, select & keep only the 66 'mean' 
# and 'stdev' labeled columns. Extract column headers for the columns of interest  
# from the 'features' data frame.
X_bind <- rbind(X_train, X_test)
X_bind <- select(X_bind, V1:V6,V41:V46,V81:V86,V121:V126,V161:V166,V201:V202,V214:V215,
                 V227:V228,V240:V241,V253:V254,V266:V271,V345:V350,V424:V429,
                 V503:V504,V516:V517,V529:V530,V542:V543)
names(X_bind) <- features$V2[c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,
                               227:228,240:241,253:254,266:271,345:350,424:429,
                               503:504,516:517,529:530,542:543)]
#
# Make the column (variable) names more descriptive by removing/replacing unusual characters.
names(X_bind) <- gsub("[()]", "", names(X_bind))
names(X_bind) <- gsub("-", ".", names(X_bind))
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
# Add a column of descriptive activity names corresponding to the 'label' values, then
# delete the now-redundant 'label' column.
tidy_data <- merge(tablbind1, activity_labels, by = "label")
tidy_data <- select(tidy_data, subject, activity, tBodyAcc.mean.X:fBodyBodyGyroJerkMag.std)
#
write.csv(tidy_data, "tidy_data_table.csv", row.names=FALSE)
#
# Create a data frame of mean values of each of the 66 observational variables summarized by 
# unique subject-activity combination. Write the result to disk as a csv file.
summ_tabl <- tidy_data %>% group_by(subject, activity) %>% 
                     summarise_at(vars("tBodyAcc.mean.X":"fBodyBodyGyroJerkMag.std"), mean)
write.csv(summ_tabl, "summmary_mean_table.csv", row.names=FALSE)
write.table(summ_tabl, "summmary_mean_table.txt", row.names=FALSE)
