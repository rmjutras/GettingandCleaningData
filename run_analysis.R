library(qdap)
library(plyr)
#Acquiring files
download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","UCI_HAR_Dataset")
unzip("UCI_HAR_Dataset")
X_test<-read.table("~/UCI HAR Dataset/test/X_test.txt")
subject_test<-read.table("~/UCI HAR Dataset/test/subject_test.txt")
y_test<-read.table("~/UCI HAR Dataset/test/y_test.txt")
X_train<-read.table("~/UCI HAR Dataset/train/X_train.txt")
subject_train<-read.table("~/UCI HAR Dataset/train/subject_train.txt")
y_train<-read.table("~/UCI HAR Dataset/train/y_train.txt")
features<-read.table("~/UCI HAR Dataset/features.txt")
activitylabels<-read.table("UCI HAR Dataset/activity_labels.txt")
names(X_test)<-features[,2]
names(X_train)<-features[,2]
names(y_test)<-"Activity_Labels"
names(y_train)<-"Activity_Labels"
names(subject_test)<-"Subject_ID"
names(subject_train)<-"Subject_ID"

#start to clean up data by combining subject id and activity labels to original data and row binding test and train datasets
y_test<-cbind(subject_test,y_test)
X_test<-cbind(y_test,X_test)
y_train<-cbind(subject_train,y_train)
X_train<-cbind(y_train,X_train)
X<-rbind(X_test,X_train)

#take out unnecessary columns (i.e. anything other than means and stds)
keepcols<-c(TRUE,TRUE,(grepl("mean",colnames(X)[3:563])|grepl("std",colnames(X)[3:563])))
X<-X[,keepcols]

#Make better descriptive labels and variables
activitynames<-mgsub(c(1:6),c("Walking","Walking Upstairs","Walking Downstairs","Sitting","Standing","Laying"),X$Activity_Labels)
X$Activity_Labels<-activitynames
colnames(X)<-gsub("-","_",colnames(X))
colnames(X)[3:81]<-gsub("mean\\()","Mean",colnames(X)[3:81])
colnames(X)[3:81]<-gsub("std\\()","Std_Dev",colnames(X)[3:81])
colnames(X)[3:81]<-gsub("t","time_",colnames(X)[3:81])
colnames(X)[3:81]<-gsub("f","freq_",colnames(X)[3:81])

#average by subjet and activity
test<-ddply(X,.(Subject_ID,Activity_Labels),colwise(mean))

