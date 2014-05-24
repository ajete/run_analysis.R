#You should create one R script called run_analysis.R that does the following: 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation 
#    for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive activity names. 
# 5) Creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject. 

#set local folder path to data set
root_path <- 'C:/Users/jeta/Desktop/coursera/Getting and Cleaning Data/Projekti/data'
###################################################
#Step 1: Load an merge data (assignment point 1, 3 and 4)
###################################################

###### 1.1: load data from flat files
subject_test <- read.table(paste(root_path,"/test/subject_test.txt",sep=""), quote="\"")
X_test <- read.table(paste(root_path,"/test/X_test.txt",sep=""), quote="\"")
y_test <- read.table(paste(root_path,"/test/y_test.txt",sep=""), quote="\"")
subject_train <- read.table(paste(root_path,"/train/subject_train.txt",sep=""), quote="\"")
X_train <- read.table(paste(root_path,"/train/X_train.txt",sep=""), quote="\"")
y_train <- read.table(paste(root_path,"/train/y_train.txt",sep=""), quote="\"")

features <- read.table(paste(root_path,"/features.txt",sep=""), quote="\"")
activity_labels <- read.table(paste(root_path,"/activity_labels.txt",sep=""), quote="\"")

###### 1.2: merge datasets by rows
Subject <- rbind(subject_test, subject_train)
colnames(Subject) <- "SubjectNumber"

Label <- rbind(y_test, y_train)
colnames(Label) <- "Label"
LabelActual <- merge(Label, activity_labels, by=1) #Step 3, 4
LabelActual <- LabelActual[,-1]

DataSet <- rbind(X_test, X_train)
colnames(DataSet) <- features[,2]

###### 1.3: merge datasets into one big data set
DataTotal <- cbind(Subject, LabelActual, DataSet)

####################################################
#Step 2: Extracts only the measurements on the mean and standard deviation 
#        for each measurement. (assignment point 2)
####################################################

toMatch <- c("mean\\(\\)", "std\\(\\)") #Matches mean and std
matches <- grep(paste(toMatch,collapse="|"), features[,2], value=FALSE)
matches <- matches+2 #To compensate for the 2 new extra rows in the beginning

####### Create new dataset that only includes description labels, subject and mean + std
DataMeanStd <- DataTotal[,c(1,2,matches)]

####### Prints the data table to a file
write.table(DataMeanStd, paste(root_path,"/TidyData.txt",sep=""), sep = ";")

#####################################################
#Step 3: Creates a second, independent tidy data set with the average of each 
#        variable for each activity and each subject. (assignment point 5)
####################################################

####### install reshape2 package if dosn't exist
if (!require("reshape2")) {
  install.packages("reshape2")
  require("reshape2")
}

####### Creates a "skinny data set" on the basis of subject and activity
####### Note that there are no measure variables as to collapse dublicate
####### variables in the "features" data set
MeltData = melt(DataTotal, id.var = c("SubjectNumber", "LabelActual"))

AveLabAct = dcast(MeltData, SubjectNumber + LabelActual ~ variable,mean)
######  Please note that some the meassure variables are collapsed as the 
###### "features" dataset has some dublicate values, i.e. 561-479=82.

###### Write the table to the forlder
write.table(AveLabAct, paste(root_path,"/TidyAveData.txt",sep=""), sep = ";")
