# Getting and Cleaning Data

The following repository contains the elements for the peer_reviewed submission of the Getting and Cleaning Data course project. It includes the following files

* ```CodeBook.md```: a codebook indicating all the variables and summaries calculated, along with the units and other relevant information. 
* ```run_analysis.R```: the code that gathers and cleans the data following the 5 following steps:

        1. Merging the training and the test sets to create a single set
        2. Extracting the measurements on the mean and standard deviation for each measurement
        3. Inputing the descriptive activity names to name the activities in the data set 
        4. Labelling appropriately the data set with descriptive variable names
        5. Creating an independent tidy data set with the average of each variable by activity and subject
        
* ```tidydata.txt ```: the final dataset that results from the cleaning and processing of the initial database files. 

The link for the dataset is as follows: [Human Activity Recognition Using Smartphones datasets](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
