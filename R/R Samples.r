
# note: just highlight between the comments to run the code in R-Studio 
# Only the comments that are completely to the left
# The CSV files are in this folder on GIT
# set working directory, import data, create histogram based on income

setwd('C:/RTests')
getwd()
my.data <- read.csv("AWCustomers.csv", header=TRUE,sep=',')
     #my.data
x <- my.data$YearlyIncome
x
hist(my.data$YearlyIncome, col="dark green", xlab = "Annual Income",
     main = "Histogram of Annual Income")

#import data and join new data to imported data

my.data2 <- read.csv("AWSales.csv", header=TRUE,sep=',')
my.data2
my.data3 <- merge(my.data, my.data2,by="CustomerID")
my.data3

#use cbind and create histogram based on age

library(zoo)
library(plyr)
library(sqldf)
x <- my.data$BirthDate
yearBirthdate <- as.yearmon(x)
currentDate <- as.yearmon(Sys.time(), "UTC")
currentDate
Age <- currentDate - yearBirthdate
Age <- floor(Age)
my.data4 <- cbind(my.data3, Age)
my.data4
hist(Age, col="dark green")

#ggplot example

scatter.bikes = function(x){
  require(ggplot2)
  title = paste("income vs.", x, 'with color by occupation')
  ggplot(my.data4, aes_string(x, 'AvgMonthSpend')) +
    geom_point(aes(color = factor(Occupation))) +
    ggtitle(title)
}

        ## Define columns for making scatter plots
plot.cols3 = c("Occupation",
               "Gender",
               "HomeOwnerFlag",
               "MaritalStatus")
lapply(plot.cols3, scatter.bikes)
