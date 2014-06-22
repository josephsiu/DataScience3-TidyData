## README for run_analysis.R

**Description:** 
The R script was created to process the "Human Activity Recognition Using Smartphones Data" based on the requirements of the Course Project for *Coursera Data Sciense Course #3: Getting and Cleaning Data* (https://www.coursera.org/course/getdata). See included CodeBook.md for more details regarding the source data as well the transformation completed by the script.

**Contact Information:**
Joseph Siu - josephsiu@gmail.com

**How To Use The Script**

1. Download and extract the source data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
2. Extract the source data to the location of your choice
3. Copy run_analysis.R to the same directory of the extracted data; note that this directory should have two sub-folders named "test" and "train" created by the source data extraction
4. Execute run_analysis.R in R console
5. The script will generate a file called "uci_har_avg_mean_std.txt"; see below for usage

**How To Use The Output**

1. The output txt file from the script above will be located in the same folder as the R script and source data
2. Read this space-delimited output file into R using the read.table() function; note that the output file contains a header row
3. Example: df <- read.table("uci_har_avg_mean_std.txt", header=TRUE)
