##Getting and Cleaning data week 4

## Calculate the mean on the dataset
Mean_dataset <- function(Data_Set)
{
    ## Do a group by on Activity and Subject, then use the mean on the rest of the columns
    Data_Set %>% group_by(Activity_Name, subject) %>% summarise_each(funs(mean));
    write.table(Data_Set, file="tidydata.txt", row.names = FALSE)
}

##Create a clean data set
dataset <- function()
{
    ## Download file
    if(!file.exists("./data")){dir.create("./data")}
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl,destfile="./data/Dataset.zip")
    
    unzip(zipfile="./data/Dataset.zip",exdir="./data")
  
    ## Perform the function on the test data and train data
    TestData <- Read_Data("test");
    TrainData <- Read_Data("train");
    
    ## Combine the testData and TrainData
    EndData <- rbind(TestData,TrainData);
    
    ##Change the column names to descriptive names
    colnames(EndData)<-gsub("Acc", "Accelerometer", colnames(EndData))
    colnames(EndData)<-gsub("Gyro", "Gyroscope", colnames(EndData))
    colnames(EndData)<-gsub("Mag", "Magnitude", colnames(EndData))
    colnames(EndData)<-gsub("\\.", "", colnames(EndData))
    
    EndData
    
}

Read_Data <- function(NameSet){
  ## Get the activity ID data
  Y_Data <- read.table(paste("./data/UCI HAR Dataset/", NameSet, "/y_", NameSet, ".txt", sep=""), col.names = "Activity_ID");
  
  ## Get the subject ID Data
  subject_Data <- read.table(paste("./data/UCI HAR Dataset/", NameSet, "/subject_", NameSet, ".txt", sep =""), col.names = "subject");
  
  ## Get the colnames of the measurements
  features <- read.table("./data/UCI HAR Dataset/features.txt");
  
  ## The colnames are avaible in the second column
  headerData <- features[,2];
  
  ## Read the measurements with the headerData for the colnames
  X_ColumnNames <- read.table(paste("./data/UCI HAR Dataset/", NameSet, "/X_", NameSet, ".txt",sep=""), col.names = headerData);
  
  ##Filter out the columns with measurements related to mean and standard deviation
  X_Data <- X_ColumnNames[,grep("Mean|mean|std", colnames(X_ColumnNames))];
  
  ## Combine the subject ID data and the measurement data
  EndSet <- cbind(subject_Data, X_Data);
  
  ## Read the activity labels 
  Activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("Activity_ID", "Activity_Name"));
  
  ## Merge the activity names with the activity data
  Activity_subjects <- merge(Y_Data, activity_labels, sort = FALSE);
  
  ## Get only the activity names
  Activity_Name <- Activity_subjects[,2];
  
  ## Combine the subject ID data and the measurement data
  cbind(Activity_Name, EndSet);

}

