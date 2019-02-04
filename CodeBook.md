## Codebook for 'Getting and Cleaning Data' Course Programming Project in R 

## Variables and data sources

The variables examined in this project are recorded observations of mean and standard deviation of acceleration in x, y, and z directions.

The data were obtained from recordings on 30 subjects (21 'train' and 9 'test') performing six daily living activities while carrying 
waist-mounted smartphones with embedded inertial sensors. 

The files provided are:
* X_train.txt and X_test.txt: observational measurements on 561 variables (including mean and std dev of acceleration in each of three ordinal directions).
* y_train and y_test: activity lables corresponding to the six activities.
* subject_train and subject_test: number keys representing subjects from whom the 'X' measurements were collected.
* features.txt and activity_labels.txt: names representing 561 observational data types, including the six of interest for this analysis.

## File manipulations and data transformation
*Script 'run_analysis.R' extracts individual observations from files 'X_train.txt' and 'X_test.txt', and combines them into a tidy data set 
that also includes information (columns) on subject and activity, obtained from files 'subject_test.txt', 'subject_train.txt', 'y_test', 'y_train', 
'features.txt', and 'activity_labels.txt'. 

*Script 'run_analysis.R' also creates a data frame of mean values of each of the 
six observational variables (mean and std dev of acceleration in each of 3 ordinal directions), summarized by unique subject-activity combination.

*Script 'run_analysis.R' writes both generated data frames to disk as csv files.

