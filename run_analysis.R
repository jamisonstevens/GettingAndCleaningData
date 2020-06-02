run_analysis <- function() {
  #install.packages("dplyr")
  library(dplyr)
  
  setwd("/Users/student/Documents/Learning/R/GettingAndCleaningData")
  
  # Read Activity File
  activity_file <- paste(getwd(), "/activity_labels.txt", sep = "")
  activity_labels <- read.table(activity_file, col.names = c("Activity Code", "Activity"))
  
  # Read Features File
  features_file <- paste(getwd(), "/features.txt", sep = "")
  features <- read.table(features_file, col.names = c("Function Code", "Function"))
  
  # Read Test Files
  test_files = paste(getwd(), "/test/", list.files(path = "test/", pattern = "*.txt"), sep = "")
  subject_test <- read.table(test_files[1], col.names = "Subject Number")
  x_test <- read.table(test_files[2], col.names = features$Function)
  y_test <- read.table(test_files[3], col.names = "Activity Code")
  
  # Read Train Files
  train_files = paste(getwd(), "/train/", list.files(path = "train/", pattern = "*.txt"), sep = "")
  subject_train <- read.table(train_files[1], col.names = "Subject Number")
  x_train <- read.table(train_files[2], col.names = features$Function)
  y_train <- read.table(train_files[3], col.names = "Activity Code")
  
  # Row Bind Test and Train Files
  subject <- rbind(subject_train, subject_test)
  x <- rbind(x_train, x_test)
  y <- rbind(y_train, y_test)
  
  # Column Bind subject, x, and y
  Test_Train_Data <- cbind(subject, y, x)
  
  # Extract Mean and STDev columns from Test_Train_Data
  Mean_STDev_Data <- Test_Train_Data %>% select(Subject.Number, Activity.Code, contains("mean"), contains("std"))
  
  # Use Activity Code to determine Activity Names
  Mean_STDev_Data$Activity.Code <- activity_labels[Mean_STDev_Data$Activity.Code, "Activity"]
  names(Mean_STDev_Data)[2] <- "Activity"
  
  # Create More Descriptive Variable Names
  names(Mean_STDev_Data) <- sub("^t", "TimeDomain", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- sub("^f", "FrequencyDomain", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("Acc", "Accelerometer", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("Gyro", "Gyroscope", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("BodyBody", "Body", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("mean", "Mean", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("std", "StandardDeviation", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("Mag", "Magnitude", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("()", "", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("angle", "Angle", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("gravity", "Gravity", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("\\.", "", names(Mean_STDev_Data))
  names(Mean_STDev_Data) <- gsub("tBody", "TimeBody", names(Mean_STDev_Data))
  
  # Data Set of Averages by Subject
  Average_Data <- Mean_STDev_Data %>% group_by(SubjectNumber, Activity) %>% summarize_all(list(mean))
  write.table(Average_Data, "AverageData.txt")
  Average_Table <- read.table(paste(getwd(), "/AverageData.txt", sep = ""))
}