This file describes the logic for run_analysis.R.

run_analysis.R contains a function run_analysis() that can be called in the console.
This function performs the actions listed in the directions for the Getting and Cleaning Data Final Project.
The first few lines of this function create file addresses and read the files at those addresses.
Those files are activity.txt, features.txt, and the files in the test and train folders.
These files were downloaded from the zip folder in the project instructions.

The next lines of code row bind the subject, x, and y data together for the train and test data.
The results of the row binded data are then binded as columns to create a data set that includes all of the subject, x, and y data for the train and test data.

Next, chaining operators were used to extract the mean and standard deviation data from the data set, and then the activity codes from the data set were changed to their corresponding activities.

After this, the column names were changed so that they made more sense.  This was done with sub() and gsub().

To create the new data set of averages by subject and activity, chaining operators were used to group the data by subject number and activity.  The means for each of the functions were then found for each subject number and activity.
The resulting data was put into a text file, which was then read and returned.
