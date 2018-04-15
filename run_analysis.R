
#downloaded my file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#Had a difficulty writing it, and followed foot step from other work. 
#Try to do it my self by rewrting it againg


# 1. Merge the Training and Test Data sets Together

xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/y_train.txt")
subjecttrain <- read.table("train/subject_train.txt")
xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/y_test.txt")
subjecttest <- read.table("test/subject_test.txt")
xdata <- rbind(xtrain, xtest)
ydata <- rbind(ytrain, ytest)
subjectdata <- rbind(subjecttrain, subjecttest)

# 2. Only Extract the Measurements on the Mean and Standard Deviation
features <- read.table("features.txt")
mean_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
xdata <- xdata[, mean_std_features]
names(xdata) <- features[mean_std_features, 2]


# 3. Use Descriptive Activity Names to Name the Activities in the Data Set
read <- read.table("activity_labels.txt")
ydata[, 1] <- activities[ydata[, 1], 2]
names(ydata) <- "activity"

# 4. Appropriately Label the Data Set with Descriptive Variable Names=
names(subjectdata) <- "subject"
alldata <- cbind(xdata, ydata, subjectdata)

# 5. Create a second, independent tidy data set with the average of each variable for 
compy<- ddply(alldata, .(subject, activity), function(x) colMeans(x[, 1:66]))

write.table(compy, "compy.txt", row.name=FALSE) 
