#Asuming that the zip file was downloaded and unzipped to the working directory
##Reading the files in the UCI HAR Dataset file
FeaturesNames<-read.table("UCI HAR Dataset/features.txt")
ActivityLabels<- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)
TrainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
TrainActivity <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
TrainFeatures <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
TestSubject <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
TestActivity <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
TestFeatures <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

##merging the Train dataset to the Test dataset
Subject <- rbind(TrainSubject, TestSubject)
Activity <- rbind(TrainActivity, TestActivity)
Features <- rbind(TrainFeatures, TestFeatures)

##Naming the column names in features

colnames(Features) <- t(FeaturesNames[2])
colnames(Activity) <- "Activity"
colnames(Subject) <- "Subject"
CompleteData <- cbind(Features,Activity,Subject)

##Extracts the mean and STD columns
MeanandSTDColumns<-columnsWithMeanSTD <- grep("*Mean*|*Std*", names(CompleteData), ignore.case=TRUE)
SelectedColumns <- c(MeanandSTDColumns, 562, 563)
SelectedData <- CompleteData[,SelectedColumns]

##Replacing the current column names for descriptive Names
SelectedData$Activity <- as.character(SelectedData$Activity)
for (i in 1:6){
  SelectedData$Activity[SelectedData$Activity == i] <- as.character(ActivityLabels[i,2])
}

names(SelectedData)<-gsub("Acc", "Accelerometer", names(SelectedData))
names(SelectedData)<-gsub("Gyro", "Gyroscope", names(SelectedData))
names(SelectedData)<-gsub("BodyBody", "Body", names(SelectedData))
names(SelectedData)<-gsub("Mag", "Magnitude", names(SelectedData))
names(SelectedData)<-gsub("^t", "Time", names(SelectedData))
names(SelectedData)<-gsub("^f", "Frequency", names(SelectedData))
names(SelectedData)<-gsub("tBody", "TimeBody", names(SelectedData))
names(SelectedData)<-gsub("-mean()", "Mean", names(SelectedData), ignore.case = TRUE)
names(SelectedData)<-gsub("-std()", "STD", names(SelectedData), ignore.case = TRUE)
names(SelectedData)<-gsub("-freq()", "Frequency", names(SelectedData), ignore.case = TRUE)
names(SelectedData)<-gsub("angle", "Angle", names(SelectedData))
names(SelectedData)<-gsub("gravity", "Gravity", names(SelectedData))

SelectedData$Activity <- as.factor(SelectedData$Activity)
SelectedData$Subject <- as.factor(SelectedData$Subject)
SelectedData <- data.table(SelectedData)

TidyDataset <- aggregate(. ~Subject + Activity, SelectedData, mean)
TidyDataset <- TidyDataset[order(TidyDataset$Subject,TidyDataset$Activity),]
write.table(TidyDataset, file = "TidyDataset.txt", row.names = FALSE)
