#!/usr/bin/env Rscript

data = read.csv("hw1_data.csv")
isJune = data[['Month']] == 6
mean(data[isJune,][['Temp']])

