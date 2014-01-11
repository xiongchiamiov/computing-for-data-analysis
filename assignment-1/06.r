#!/usr/bin/env Rscript

data = read.csv("hw1_data.csv")
ozone = data[['Ozone']]
missingFilter = is.na(ozone)
length(ozone[missingFilter])

