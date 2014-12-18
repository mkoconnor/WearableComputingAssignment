Wearable Computing Assignment
=============================

This repo contains my solution to the Wearable Computing Assignment in
the `run_analysis.R` file, a script which produces a tidy dataset
`tidy.txt`.

This README will walk through how the script works.

Setup
-----

The dataset given is not tidy, and in fact is spread across multiple
files.  Since we have to read in several files, I first define a
`read` function for convenience that knows where I downloaded the
dataset, and to pass `check.names=FALSE` (this is because otherwise
`R` will replace characters like `$` in the row names with `.`s).

    path.to.dataset.dir <- "."
    
    read <- function(file,...) {
      read.table(file.path(path.to.dataset.dir,file),check.names=FALSE,...)
    }

Features and Activities
-----------------------

I found it helpful to do the steps a bit out of order.  In particular,
I'll first read the features and activities datasets in.  The features
dataset is so that I can put appropriate column names on the dataset,
and the activities dataset is so that I can make an activities column
that doesn't contain integers but descriptive English.

    features <- read("features.txt",col.names=c("Id","Feature"),colClasses=c("integer","character"))
    activity.labels <- read("activity_labels.txt",col.names=c("Id","Activity"),colClasses=c("integer","character"))

Training and Test Datasets
--------------------------

To read the training dataset, I first `read` the `X_train.txt` file
with the column names that I got from the `features` dataset above:

    training.set <- read("train/X_train.txt",col.names=features$Feature,colClasses=rep("numeric",nrow(features)))

Next I prepare a dataset for adjoining to `training.set` which has
just 1 column containing the activities.

    training.set.activities <- read("train/y_train.txt",col.names="Activity",colClasses="integer")

This is currently an integer, but I would like to use
`activity.labels` to put labels on it.  I can do this by considering
`training.set.activities$Activity` a factor with levels from
`activity.labels`:

    training.set.activities$Activity <- as.factor(training.set.activities$Activity)
    levels(training.set.activities$Activity) <- sapply(levels(training.set.activities$Activity),function(activity.id) activity.labels[activity.labels$Id == as.integer(activity.id),]$Activity)

Now it can be adjoined to `training.set`:

    training.set <- cbind(training.set,training.set.activities)
    
That finishes the construction of `training.set`.

`test.set` is read in in exactly the same way:

    test.set <- read("test/X_test.txt",col.names=features$Feature,colClasses=rep("numeric",nrow(features)))

    test.set.activities <- read("test/y_test.txt",col.names="Activity",colClasses="integer")
    test.set.activities$Activity <- as.factor(test.set.activities$Activity)
    levels(test.set.activities$Activity) <- sapply(levels(test.set.activities$Activity),function(activity.id) activity.labels[activity.labels$Id == as.integer(activity.id),]$Activity)
    
    test.set <- cbind(test.set,test.set.activities)

Means and Stdevs
----------------

Now that we have the test and training sets, we want to join them
together and keep just the `mean` and `std` columns.

    total.set <- rbind(training.set,test.set)

    measurements.on.means.and.stdevs <- total.set[,grepl("(mean|std)\\(\\)",features$Feature)]

As a small point, note that `measurements.on.means.and.stdevs` still
contains the `Activity` column: this is because it is the last column
and the vector `grepl("(mean|std)\\(\\)",features$Feature)` has length
one less than the number of columns.  It actually took me a while to
figure this out (my code was working and I wasn't sure why!).

Means within Activities
-----------------------

Anyway, now that we've restricted down to the columns we want, we want
to take the mean within each activity.  The `plyr` package was made
for this split-apply-combine type of job, so let's use that.

    library(plyr)
    
    overall.means <- ddply(measurements.on.means.and.stdevs,"Activity",
                           function(df)
                           as.data.frame(lapply(df,
                                                function(l)
                                                if (class(l) == "numeric") { mean(l) } else { l[1] })))


This takes the mean of every variable (except for `Activity`) within
each value of the `Activity` column.  

One problem is that the names got mangled (with special characters
like `$` replaced by `.`s) somehow with the `lapply`.  I'm
not sure if there's a better way to do this, but it's easy enough to
just put the correct names back:

    names(overall.means) <- names(measurements.on.means.and.stdevs)

This is now, I believe, a correct "tidy" data set: no information is
duplicated, each column is a variable and each row is an observation.

Therefore, we just have to write out the data.

Writing out the Data
--------------------

Writing out the data is the easiest part!

    write.table(overall.means,file="tidy.txt",row.name=FALSE)




