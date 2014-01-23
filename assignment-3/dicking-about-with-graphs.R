#!/usr/bin/env Rscript

# This is from the first half of the assignment, where we're supposed to plot a
# bunch of stuff.  But we don't have to turn anything in, and I'm not terribly
# interested in the minutiae of customizing graph appearance, so I didn't
# finish it.

outcomes = read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcomes[, 11] = as.numeric(outcomes[, 11])
hist(
	outcomes[, 11],
	main='Heart Attack 30-day Death Rate',
	xlab='30-day Death Rate')

