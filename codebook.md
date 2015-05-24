## Data Code Book for run_analysis.R in the github repo GettingandCleaningData

* Obtains the file from online, and unzips it
* Imports all the relevant files needed: X_test, subject_test, and y_test describe the test subject measurements and X_train, subject_train, and y_train describe the training subject measurements
* the y_* and subject_* files contain row identifiers of activity and subject ID respectively, so they were named as such. The feature file contains column identifiers for both X_* files and was used to name those columns.
* To start cleaning, the subject IDs and activity labels were joined to the X_* datasets as the first two columns of the datasets
* The X_datasets were then row binded together to make a complete dataset
* Since we only needed the columns that contained mean and standard deviation measurements from the X_* datasets, all other columns were dropped
* Activity labels were converted from numeric 1:6 to the more descriptive labels found in activity_labels.txt
* Columns from the X_* datasets were converted to be more readable and descriptive based on information found in the features_info.txt
* Finally, the average of each measurement for each subject and activity was produced and written to a table to be submitted.
