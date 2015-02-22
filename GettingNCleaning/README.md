#Producing Tidy data for Human Activity Recognition Using Smartphones Dataset
##run_analysis.R
*The script cleans the Samsung Dataset
*The script assumes the dataset directory "UCI HAR Dataset" is available in the working directory. 
*The script cleans and consolidates the data in the files subject_test.txt, y_test.txt, activity_labels.txt, X_test.txt from both Test and Training directories 
*first, the script prepares a in-memory table by integrating the data from the files subject_test.txt, y_test.txt, X_test.txt in test. It reads activity_labels.txt and assigns names to the tables columns. 
*The above step is repeated for training directory.
*The script merges the data in Test and training tables. 
*The combined table retains all the columns that has mean and std in their names and rest of the columns are discarded. 
*The mean of all the values for a combination of Subject, Activity and Measure is colculated. 
*The script outputs all the means in the table format to the file "ActivityVariableMean.txt"
*The description of the output data is provided in the file "ActivityVariableMean_DataDictionary.txt" 
