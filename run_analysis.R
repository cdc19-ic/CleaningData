fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = paste0(getwd(), '/Data.zip'), method = "curl")
unzip("Data.zip",exdir = "data")

#Retrieve the decription data for all the files and assign column names:
activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt")
features<-read.table("UCI HAR Dataset/features.txt")

colnames(activity_labels)<-c("activityId","activityType")
colnames(features)<-c("featureId","featureType")

#Retrieve the test elements and assign column names (note that the names of the X_test file are the features):
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")
X_test<-read.table("UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("UCI HAR Dataset/test/y_test.txt")

colnames(subject_test)<-"subjectId"
colnames(X_test)<-features[,2]
colnames(y_test)<-"activityId"

#We can now merge these three files by adding the test subjId and actId columns to the X_test table:
test<-cbind(subject_test, y_test, X_test)

#Retrieve the train element and assign column names (note that the names of the X_train file are the features):
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt")
X_train<-read.table("UCI HAR Dataset/train/X_train.txt")
y_train<-read.table("UCI HAR Dataset/train/y_train.txt") 

colnames(subject_train)<-"subjectId"
colnames(X_train)<-features[,2]
colnames(y_train)<-"activityId"

#We can now merge these three files by adding the train subjId and actId columns to the X_train table:
train<-cbind(subject_train, y_train, X_train)

#We can now merge the test and the train files together since they have the same number of columns:
merged_data<-rbind(test, train)

#Let's now extract the mean and standard deviation measurements for each measurement:
extracted_features <- grepl("mean|std|subjectId|activityId", colnames(merged_data))
new_data <- merged_data[,extracted_features]

#We can now add the descriptive activity names next to their corresponding activity number into this last table:
new_data2 <- merge(new_data, activity_labels, by.x="activityId", by.y="activityId")
new_data2 <- new_data2[,c(1,82,2:81)]

#The next next consists in transforming the labels of the data set into descriptive variable names:
#We can first remove all the parenthesis from those names:
names(new_data2) <- gsub("\\(\\)", "", names(new_data2)) 
#Then change t, f, Acc, Freq, Mag to readable names:
names(new_data2) <- gsub("^t", "time", names(new_data2))
names(new_data2) <- gsub("^f", "frequency", names(new_data2))
names(new_data2) <- gsub("Acc", "acceleration", names(new_data2))
names(new_data2) <- gsub("Freq", "frequency", names(new_data2))
names(new_data2) <- gsub("Mag", "magnitude", names(new_data2))
names(new_data2) <- gsub("Gyro", "gyroscope", names(new_data2))
names(new_data2) <- gsub("BodyBody", "body", names(new_data2))
names(new_data2) <- gsub("-", "", names(new_data2))
#Finally, according to Leek's course video, all the variable names should be lower case:
names(new_data2) <- tolower(names(new_data2))

#The last step is to create a second independent tidy data set with the average of each variable for each activity and each subject:
#Using the reshape2 library, we will melt the last data frame while keeping the first three columns intact:
library(reshape2)
melt <- melt(new_data2, id.vars=c("subjectid", "activitytype", "activityid"), measure.vars=setdiff(colnames(new_data2), c("subjectid", "activitytype", "activityid")))

#The molten data frame can then be recast by subject and activity type through a mean and written in a .txt file:
tidy_data <- dcast(melt, subjectid + activitytype ~ variable, mean)
write.table(tidy_data,file="tidydata.txt")
