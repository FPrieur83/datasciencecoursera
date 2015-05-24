# The script assumes it is running from a folder with:
# 2 Files:
#   - activity_labels.txt
#   - features.txt
# 2 Folders:
#   - test
#   - train
# containing respectively test and train data

# Load dplyr lib as we will need it later on
library("dplyr")

# We load the activity labels and feature labels which will be re-used later on
# to create descriptive variable names
act_lbl <- read.csv("activity_labels.txt", sep="", header=FALSE)
features <- read.csv("features.txt", sep="", header=FALSE)

# we load all the data from training and Test and name columns
# TEST
subject_test <- read.csv("./test/subject_test.txt", header=FALSE)
X_test <- read.csv("./test/X_test.txt", sep="", header=FALSE)
y_test <- read.csv("./test/y_test.txt", sep="", header=FALSE)

# TRAIN
subject_train <- read.csv("./train/subject_train.txt", header=FALSE)
X_train <- read.csv("./train/X_train.txt", sep="", header=FALSE)
y_train <- read.csv("./train/y_train.txt", sep="", header=FALSE)

# Merge the data
subject <- rbind(subject_test, subject_train)
X <- rbind(X_test, X_train)
Y <- rbind(y_test, y_train)

# Replace integer in Y by descriptive activity names
Y <- lapply(Y, function(Y) act_lbl[Y,2])

# Label columns
names(subject) <- "Subject"
names(X) <- features[,2]
names(Y) <- "activity_lbl"

# extract from X only the columns with the mean or std dev information
# use grep to match column names from pattern
col_to_extract <- sort(c(grep('*-std()*',names(X)) , grep('*-mean()*',names(X))))

# Extract appropriate columns from X
X <- X[, col_to_extract]

# Concatenate all tables above to make one clean data set
dat <- cbind(subject, Y, X)

# cleanup memory of intermediate objects
rm(subject_test, X_test, y_test, subject_train, X_train, y_train, subject, X, Y, col_to_extract)

# Now we create the second data frame summerazing the data
for(subj in unique(dat[,1]))
{
    
    # Extract data for each subject
    tmp <- filter(dat, dat$Subject == subj)
    
    # Iterate over each activity to compute the mean of each variable
    for(act in unique(tmp[,2]))
    {
        tmp.a <- filter(tmp, tmp$activity_lbl == act)
        tmp.dat <- matrix(colMeans(tmp.a[,3:81]), nrow=1, ncol=79)
        tmp.dat <- cbind(act, tmp.dat)
        tmp.dat <- cbind(subj, tmp.dat)
        if(exists("dat2"))
        {
            dat2 <- rbind(dat2, tmp.dat)
        } else 
        {
            dat2 <- tmp.dat
        }
    }
}

# put back correct column names to the output dat2 data frame
colnames(dat2) <- colnames(dat)

# clean up unnecessary variables from the environment
rm(act_lbl, features, tmp, tmp.a, tmp.dat, subj, act)







