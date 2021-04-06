library(dplyr)

#Merges the training and the test sets to create one data set.

setwd("./UCI HAR Dataset")
train_data <- read.table("train/X_train.txt")
train_labels <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
test_data <- read.table("test/X_test.txt")
test_labels <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

col_names <- readLines("features.txt")
colnames(train_data)<-make.names(col_names)
colnames(test_data)<-make.names(col_names)
colnames(train_labels)<-"label"
colnames(test_labels)<-"label"
colnames(subject_test) <- "subjectID"
colnames(subject_train) <- "subjectID"

train_final<-cbind(train_labels,subject_train, train_data)
test_final<-cbind(test_labels,subject_test, test_data)
finalmutate_data<-rbind(train_final,test_final)


#Extracts only the measurements on the mean and standard deviation for each measurement. 
namesdt <- names(finalmutate_data)
sbs <- grepl("std()|mean()", namesdt)| grepl("subjectID", namesdt) |  grepl("label", namesdt)  
std_mean_measurement <- finalmutate_data[sbs]

#Uses descriptive activity names to name the activities in the data set
std_mean_measurement$label[std_mean_measurement$label == "1"] <- "WALKING"
std_mean_measurement$label[std_mean_measurement$label == "2"] <- "WALKING_UPSTAIRS"
std_mean_measurement$label[std_mean_measurement$label == "3"] <- "WALKING_DOWNSTAIRS"
std_mean_measurement$label[std_mean_measurement$label == "4"] <- "SITTING"
std_mean_measurement$label[std_mean_measurement$label == "5"] <- "STANDING"
std_mean_measurement$label[std_mean_measurement$label == "6"] <- "LAYING"

#Appropriately labels the data set with descriptive variable names. 
colnames(std_mean_measurement)<- sub("X[0-9]([0-9])?([0-9])?.","", colnames(std_mean_measurement))
colnames(std_mean_measurement) <- sub("^f", "frequency", colnames(std_mean_measurement))
colnames(std_mean_measurement) <- sub("^t", "time", colnames(std_mean_measurement))
colnames(std_mean_measurement) <- sub("Acc", "Accelerometer", colnames(std_mean_measurement))
colnames(std_mean_measurement) <- sub("Gyro", "Gyroscope", colnames(std_mean_measurement))
colnames(std_mean_measurement) <- sub("Mag", "Magnitude", colnames(std_mean_measurement))


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
agg <- aggregate(std_mean_measurement, by = list(std_mean_measurement$subjectID, std_mean_measurement$label), FUN = mean)
agg <- agg[order(agg$Group.1, agg$Group.2),]
agg1 <- subset(agg, select = -c(label, subjectID))
colnames(agg1) <- sub("Group.1", "SubjectID", colnames(agg1))
colnames(agg1) <- sub("Group.2", "Activity", colnames(agg1))
write.table(agg1, "Tidydata.txt", row.names = FALSE)