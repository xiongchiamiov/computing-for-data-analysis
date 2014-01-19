#!/usr/bin/env Rscript

source('getmonitor.R')
source('complete.R')

############
# Calculate the correlation between sulfate and nitrate for locations where the
# number of completely observed cases is greater than a threshold.
#
# directory: Directory containing the CSV files.
# threshold: The number of completely observed observations (on all variables)
#            required to compute the correlation between nitrate and sulfate.
corr <- function(directory, threshold=0) {
	numCompleteCases = complete(directory)
	completeCasesFilter = numCompleteCases[['nobs']] > threshold
	completeCaseIds = numCompleteCases[completeCasesFilter,][['id']]
	
	correlations = vector('numeric')
	for (id in completeCaseIds) {
		data = getmonitor(id, directory)
		correlation = cor(data[['sulfate']], data[['nitrate']], use='complete.obs')
		correlations = c(correlations, correlation)
	}
	
	return(correlations)
}

