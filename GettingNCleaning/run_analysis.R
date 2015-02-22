run_analysis <- function(){
  
  # read Subject, Activity Labels from the test directory
  testsub = read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
  colnames(testsub)<-"Subject"  
  testlbl = read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
  colnames(testlbl)<-"Activity"  
  # read and map activity labels
  acttbl = read.table("UCI HAR Dataset/activity_labels.txt", header=FALSE)
  for(a in 1:nrow(testlbl)){
    testlbl[a,1] <- as.character(acttbl[acttbl[,1]==testlbl[a,1],2])
  }
  
  # Read and assign column names for the data vector
  testnames = read.table("UCI HAR Dataset/features.txt", header=FALSE)  
  testvalues = read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
  colnames(testvalues)<- testnames[,2]
  testtbl = cbind(testsub,testlbl,testvalues)
  
  # read Subject, Activity Labels from the training directory
  trainsub = read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE)
  colnames(trainsub)<-"Subject"
  
  trainlbl = read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE)
  colnames(trainlbl)<-"Activity"
  for(a in 1:nrow(testlbl)){
    trainlbl[a,1] <- as.character(acttbl[acttbl[,1]==trainlbl[a,1],2])
  }
  # Assign column names for the data vector
  trainvalues = read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE)
  colnames(trainvalues)<- testnames[,2]
  traintbl = cbind(testsub,trainlbl,trainvalues)
  # Merge TrainMing and test data
  completetbl = rbind(testtbl,traintbl)
  
  # Assign Unique Column Names
  valid_column_names <- make.names(names=names(completetbl),unique=TRUE, allow_=TRUE)
  names(completetbl) <- valid_column_names
  
  # Select columnsm, names in which  contain "meana" and "std"
  completetbl = cbind(select(completetbl,Subject, Activity),
                  select(completetbl,contains("mean")),
                  select(completetbl,contains("std"))
                  )
  
  
  subvec <- unique(completetbl[,1])
  actvec <- unique(completetbl[,2])
  colnames <- names(completetbl)
  meantable <- data.frame(Subject=numeric(),Ativity=numeric(),Measure=numeric(),Average=numeric())
 
  # Calculate mean of the measured values for each subject, activity and type of measure.
  for(b in 1:length(subvec)){
    for(c in 1:length(actvec)){
      completetbl.f <- filter(completetbl, Subject == subvec[b] & Activity == actvec[c] )
      for(d in 3:length(colnames)){         
          meantable[nrow(meantable)+1,] <- list(subvec[b],actvec[c],colnames[d],mean(completetbl.f[,d]))
          
     }
      
    }
    
  }
  # Write the table to a file
  write.table(meantable,file="ActivityVariableMean.txt", row.name=FALSE)
  
}

