#!/usr/bin/env Rscript

############
# Find the hospital in a state with the given mortality rate for an issue.
#
#   state: The two-character abbreviation for a state.
# outcome: Why the patient came in.  One of: 'heart attack', 'heart failure',
#          'pneumonia'.
#     num: The rank of the hospital.  One of: an integer, 'best', 'worst'.
rankhospital = function(state, outcome, num='best') {
	# Rename to make more sense than what the spec requires.
	condition = outcome
	
	outcomes = read.csv("outcome-of-care-measures.csv", colClasses = "character")
	
	# Filter by state.
	outcomes = filterByState(outcomes, state)
	
	# Sort by condition.
	orderingColumn = conditionToColumnNumber(condition)
	outcomes = sortByColumn(outcomes, orderingColumn)
	
	num = nlpRankingNumber(num, outcomes)
	
	return(outcomes[num,][['Hospital.Name']])
}

filterByState = function(outcomes, state) {
	stateFilter = outcomes[['State']] == state
	outcomes = outcomes[stateFilter,]
	if (nrow(outcomes) == 0) {
		# It would be nice to include *what* the state is, but the spec says
		# otherwise...
		stop('invalid state')
	}
	
	return(outcomes)
}

conditionToColumnNumber = function(condition) {
	# Magic numbers aplenty.
	# R's switch statement is actually a function, and therefore totally
	# inappropriate for this.
	if (condition == 'heart attack') {
		orderingColumn = 11
	} else if (condition == 'heart failure') {
		orderingColumn = 17
	} else if (condition == 'pneumonia') {
		orderingColumn = 23
	} else {
		stop('invalid outcome')
	}
	
	return(orderingColumn)
}

sortByColumn = function(outcomes, orderingColumn) {
	# Coerce to numbers before we sort, else it'll be lexographic.
	outcomes[, orderingColumn] = as.numeric(outcomes[, orderingColumn])
	outcomes = outcomes[order(outcomes[, orderingColumn], outcomes[['Hospital.Name']]),]
	
	# Filter out NAs, 'cause they're not good *or* bad.  Just unknown.
	naFilter = !is.na(outcomes[,orderingColumn])
	outcomes = outcomes[naFilter,]
	
	return(outcomes)
}

nlpRankingNumber = function(num, outcomes) {
	if (num == 'best') {
		num = 1
	} else if (num == 'worst') {
		# Negative-indexing *removes* rows, rather than wrapping around, so we
		# can't use -1 like in Python.
		# We don't need to subtract one because R data frames are one-based.
		num = nrow(outcomes)
	}
	
	return(num)
}

