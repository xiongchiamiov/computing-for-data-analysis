#!/usr/bin/env Rscript

source('rankhospital.R')

############
# Find the hospital in a state with the lowest mortality rate for an issue.
#
#   state: The two-character abbreviation for a state.
# outcome: Why the patient came in.  One of: 'heart attack', 'heart failure',
#          'pneumonia'.
best = function(state, outcome) {
	return(rankhospital(state, outcome, 1))
}

