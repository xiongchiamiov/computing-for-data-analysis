#!/usr/bin/env Rscript

source('getmonitor.R')

############
# directory: Directory containing the CSV files.
#        id: The ids of the monitor data we wish to fetch.  A n-length vector
#            of characters, integers, or numerics.
complete <- function(directory, id=1:332) {
	# It's stupid to have a singular name for a plural variable.
	ids = id

	numCompleteCasesVector = c()
	for (id in ids) {
		data = getmonitor(id, directory)
		noSulfateFilter = is.na(data[['sulfate']])
		noNitrateFilter = is.na(data[['nitrate']])
		numCompleteCases = nrow(data[!noSulfateFilter,][!noNitrateFilter,])
		numCompleteCasesVector = c(numCompleteCasesVector, numCompleteCases)
	}
	
	return(data.frame(id=ids, nobs=numCompleteCasesVector))
}

