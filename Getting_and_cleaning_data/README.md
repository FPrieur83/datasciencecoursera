# Read Me

This document describes how the run_analysis.R script 

## Script

The script executes the clean-up of the data in one go. It has to be launched from a working directory containing the below data. It also requires the dplyr package but this one is loaded as part of the execution of the script.
 
The output of the script will be the 2 required data set where:

* **dat**: The first required data set
* **dat2**: the final summarized data set
 
## Data

The script assumes it is running from a folder with

* **2 Files**:
    + activity_labels.txt
    + features.txt
* **2 Folders**:
    + test
    + train
    
containing respectively test and train data
