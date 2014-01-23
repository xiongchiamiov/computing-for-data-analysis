#!/usr/bin/env Rscript

############
# Find the hospital in a state with the lowest mortality rate for an issue.
#
#   state: The two-character abbreviation for a state.
# outcome: Why the patient came in.  One of: 'heart attack', 'heart failure',
#          'pneumonia'.
best = function(state, outcome) {
	# Rename to make more sense than what the spec requires.
	condition = outcome
	
	outcomes = read.csv("outcome-of-care-measures.csv", colClasses = "character")
	
	# Filter by state.
	stateFilter = outcomes[['State']] == state
	outcomes = outcomes[stateFilter,]
	if (nrow(outcomes) == 0) {
		# It would be nice to include *what* the state is, but the spec says
		# otherwise...
		stop('invalid state')
	}
	
	# Sort by condition.  Magic numbers aplenty.
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
	# Coerce to numbers before we sort, else it'll be lexographic.
	outcomes[, orderingColumn] = as.numeric(outcomes[, orderingColumn])
	outcomes = outcomes[order(outcomes[, orderingColumn]),]
	
	bestOutcome = head(outcomes, n=1)
	return(bestOutcome[['Hospital.Name']])
}

