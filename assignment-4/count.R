#!/usr/bin/env Rscript

############
# Find the number of a particular type of homicide.
#
# cause: The cause of death to count.  Choices: 'asphyxiation', 'blunt force',
#        'other', 'shooting', 'stabbing', 'unknown'.
count = function(cause=NULL) {
	if (is.null(cause) ||
	   (!(cause %in% c('asphyxiation', 'blunt force', 'other', 'shooting',
	                     'stabbing', 'unknown')))) {
		stop('Not an approved cause.')
	}
	
	rawHomicides = readLines('homicides.txt')
	# I would think I could just use sapply in the first place, but that returns
	# all sorts of extra junk, like the original text... no idea what I'm doing
	# wrong.  But this works, so oh well.
	homicides = lapply(rawHomicides, extractHomicideCauses)
	homicides = sapply(homicides, function(x) x[1])
	# And now make it easier to do summaries on.
	homicides = data.frame(cause=homicides)
	
	return(table(homicides)[[cause]])
}

extractHomicideCauses = function(rawHomicide) {
	return(tolower(saneExtract(rawHomicide, 'Cause: (\\w+)')))
}

############
# Extract a regex match from a string with a reasonable API.
#
# searchString: The string to search.
#        regex: The regex to match on.  Assumed to have one capture.
saneExtract = function(searchString, regex) {
	# Seriously, R, what the fuck?  Why do I have to specify the string I've
	# regexed against *again* when I want to pull the matches out of it, and
	# what's with this crazy indexing?  Whoever thought this was a good idea
	# evidentally doesn't do much text munging.
	return(regmatches(searchString, regexec(regex, searchString))[[1]][2])
}

