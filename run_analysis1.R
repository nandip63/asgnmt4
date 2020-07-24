
library(dplyr)
getwd()
# read train data
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
Sub_train <- read.table("./train/subject_train.txt")

# read test data
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
Sub_test <- read.table("./test/subject_test.txt")

# read features
features <- read.table("./features.txt")

# read activity labels
activity_labels <- read.table("./activity_labels.txt")

#  bind the training and the test sets to create one combined data set.
X_combo <- rbind(X_train, X_test)
Y_combo <- rbind(Y_train, Y_test)
Sub_combo <- rbind(Sub_train, Sub_test)

# grep mean and sd features
mean_std <- features[grep("mean\\(\\)|std\\(\\)",features[,2]),]
X_combo <- X_combo[,mean_std[,1]]

# activity names as labels
Y_combo1=Y_combo %>% full_join(activity_labels,by="V1")
labels=Y_combo1[,-1]

# column variable names
colnames(X_combo) <- features[mean_std[,1],2]
colnames(Sub_combo) <- "subject"

# aggregate mean values in tidy data set by activity and subject
combo <- cbind(X_combo, labels, Sub_combo)
a2=aggregate(combo,by=list(combo$labels,combo$subject),FUN=mean,simplify=TRUE)

write.table(a2,file="./tidydata5.txt",row.names = FALSE, col.names = TRUE)
