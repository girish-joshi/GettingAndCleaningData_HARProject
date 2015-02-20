# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


run_analysis <-function() {
  
  dirPath<-"./UCI HAR Dataset/"
  
  XTrainPath<-paste(dirPath,"train/X_train.txt",sep="")
  YTrainPath<-paste(dirPath,"train/y_train.txt",sep="")
  SubjectTrainPath<-paste(dirPath,"train/subject_train.txt",sep="")
  
  XTestPath<-paste(dirPath,"test/X_test.txt",sep="")
  YTestPath<-paste(dirPath,"test/y_test.txt",sep="")
  SubjectTestPath<-paste(dirPath,"test/subject_test.txt",sep="")
  
  
  colClassesFeatures<-c("integer","character")
  colNamesFeatures<-c("FeatureID","FeatureName")
  
  #rowsToRead <- 100
  rowsToRead <- -1
  
  # Prepare Features - to get only mean and std fatures
  
  Features<-read.table("UCI HAR Dataset/features.txt",header=FALSE, comment.char = "",colClasses=colClassesFeatures, col.names=colNamesFeatures)
  
  colClassesXFeatures<-rep("numeric",times=nrow(Features))
  FeatureNames<-vector(mode = "character")
  
  counter<-0
  for(idx in 1:nrow(Features)) {

    featureName<-Features[idx,"FeatureName"]
    
    if(length(grep("-mean()",featureName,fixed=TRUE))==1 || length(grep("-std()",featureName,fixed=TRUE))==1) {
      #print(paste("Mean or Std at ",idx," ",featureName))
      
      counter<-counter+1
      FeatureNames[counter]<-featureName
    }
    else {
      colClassesXFeatures[idx]<-"NULL"
    }
    
  }
    
  # Prepare Train Data
  
  XTrain<-read.table(XTrainPath,header=FALSE,comment.char = "",colClasses=colClassesXFeatures, col.names=Features[,"FeatureName"],nrows=rowsToRead, check.names=FALSE)
  
  YTrain<-read.table(YTrainPath,header=FALSE, comment.char = "",colClasses="integer", col.names="ActivityID",nrows=rowsToRead, check.names=FALSE)
  
  SubjectTrain<-read.table(SubjectTrainPath,header=FALSE, comment.char = "",colClasses="integer", col.names="SubjectID",nrows=rowsToRead, check.names=FALSE)
  
  TrainData<-cbind(SubjectTrain,XTrain,YTrain)
  
  # Prepare Test Data
  XTest<-read.table(XTestPath,header=FALSE,comment.char = "",colClasses=colClassesXFeatures, col.names=Features[,"FeatureName"],nrows=rowsToRead, check.names=FALSE)
  
  YTest<-read.table(YTestPath,header=FALSE, comment.char = "",colClasses="integer", col.names="ActivityID",nrows=rowsToRead, check.names=FALSE)
  
  SubjectTest<-read.table(SubjectTestPath,header=FALSE, comment.char = "",colClasses="integer", col.names="SubjectID",nrows=rowsToRead, check.names=FALSE)
  
  TestData<-cbind(SubjectTest,XTest,YTest)
  
  # Merge Train and Test Data
  
  UCIData <- rbind(TrainData,TestData)
  
  
  # Uses descriptive activity names to name the activities in the data set
  
  ActivityLabels<-read.table("UCI HAR Dataset/activity_labels.txt",header=FALSE, comment.char = "",colClasses=c("integer","character"), col.names=c("ActivityID","ActivityName"))
  
  
  UCIDataWithLabels<-merge(UCIData,ActivityLabels,sort=FALSE)

  # Appropriately labels the data set with descriptive variable names. 

  newNames<-c("Average of Body Linear Acceleration on X axis in Time domain","Average of Body Linear Acceleration on Y axis in Time domain","Average of Body Linear Acceleration on Z axis in Time domain","Standard Deviation of Body Linear Acceleration on X axis in Time domain","Standard Deviation of Body Linear Acceleration on Y axis in Time domain","Standard Deviation of Body Linear Acceleration on Z axis in Time domain","Average of Gravity Linear Acceleration on X axis in Time domain","Average of Gravity Linear Acceleration on Y axis in Time domain","Average of Gravity Linear Acceleration on Z axis in Time domain","Standard Deviation of Gravity Linear Acceleration on X axis in Time domain","Standard Deviation of Gravity Linear Acceleration on Y axis in Time domain","Standard Deviation of Gravity Linear Acceleration on Z axis in Time domain","Average of Linear Jerk on X axis in Time domain","Average of Linear Jerk on Y axis in Time domain","Average of Linear Jerk on Z axis in Time domain","Standard Deviation of Linear Jerk on X axis in Time domain","Standard Deviation of Linear Jerk on Y axis in Time domain","Standard Deviation of Linear Jerk on Z axis in Time domain","Average of Body Angular Velocity on X axis in Time domain","Average of Body Angular Velocity on Y axis in Time domain","Average of Body Angular Velocity on Z axis in Time domain","Standard Deviation of Body Angular Velocity on X axis in Time domain","Standard Deviation of Body Angular Velocity on Y axis in Time domain","Standard Deviation of Body Angular Velocity on Z axis in Time domain","Average of Angular Jerk on X axis in Time domain","Average of Angular Jerk on Y axis in Time domain","Average of Angular Jerk on Z axis in Time domain","Standard Deviation of Angular Jerk on X axis in Time domain","Standard Deviation of Angular Jerk on Y axis in Time domain","Standard Deviation of Angular Jerk on Z axis in Time domain","Average of Triaxial Body Linear Acceleration (Euclidean Magnitude) in Time domain","Standard Deviation of Triaxial Body Linear Acceleration (Euclidean Magnitude) in Time domain","Average of Triaxial Body Gravity Acceleration (Euclidean Magnitude) in Time domain","Standard Deviation of Triaxial Gravity Linear Acceleration (Euclidean Magnitude) in Time domain","Average of Triaxial Linear Jerk (Euclidean Magnitude) in Time domain","Standard Deviation of Triaxial Linear Jerk (Euclidean Magnitude) in Time domain","Average of Triaxial Body Angular Velocity (Euclidean Magnitude) in Time domain","Standard Deviation of Triaxial Body Angular Velocity (Euclidean Magnitude) in Time domain","Average of Triaxial Angular Jerk (Euclidean Magnitude) in Time domain","Standard Deviation of Triaxial Angular Jerk (Euclidean Magnitude) in Time domain","Average of Body Linear Acceleration on X axis in Frequency domain","Average of Body Linear Acceleration on Y axis in Frequency domain","Average of Body Linear Acceleration on Z axis in Frequency domain","Standard Deviation of Body Linear Acceleration on X axis in Frequency domain","Standard Deviation of Body Linear Acceleration on Y axis in Frequency domain","Standard Deviation of Body Linear Acceleration on Z axis in Frequency domain")
  newNames<-c(newNames,"Average of Linear Jerk on X axis in Frequency domain","Average of Linear Jerk on Y axis in Frequency domain","Average of Linear Jerk on Z axis in Frequency domain","Standard Deviation of Linear Jerk on X axis in Frequency domain","Standard Deviation of Linear Jerk on Y axis in Frequency domain","Standard Deviation of Linear Jerk on Z axis in Frequency domain","Average of Body Angular Velocity on X axis in Frequency domain","Average of Body Angular Velocity on Y axis in Frequency domain","Average of Body Angular Velocity on Z axis in Frequency domain","Standard Deviation of Body Angular Velocity on X axis in Frequency domain","Standard Deviation of Body Angular Velocity on Y axis in Frequency domain","Standard Deviation of Body Angular Velocity on Z axis in Frequency domain","Average of Triaxial Body Linear Acceleration (Euclidean Magnitude) in Frequency domain","Standard Deviation of Triaxial Body Linear Acceleration (Euclidean Magnitude) in Frequency domain","Average of Triaxial Linear Jerk (Euclidean Magnitude) in Frequency domain","Standard Deviation of Triaxial Linear Jerk (Euclidean Magnitude) in Frequency domain","Average of Triaxial Body Angular Velocity (Euclidean Magnitude) in Frequency domain","Standard Deviation of Triaxial Body Angular Velocity (Euclidean Magnitude) in Frequency domain","Average of Triaxial Angular Jerk (Euclidean Magnitude) in Frequency domain","Standard Deviation of Triaxial Angular Jerk (Euclidean Magnitude) in Frequency domain")
  
  newFeatureNames <- newNames
  newNames <- c("ActivityID","SubjectID",newNames,"ActivityName")
  
  names(UCIDataWithLabels)<-newNames
  
  
  # From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  aggDF<-aggregate.data.frame(subset(UCIDataWithLabels,select=newFeatureNames),by=list(SubjectID=UCIDataWithLabels$SubjectID,ActivityName=UCIDataWithLabels$ActivityName),FUN=mean)
  
  print("Done!")
  return(aggDF)
}
