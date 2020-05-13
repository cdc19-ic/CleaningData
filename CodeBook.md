# Code Book

The run_analysis.R code enables us to get and clean data preparation, by going through the 5 steps reaquired by the coursework, as described in the README file.

0. Downloading the dataset and retrieving each elements from it:
    * The folder ```UCI HAR Dataset``` is the extracted folder coming from the dowload 
    * ```activity_labels``` <- ```activity_labels.txt``` 6 rows and 2 columns, labels of the activities
    * ```features``` <- ```features.txt``` : 561 rows and 2 columns, labels of the measured features
    * ```subject_test``` <- ```subject_test.txt``` : 2947 rows and 1 column, ID of 9 test subjects for test data
    * ```X_test``` <- ```X_test.txt``` : 2947 rows and 561 columns, measurements for the test data
    * ```y_test``` <- ```y_test.txt``` : 2947 rows and 1 column, activity ID for the test measurements
    * ```subject_train``` <- ```subject_train.txt``` : 7352 rows and 1 column, ID of 21 test subjects for train data
    * ```X_train``` <- ```X_train.txt``` : 7352 rows and 561 column, measurements for the train data
    * ```y_train``` <- ```y_train.txt``` : 7352 rows and 1 column, activity ID for the train measurements

1. Merging the training and test sets to create one data set:
    * ```subject_test```, ```X_test``` and ```y_test``` are binded to form ```test``` : 2947 rows and 563 columns
    * ```subject_train```, ```X_train``` and ```y_train``` are binded to form ```train``` : 7352 rows and 563 columns
    * ```test``` and ```train``` are then binded to form ```merged_data``` : 10299 rows and 563 columns

2. Extracting the measurements on the mean and standard deviation for each measurement:
    * ```new_data``` (10299 rows and 81 columns) is a subset of ```merged_data``` and is formed through the ```grepl()``` function which selects the columns containing the words ```mean``` or ```std```

3. Using descriptive activity names to name the activities in the data set:
    * ```activity_labels``` are merged into ```new_data``` to form ```new_data2``` : 10299 rows and 82 columns

4. Labeling of the data set with descriptive variable names:
    * All the column names of ```new_data2``` are analyzed and modified with the ```gsub()``` and ```tolower()``` functions in order make it more readable. The following elements were changed from ```^t```, ```^f```, ```Acc```, ```Freq```, ```Mag```, ```Gyro```, ```BodyBody``` to ```time```, ```frequency```, ```acceleration```, ```frequency```, ```magnitude```, ```gyroscope```, ```body```. Parentheses and hyphens were also removed

5. Creating an independent tidy data set with the average of each variable by activity and subject
    * By using the ```library(reshape2)```, ```new_data2``` is molten and recast by subject and activity type while applying a mean and forms ```tidy_data``` : 180 rows and 81 columns
    * An export of ```tidy_data``` leads to the creation of the ```tidydata.txt``` file
