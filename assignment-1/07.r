#!/usr/bin/env Rscript

data = read.csv("hw1_data.csv")
ozone = data[['Ozone']]
nonMissingFilter = !is.na(ozone)
mean(ozone[nonMissingFilter])

