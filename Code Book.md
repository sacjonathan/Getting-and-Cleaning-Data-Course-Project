# Getting-and-Cleaning-Data-Course-Project

## 1. Reading the files in the UCI HAR Dataset file
* TestSubject : subject IDs for test
* Trainsubject  : subject IDs for train
* TestFeatures : values of variables in test
* TrainFeatures : values of variables in train
* TestActivity : activity ID in test
* TrainActivity : activity ID in train
* ActivityLabels : Description of activity IDs in TestActivity and TrainActivity
* FeaturesNames : Description of each variable in TestFeatures and Trainfeatures

## 2. Merging the datasets
* Subject : merge (rbind) of TestSubject and TrainSubject
* Activity : merge (rbind) of TestActivity and TrainActivity
* Features : merge (rbind) of TestFeatures and TrainFeatures
* CompleteData : merge (cbind) of Subject,Activity and Features

## 3. Changing the column names of Features
Replacing the column names in Features with the names in the second column of FeaturesNames

## 4. Extracting mean() and std() columns
Create a vector of only mean and std labels, then use the vector to subset SelectedData
* MeanandSTDColumns : a vector of column numbers of only mean and std labels extracted from Features (2nd column)
* SelectedColumns : a vector that contains the column numbers of MeanandSTDColumns and the columns Activity and Subject
* SelectedData : A dataset of the columns with mean() and std() in their labels and the columns Activity and Subject

## 5. Replacing the ID codes in Activity column with descriptions on ActivityLabels

Formats the data on SelectedData$Activity as character and then it replaces it with the descriptions on ActivityLabels using the Activity ID.

## 6. Replacing the current column names for descriptive Names

Renames the columns in SelectedData into descriptive column names:
* Changes "Acc" to "Accelerometer"
* Changes "Gyro" to "Gyroscope"
* Changes "BodyBody" to "Body"
* Changes "Mag" to "Magnitude"
* Changes "^t" to "Time"
* Changes "^f" to "Frequency"
* Changes "tBody" to "TimeBody"
* Changes "-mean()" to "Mean"
* Changes "-std()" to "STD"
* Changes "-freq()" to "Frequency"
* Changes "angle" to "Angle"
* Changes "gravity" to "Gravity"

## 7. Setting Activity and Subject as factors
In this part, we set the columns Activity and Subject as factors in order to use them to aggregate the table "SelectedData".

## 8. Outputting a tidy dataset
In this part, we create a new table "TidyDataset" which is the aggregate of "SelectedData" by the columns "Subject" and "Activity". Next, the data is ordered by the columns "Subject" and "Activity" and finally, we create the file "TidyDataset.txt".
