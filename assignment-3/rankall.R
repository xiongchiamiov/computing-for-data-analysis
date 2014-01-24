#!/usr/bin/env Rscript

source('rankhospital.R')

############
# Find all the hospitals with the given ranking for mortality rates from an
# issue.
#
# outcome: Why the patient came in.  One of: 'heart attack', 'heart failure',
#          'pneumonia'.
#     num: The rank of the hospital.  One of: an integer, 'best', 'worst'.
rankall = function(outcome, num='best') {
	# Rename to make more sense than what the spec requires.
	condition = outcome

	# Convert ranking number to actually a number.
	num = nlpRankingNumber(num)
	
	outcomes = read.csv("outcome-of-care-measures.csv", colClasses = "character")
	states = unique(outcomes[['State']])
	# Alphabetize.
	states = states[order(states)]
	
	rankedHospitals = vector()
	for (state in states) {
		# Filter by state.
		stateOutcomes = filterByState(outcomes, state)
		
		# Sort by condition.
		orderingColumn = conditionToColumnNumber(condition)
		stateOutcomes = sortByColumn(stateOutcomes, orderingColumn)
		
		rankedHospitals = c(rankedHospitals, stateOutcomes[num,][['Hospital.Name']])
	}
	
	return(data.frame(rankedHospitals, states, row.names=states))
}

