path.to.dataset.dir <- "~/Downloads/UCI HAR Dataset"

read <- function(file,...) {
  read.table(file.path(path.to.dataset.dir,file),...)
}

features <- read("features.txt",col.names=c("Id","Feature"),colClasses=c("integer","character"))
activity.labels <- read("activity_labels.txt",col.names=c("Id","Activity"),colClasses=c("integer","character"))

training.set <- read("train/X_train.txt",col.names=features$Feature,colClasses=rep("numeric",nrow(features)))

training.set.activities <- read("train/y_train.txt",col.names="Activity",colClasses="integer")
training.set.activities$Activity <- as.factor(training.set.activities$Activity)
levels(training.set.activities$Activity) <- sapply(levels(training.set.activities$Activity),function(activity.id) activity.labels[activity.labels$Id == as.integer(activity.id),]$Activity)

training.set <- cbind(training.set,training.set.activities)

test.set <- read("test/X_test.txt",col.names=features$Feature,colClasses=rep("numeric",nrow(features)))

test.set.activities <- read("test/y_test.txt",col.names="Activity",colClasses="integer")
test.set.activities$Activity <- as.factor(test.set.activities$Activity)
levels(test.set.activities$Activity) <- sapply(levels(test.set.activities$Activity),function(activity.id) activity.labels[activity.labels$Id == as.integer(activity.id),]$Activity)

test.set <- cbind(test.set,test.set.activities)

total.set <- rbind(training.set,test.set)

measurements.on.means.and.stdevs <- total.set[,grepl("(mean|std)\\(\\)",features$Feature)]

measurements.on.means.and.stdevs <- cbind(measurements.on.means.and.stdevs,total.set$Activity)

library(plyr)

overall.means <- ddply(measurements.on.means.and.stdevs,"Activity",
                       function(df)
                       as.data.frame(lapply(df,
                                            function(l)
                                            if (class(l) == "numeric") { mean(l) } else { l[0] })))

write.table(overall.means,file="tidy.txt",row.name=FALSE)
