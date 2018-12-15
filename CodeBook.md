# Code book for the Coursera Getting and Cleaning Data course project

The script `run_analysis.R` downloads the neccassary data if it is not available and then performs the 5 Steps of the assignment:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Variables

The script uses several variables.
`filename` holds the file names to check whether it is available or needs to get fetched.

These variables are used to read in the data:
`training_values` is used to read in the data of X_train.
`training_activities` is used to read in the data of y_train.
`training_subjects` is used to read in the data of subject_train.
`test_values` is used to read in the data of X_test
`test_activities` is used to read in the data of y_test
`test_subjects` is used to read in the data of subject_test
`features` is used to store the features of teatures.txt
`activities` is used to store the activities of activity_labels.txt

These variables are used to store intermediate results
`trainingframe` holds the data frame for the results of the training team
`testframe` holds the data frame for the results of the test team
`colnamestraining` holds the column names of the traingframe
`colnamestest` holds the column names of the test frame
`columns` holds the columns that are needed for the task, here only measurements on mean and standard deviation

These variables hold the main data:
`data` the final data frame of the test and training group
`datacolumnnames` the column names of `data`
`meandata` the data frame that gets written into tidydata.txt.

# Result

The result is the text file `tidydata.txt` that holds tidy data. For each subject and activity the average of each variable.