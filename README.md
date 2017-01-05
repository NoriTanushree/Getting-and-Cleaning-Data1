# Getting-and-Cleaning-Data Course Assignment
Coursera- Johns Hopkins Data Science Specialization

As a course project for the third course in the data science specialization, the run_analysis code aims to do the following:

1. Download and unzip the raw data files
2. Load the activity and features information and then filter specifically for those features which provide mean() or sd() information
3. Convert activity and feature information from factor to character data type
4. Load the test and the training datasets,bind them together, re-name the columns and filter from the bound dataset, those columns
   extracted from step-2-having mean() and sd() feature information
5. Create a final, tidy dataset that consists of the mean and sd values of each variable for each subject and activity pair
   

The output is in the file tidy_final.txt

