# 1. Merges the training and the test sets to create one data set.

df_xtrain <- read.table('UCI HAR Dataset/train/X_train.txt', header = FALSE)
df_ytrain <- read.table('UCI HAR Dataset/train/y_train.txt', header = FALSE)
df_subtrain <- read.table('UCI HAR Dataset/train/subject_train.txt', header = FALSE)

df_xtest <- read.table('UCI HAR Dataset/test/X_test.txt', header = FALSE)
df_ytest <- read.table('UCI HAR Dataset/test/y_test.txt', header = FALSE)
df_subtest <- read.table('UCI HAR Dataset/test/subject_test.txt', header = FALSE)

train_all<-cbind(df_xtrain, df_ytrain,df_subtrain)
test_all<-cbind(df_xtest, df_ytest, df_subtest)

# combining test and train
df_combined<-rbind(train_all, test_all)

features_read<-read.table("UCI HAR Dataset/features.txt")
y<-as.character(features_read$V2)
colnames(df_combined)[1:561]<-y

colnames(df_combined)[562]<-"Activity_id"
colnames(df_combined)[563]<-"Subject"

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
mean_sd<-df_combined[, grep("mean\\(\\)|std\\(\\)", colnames(df_combined))]

# 3. Uses descriptive activity names to name the activities in the data set
act_label<-read.table("UCI HAR Dataset/activity_labels.txt")

df_combined$Activity_id[df_combined$Activity_id==1]<-"WALKING"
df_combined$Activity_id[df_combined$Activity_id==2]<-"WALKING_UPSTAIRS"
df_combined$Activity_id[df_combined$Activity_id==3]<-"WALKING_DOWNSTAIRS"
df_combined$Activity_id[df_combined$Activity_id==4]<-"SITTING"
df_combined$Activity_id[df_combined$Activity_id==5]<-"STANDING"
df_combined$Activity_id[df_combined$Activity_id==6]<-"LAYING"

# 4. Appropriately labels the data set with descriptive variable names. 

names(df_combined) <- gsub("^t", "time", names(df_combined))
names(df_combined) <- gsub("^f", "frequency", names(df_combined))
names(df_combined) <- gsub("sma", "Signal magnitude area", names(df_combined))
names(df_combined) <- gsub("Acc", "Accelerator", names(df_combined))
names(df_combined) <- gsub("Mag", "Magnitude", names(df_combined))


# 5. From the data set in step 4, creates a second, 
#independent tidy data set with the average of each variable 
#for each activity and each subject.
#install.packages("reshape2")

library(reshape2)
act_subj<-df_combined[, grep("Activity_id|Subject|mean\\(\\)", colnames(df_combined))]
new_df<-data.frame()
new_df<-melt(act_subj, id.vars = c("Activity_id", "Subject"))


subj_act_mean<-dcast(new_df, Subject + Activity_id ~variable, mean)

# #install.packages("plyr")
# library(plyr)

write.table(subj_act_mean, file = "tidydata.txt",row.name=FALSE)
tidy_d<-read.table("tidydata.txt")
