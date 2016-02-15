## STEP 1: Merges the training and the test sets to create one tidy data set


# Read the activity rows for test
activitytest<-read.table("UCI HAR Dataset/test/y_test.txt",, header=F)

# Read the activity rows for train
activitytrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)

# Add the test and train data together
activity<-rbind(activitytest, activitytrain)


# Read the subject rows for test
subjecttest<-read.table("UCI HAR Dataset/test/subject_test.txt", header=F)

# Read the subject rows for train
subjecttrain<-read.table("UCI HAR Dataset/train/subject_train.txt", header=F)

# Add the test and train data together
subject<-rbind(subjecttest, subjecttrain)

# Create a column name
colnames(activity)<-"Activity"
colnames(subject)<-“Subject"

# Read the featurelabels for the columns of the test and train data
featurelabels<-read.table(“UCI HAR Dataset/features.txt”, header=F, sep=" ")
colnames(featurelabels)<-c("featurenr", "featurename")

# Read the x-test feature data
featurestest<-read.table("UCI HAR Dataset/test/x_test.txt”, header=F)

# Read the x-train feature data
featurestrain<-read.table("UCI HAR Dataset/train/x_train.txt”, header=F)

# Add the test and train data together
features<-rbind(featurestest, featurestrain)

# Create column names for the featurelabels
colnames(features) <- make.names(featurelabels$featurename, unique=TRUE)

# add the activity, subject feature data together
data<-cbind(activity, subject, features)

## STEP 2: Extracts only the measurements on the mean and standard deviation for each measurement

# Create a new table containing only columns with subjects, activity, mean and std
datameanstd <- select(data,matches("Subject|Activity|mean|std"))

# Check the structure
dim(datameanstd)


## STEP 3: Uses descriptive activity names to name the activities in the data set
# Read the labels for the activities
activitylabels<-read.table(“./UCI HAR Dataset/activity_labels.txt", header=F, sep=" ")
# Check the structure
head(activitylabels)
# Create column names for activity labels
colnames(activitylabels)<- c("activityid","activity")

# Add the activity label to the dataset using a merge on activityid
data <- merge(x=datameanstd, y=activitylabels)

# Exclude the activityid field
data <- select(data, -activityid)

## STEP 4: Appropriately labels the data set with descriptive

## activity names.
names(data)<-gsub("Acc", "Accelerometer", names(data))
names(data)<-gsub("Gyro", "Gyroscope", names(data))
names(data)<-gsub("BodyBody", "Body", names(data))
names(data)<-gsub("Mag", "Magnitude", names(data))
names(data)<-gsub("^t", "Time", names(data))
names(data)<-gsub("^f", "Frequency", names(data))
names(data)<-gsub("tBody", "TimeBody", names(data))
names(data)<-gsub("-mean()", "Mean", names(data), ignore.case = TRUE)
names(data)<-gsub("-std()", "STD", names(data), ignore.case = TRUE)
names(data)<-gsub("-freq()", "Frequency", names(data), ignore.case = TRUE)
names(data)<-gsub("angle", "Angle", names(data))
names(data)<-gsub("gravity", "Gravity", names(data))

## STEP 5: Creates a second, independent tidy data set with the

## average of each variable for each activity and each subject.
library(plyr);
tdata<-aggregate(. ~Subject + activity, data, mean)
tdata<-tdata[order(tdata$Subject,tdata$activity),]
write.table(tdata, file = "tidydata.txt",row.name=FALSE)

