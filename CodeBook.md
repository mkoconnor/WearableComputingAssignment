Code Book
=========

This describes the variables in the `tidy.txt` file.

The data was acquired in the following way: 30 volunteers, while doing
various activities, had a number of pieces of data recorded by an
accelerometer and gyroscope.  

For each type of data recorded, an average was taken within each
activity type.

Activity
--------
This column describes the activity being done.  There are six values:

* WALKING
* WALKING\_UPSTAIRS
* WALKING\_DOWNSTAIRS
* SITTING
* STANDING
* LAYING

Measurements 
------------

## Basic Measurements

The basic measurements were:

* Acceleration due to body movement, `BodyAcc`
* Acceleration due to gravity, `GravityAcc`
* Gyroscopic body motion, `BodyGyro`
* Jerk (derivative of acceleration) due to body movement,
  `BodyAccJerk`
* Derivative of gyroscopic body motion, `BodyGyroJerk`

## Coordinates

Each of the basic measurements described are 3-dimensional vector
quantities.  For each, there are 3 variables corresponding to the XYZ
and one, `Mag` corresponding to the Euclidean magnitude

## Domain

For each of the variables described so far, there is a variable
(starting with a `t` for time) corresponding to the variable as described, and
one (starting with an `f` for frequency) corresponding to the Fourier
transform.

## Mean vs Std

For every variable described so far, there is a version for the `mean`
value and one for the standard deviation (given by `std`.)

Complete list of Variables
--------------------------

Taking everything above into account, here is the complete list of variables:

* tBodyAcc-mean()-X
* tBodyAcc-mean()-Y
* tBodyAcc-mean()-Z
* tBodyAcc-std()-X
* tBodyAcc-std()-Y
* tBodyAcc-std()-Z
* tGravityAcc-mean()-X
* tGravityAcc-mean()-Y
* tGravityAcc-mean()-Z
* tGravityAcc-std()-X
* tGravityAcc-std()-Y
* tGravityAcc-std()-Z
* tBodyAccJerk-mean()-X
* tBodyAccJerk-mean()-Y
* tBodyAccJerk-mean()-Z
* tBodyAccJerk-std()-X
* tBodyAccJerk-std()-Y
* tBodyAccJerk-std()-Z
* tBodyGyro-mean()-X
* tBodyGyro-mean()-Y
* tBodyGyro-mean()-Z
* tBodyGyro-std()-X
* tBodyGyro-std()-Y
* tBodyGyro-std()-Z
* tBodyGyroJerk-mean()-X
* tBodyGyroJerk-mean()-Y
* tBodyGyroJerk-mean()-Z
* tBodyGyroJerk-std()-X
* tBodyGyroJerk-std()-Y
* tBodyGyroJerk-std()-Z
* tBodyAccMag-mean()
* tBodyAccMag-std()
* tGravityAccMag-mean()
* tGravityAccMag-std()
* tBodyAccJerkMag-mean()
* tBodyAccJerkMag-std()
* tBodyGyroMag-mean()
* tBodyGyroMag-std()
* tBodyGyroJerkMag-mean()
* tBodyGyroJerkMag-std()
* fBodyAcc-mean()-X
* fBodyAcc-mean()-Y
* fBodyAcc-mean()-Z
* fBodyAcc-std()-X
* fBodyAcc-std()-Y
* fBodyAcc-std()-Z
* fBodyAccJerk-mean()-X
* fBodyAccJerk-mean()-Y
* fBodyAccJerk-mean()-Z
* fBodyAccJerk-std()-X
* fBodyAccJerk-std()-Y
* fBodyAccJerk-std()-Z
* fBodyGyro-mean()-X
* fBodyGyro-mean()-Y
* fBodyGyro-mean()-Z
* fBodyGyro-std()-X
* fBodyGyro-std()-Y
* fBodyGyro-std()-Z
* fBodyAccMag-mean()
* fBodyAccMag-std()
* fBodyBodyAccJerkMag-mean()
* fBodyBodyAccJerkMag-std()
* fBodyBodyGyroMag-mean()
* fBodyBodyGyroMag-std()
* fBodyBodyGyroJerkMag-mean()
* fBodyBodyGyroJerkMag-std()
* Activity

A Note about `BodyBody` Variables
---------------------------------

You may have noticed that there are also variables with `BodyBody` in
the above list.  Unfortunately, I don't know what those are, as they
were not described in the original code book.
