# this script reads and manipulates the course project dataset for coursera's data cleaning class
# see readme.md for more detailed information about the project and data source
# contact: joseph siu / email: josephsiu@gmail.com

# note: this script will only function properly when placed into the same directory
# as the data source folder; test and train folders should be sub-folders here

# read "test" tables
x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
s_test <- read.table("test/subject_test.txt")

# read "train" tables
x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
s_train <- read.table("train/subject_train.txt")

# concatenate "test" and "train" tables columns separately, then union them together by row
test_full <- cbind(x_test,y_test,s_test)
train_full <- cbind(x_train,y_train,s_train)
data_full <- rbind(test_full,train_full) #complete project step 1

# read "features" table
feat <- read.table("features.txt")

# clean up the second column of the feature table and store them separately
col_names <- gsub("\\(\\)","",feat[,2])
col_names <- gsub("meanFreq","MeanFreq",col_names)

# find the columns for mean and std and store it as an index, then use it to retrieve columns
# we want; we also want to include the activity id and subject id columns (and name them)
ms_index <- grep("mean|std",col_names)
data_ms <- data_full[,c(ms_index,562:563)] #complete project step 2
colnames(data_ms)[67:68] <- c("ActivityID","SubjectID")

# read "activity labels" table and renames the columns
act_lbl <- read.table("activity_labels.txt")
colnames(act_lbl) <- c("ActivityID","ActivityName")

#join our data_ms with act_lbl to get the activity names, then rearrange the columns properly
data_ms <- merge(data_ms,act_lbl,by="ActivityID",all.x=TRUE) #complete project step 3
data_ms <- data_ms[c(68,1,69,2:67)]

# rename our mean/std dataset column names to match that of the original data source
colnames(data_ms)[4:69] <- col_names[ms_index] #complete project step 4

# create tidy dataset of average values for each column, group by subject and activity
data_tidy <- aggregate(.~SubjectID+ActivityID+ActivityName,FUN=mean,data=data_ms)

# order the data by subject id and then by activity id and activity name, 
# finally output to file as space-delimited txt, with headers included
data_tidy <- data_tidy[order(data_tidy$SubjectID,data_tidy$ActivityID,data_tidy$ActivityName),]
write.table(data_tidy,"uci_har_avg_mean_std.txt",row.names=FALSE) #complete project step 5