#!/usr/bin/env Rscript

data = read.csv("hw1_data.csv")
isMay = data[['Month']] == 5
max(data[isMay,][['Ozone']], na.rm=TRUE)

