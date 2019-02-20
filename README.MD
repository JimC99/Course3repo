## README file

## Script 'run_analysis.R' does the following:

*Extracts individual observations from files 'X_train.txt' and 'X_test.txt', and combines them 
into a tidy data frame that also includes information (columns) on subject and activity, provided by files 'subject_test.txt', 'subject_train.txt', 
'y_test', 'y_train', 'features.txt', and 'activity_labels.txt'. 

*Creates a data frame of mean values of each of 66 observational variables with 'mean' or 'std dev' in their names, summarized by unique subject-activity combination.

*Writes both of the generated tidy data frames to disk as .csv files, and the summary table as a .txt file as well.