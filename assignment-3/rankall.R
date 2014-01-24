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
		
		# Convert ranking number to actually a number.
		index = nlpRankingNumber(num, stateOutcomes)
		
		rankedHospitals = c(rankedHospitals, stateOutcomes[index,][['Hospital.Name']])
	}
	
	# Rename variables, because that seems to be the only way to specify the
	# column names.
	hospital = rankedHospitals
	state = states
	
	return(data.frame(hospital, state, row.names=states))
}

