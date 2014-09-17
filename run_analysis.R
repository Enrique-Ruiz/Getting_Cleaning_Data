run_analysis <- function(){
        ## STEP 1. MERGE THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET
        ########################################################################
        # Read in, and combine, the data in the test files: subject_test.txt, 
        # X_test.txt and y_test.txt into one data frame
        df_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
        df_x <- read.table("UCI HAR Dataset/test/X_test.txt")
        df_y <- read.table("UCI HAR Dataset/test/y_test.txt")
        df_test <- cbind(df_subject, df_y)
        df_test <- cbind(df_test, df_x)
        
        # Next do the same for the train files: subject_train.txt, X_test.txt and 
        # y_test.txt
        df_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
        df_x <- read.table("UCI HAR Dataset/train/X_train.txt")
        df_y <- read.table("UCI HAR Dataset/train/y_train.txt")
        df_train <- cbind(df_subject, df_y)
        df_train <- cbind(df_train, df_x)
        df_train
        
        # Combine the observations of df_test and df_train to get one large data set
        df <- rbind(df_test, df_train)
        ########################################################################
        
        
        ## STEP 2. Extract only the measurements on the mean and standard deviation 
        ## for each measurement
        ########################################################################
        df_features <- read.table("UCI HAR Dataset/features.txt")
        v_features <- df_features[,2]
        v_means <- grep("mean()", v_features)
        v_stds <- grep("std()", v_features)
        v_combined <- c(v_means, v_stds)
        v_sorted <- sort(v_combined, decreasing = FALSE)
        v_offset <- c(1:2, v_sorted + 2)
        df <- subset(df, TRUE, select = v_offset)
        ########################################################################
        
        ## Step 3. Use descriptive activity names to name the activities in the data set
        ########################################################################
        df_activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
        for(i in 1:6){
                l <- df[, 2] == i
                df[l, 2] = as.character(df_activityLabels[i, 2])
        }
        ########################################################################
        
        ## Step 4. Appropriately label the data set with descriptive variable names
        ########################################################################
        df_names <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors=FALSE)
        df_names <- cbind(df_names, as.character(paste("V", df_names[,1], sep = "")))
        i <- sapply(df_names, is.factor)
        df_names[i] <- lapply(df_names[i], as.character)
        df_names[1,3] = "V1.2" ## manually change the name of the this column to match the correct column in df
        v_colNames <- names(df)
        for(i in 1:length(v_colNames)){
                l <- df_names[,3] == v_colNames[i]
                if(length(df_names[l,2]) > 0){
                        v_colNames[i] = df_names[l,2]
                }
        }
        v_colNames[1] = "Subject"
        v_colNames[2] = "Activity"
        names(df) <- v_colNames
        ########################################################################
        
        ## Step 5. Create tidy dataset with average of each variable for each 
        ## activity and each subject
        ########################################################################
        # Use dplyr to group and summarize the data
        library(dplyr)
        tidyDF <- tbl_df(df)
        tidyDF <- tidyDF %>% group_by(Subject, Activity)
        tidyDF <- summarise_each(tidyDF, funs(mean))
        write.table(tidyDF, file = "tidy_dataset.txt", row.names=FALSE)
        ########################################################################
}