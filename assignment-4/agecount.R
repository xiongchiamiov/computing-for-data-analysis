#!/usr/bin/env Rscript

# Pull in some utility functions.
source('count.R')

############
# Find the number of homicides where the victims are a certain age.
#
# age: The age of the victims for which to get a count.
agecount = function(age=NULL) {
	if (is.null(age)) {
		stop('No age specified.')
	}
	
	rawHomicides = readLines('homicides.txt')
	# I would think I could just use sapply in the first place, but that returns
	# all sorts of extra junk, like the original text... no idea what I'm doing
	# wrong.  But this works, so oh well.
	homicides = lapply(rawHomicides, extractHomicideAges)
	homicides = sapply(homicides, function(x) x[1])
	# And now make it easier to do summaries on.
	homicides = data.frame(age=homicides)
	
	# I couldn't find any way to do a subscript with a default...
	summarizedAges = table(homicides)
	age = as.character(age)
	if (age %in% names(summarizedAges)) {
		return(summarizedAges[[age]])
	} else {
		return(0)
	}
}

extractHomicideAges = function(rawHomicide) {
	return(tolower(saneExtract(rawHomicide, ' (\\d+) years old')))
}

