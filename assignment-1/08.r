#!/usr/bin/env Rscript

data = read.csv("hw1_data.csv")
highOzoneFilter = data[['Ozone']] > 31
highTempFilter = data[['Temp']] > 90
filteredData = data[highOzoneFilter,][highTempFilter,]
nonMissingFilter = !is.na(filteredData[['Solar.R']])
# Interestingly, we get an integer (212) instead of the float (212.8) provided
# as a multiple-choice answer.  Probably doing something wrong.
mean(filteredData[['Solar.R']][nonMissingFilter])

