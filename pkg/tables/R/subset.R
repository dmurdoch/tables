`[.tabular` <- function(x, i, j, ..., drop=FALSE) {
	
	if (drop) return(unlist(unclass(x)[i,j, drop=TRUE]))
	
	attrs <- attributes(x)
	x <- unclass(x)[i,j, drop=FALSE]
	attrs$justification <- attrs$justification[i,j, drop=FALSE]
	attrs$formats <- attrs$formats[i,j, drop=FALSE]
	attrs$dim <- dim(x)
	attrs$dimnames <- dimnames(x)
	
	rowLabels <- attrs$rowLabels
	rattrs <- attributes(rowLabels)
	rattrs$justification <- rattrs$justification[i,, drop=FALSE]
	rattrs$dim <- dim(rattrs$justification)
    	
	# This is the tricky bit
	rows <- seq_len(nrow(rowLabels))
	keep <- rows %in% rows[i]
	prev <- rep(NA, ncol(rowLabels))
	for (k in rows) {
		rowLabels[k,] <- ifelse(is.na(rowLabels[k,]), prev, rowLabels[k,])
		if (keep[k]) 
		    prev <- rep(NA, ncol(rowLabels))
		else
		    prev <- ifelse(is.na(rowLabels[k,]), prev, rowLabels[k,])
	}
	rowLabels <- rowLabels[i,, drop=FALSE]
	rattrs$dimnames <- dimnames(rowLabels)
	
	# Do the same for column labels
	colLabels <- attrs$colLabels
	cattrs <- attributes(colLabels)
	cattrs$justification <- cattrs$justification[,j, drop=FALSE]
	cattrs$dim <- dim(cattrs$justification)
	
	cols <- seq_len(ncol(colLabels))
	keep <- cols %in% cols[j]
	prev <- rep(NA, nrow(colLabels))
	for (k in cols) {
		colLabels[,k] <- ifelse(is.na(colLabels[,k]), prev, colLabels[,k])
		if (keep[k])
		    prev <- rep(NA, nrow(colLabels))
		else
		    prev <- ifelse(is.na(colLabels[,k]), prev, colLabels[,k])
	}
	colLabels <- colLabels[,j, drop=FALSE]
	cattrs$dimnames <- dimnames(colLabels)
	
	# Put it all back together
	attributes(rowLabels) <- rattrs
	attrs$rowLabels <- rowLabels
	attributes(colLabels) <- cattrs
	attrs$colLabels <- colLabels
	attributes(x) <- attrs
	x
}