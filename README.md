Getting_Cleaning_Data
=====================

Repo for Getting and Cleaning Data course project.

This Read Me file describes the R file 'run_analysis.R' in detail,
particularly how it meets the course requirements.  

Below are the course requirements, in order.  The code in 'run_analysis.R
also follows these steps in order and have been commented accordingly.

1. Merge the training and test sets into one data set
	* First, the code reads in the files from the test
	  directory (subject_test, X_test, and y_test)
	  and stores them in individual data frames

	* Next, it combines these three data frames into 
	  one data frame named df_test

	* Next, the same is done for the files in the
	  train directory (subject_train, X_train,
	  and y_train)
	
	* These data are combined into a data frame named
	  df_train

	* Finally, the data frames df_test and df_train
	  are combined into a single data frame named df

	* df now contains the observations, activities, 	          
	  and subjects who performed the activities from
	  from both the train folder and the test folder
	  in one data set

2.  Extract only the measurements on the mean and 
    standard deviation for each measurement
	* First, features.txt is read into a data frame
	  (df_features) so that the code can determine
	  which measurements pertain to mean and standard
	  deviations

	* Next, two vectors are created from df_features,
	  one for values that end in 'mean()' and one for 	  
	  values that end in std()

	* These, vectors are then combined and sorted

	* Then they are offset by 2 to account for the 
	  leading fields (one for subject and one for
	  activity

	* Finally, the resulting vector is used to subset
	  the large, combined data frame (df) creted in 
	  step one so that it only includes the fields
	  pertaining to means and standard deviations

3.  Use descriptive activity names to name the activities in
    the data set
	* The code creates a data frame to hold the activity 
	  labels in the file "activity_labels.txt"

	* The code then cycles through each activity label in 
	  the data frame...
	
	* For each activity label create a logical vector
	  for the column containing activity data to see
	  if it matches.

	* Use the logical vector to rename matching
	  activities with the text label from the activity
	  label data frame

4.  Appropriately label the data set with descriptive variable names
	* First the data from the file "features.txt" is read into
	  a data frame named df_names because this file contains 
	  the actual variable names
	
	* Next a 'V' character is placed infront of each name so they
	  will match with the variable names currently in the data
	  frame 'df'

	* After manually changing the name of field V1.2 in df, the
	  names from df_names are converted from factors to charactrs,
	  a vector is made of the field names in 'df', then a looping
	  construct is employed to change the names in the vector
	  'v_colNames' to the matching feature name in 'df_names'

	* Finally the column names in 'df' are replaced with the 
	  names in 'v_colNames'

5.  Create a tidy dataset with the average of each variable for 
    each Subject and Activity
	* First the code loads the dplyr library in order to 
	  take advantage of it's tbl_df data object features

	* The dataframe 'df' is converted to a tbl_df object named
	  'tidyDF'

	* 'tidyDF' is then grouped by Subject and Activity

	* 'tidyDF' then each field is summarized by getting the mean
	  of each field (excluding the grouping fields)

	* Finally 'tidyDF' is written to a text file using 
	  write.table()

        
