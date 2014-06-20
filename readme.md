##Summary
This script (run_analysis.R) uses acclerometer data from the UCI machine learning repository.  The data is separated into multiple input files.  This script combines the data into a tidy data set for analysis.


##Detailed description of the run_analysis.R script

The script performs the following tasks:

1.  Performs all the setup work including:
	- loads appropriate library
	- sets working directory
	- reads in the x, y and subject testing and training datasets
	- reads in the activity labels and features

2.  Merges the training and the test sets to create one data set.
	- Combines the x_train, y_train, x_test and y_test datasets into one dataset named xy_all
	- Adds column names to the xy_all dataset using features for column names and also names the last column activity_code as a way to identify the data from the y_test and y_train datasets
	
3.  Extracts only the measurements on the mean and standard deviation for each measurement. 
	- Uses grep to only keep the column names we need - column names with mean, std and also activity code
	- Replaces xy_all with the result 
	

4. Uses descriptive activity names to name the activities in the data set and 5. Appropriately labels the data set with descriptive variable names. 
	- Combines subject train and test datasets
	- Adds the combined subject train and test datasets to xy_all as a new column name subject
	- Adds descriptive column names to the activity_labels and join them into the xy_all dataset

6. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
	- Calculates the average using ddply from the plyr library and stores the output into xy_all_mean
	- Outputs the data in xy_all_mean to a file named tidy_data.txt

