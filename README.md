# Getting and Cleaning Data
#
# Project 1 - `run_analyis.R`
===========================================

This file explains how the scripts of this repo work.

The R script `run_analysis.R` process the required data. Then, it creates two new tidy data sets:

- `TidyData.txt` : combines training and test data sets (together with subject and activity data).

- `TidyAveData.txt` : the average of each variable for each activity and each subject.


====================
## Source

Information about used data in: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Used data set: [zip file](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


====================
## Dependencies

`run_analysis.R` depends on `reshape2` libraries (NOTE: The R script created will install and load them if necessary).