#!/usr/bin/env Rscript

############
# Return the monitoring data for a particular monitoring location.
#
#        id: The id of the monitor data we wish to fetch.  A 1-length vector of
#            a character, integer, or numeric.
# directory: Directory containing the CSV files.
# summarize: Should we print the data to the screen?  Boolean.
getmonitor <- function(id, directory, summarize=FALSE) {
	# All the files are formatted with 3-digit names, so we've got to conform to
	# that.  Unfortunately, sprintf() doesn't like formatting strings as
	# integers, so we have to coerce our input into an integer first.
	filename = paste(sprintf('%03d', as.integer(id)), '.csv', sep='')
	path = paste(directory, filename, sep='/')
	monitorData = read.csv(path)

	if (summarize) {
		print(summary(monitorData))
	}

	return(monitorData)
}

