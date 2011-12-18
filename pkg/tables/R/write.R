as.matrix.tabular <- function(x, format=TRUE, 
			rowLabels=TRUE, colLabels=TRUE,
			justification="n", ...) {
    if (isTRUE(format)) {
    	chars <- format(x, ...)
	rlabels <- attr(x, "rowLabels")
	rlabels[is.na(rlabels)] <- ""
	clabels <- attr(x, "colLabels")
	clabels[is.na(clabels)] <- ""
	colnamejust <- attr(rlabels, "colnamejust")
	colnamejust[is.na(colnamejust)] <- justification
	corner <- matrix("", nrow(clabels), ncol(rlabels))
	for (i in seq_len(ncol(rlabels)))
	    corner[nrow(clabels),i] <- justify(colnames(rlabels)[i],
					      colnamejust[i])
	if (rowLabels) {
	    if (colLabels)
		result <- rbind(cbind(corner, clabels),
			cbind(rlabels, chars))
	    else
	    	result <- cbind(rlabels, chars)
	} else {
	    if (colLabels)
	    	result <- rbind(clabels, chars)
	    else
	    	result <- chars
	}
	dimnames(result) <- NULL
    } else {
    	result <- x
    	dim <- dim(x)
    	if (is.character(format)) format <- get(format, parent.frame)
    	if (is.function(format))
    	    result <- format(result)
        dim(result) <- dim
    }
    result
}


write.csv.tabular <- function(x, file="", 
    justification = "n", row.names=FALSE, 
    write.options=list(), ...) {
    result <- as.matrix(x, justification = justification, ...)
    colnames(result) <- rep("", ncol(result))
    
    do.call(write.csv, c(list(result, file=file,
    	row.names=row.names), write.options))
}

write.table.tabular <- function(x, file="", 
    justification = "n", row.names=FALSE, col.names=FALSE,
    write.options=list(), ...) {
    result <- as.matrix(x, justification = justification, ...)
    colnames(result) <- rep("", ncol(result))
    rownames(result) <- rep("", nrow(result))
    do.call(write.table, c(list(result, file=file,
    	row.names=row.names, col.names=col.names), write.options))
}

print.tabular <- function(x, justification = "n", ...) {
    chars <- format(x, justification = justification, ...)
    
    result <- as.matrix(x, justification = justification, ...)

    rownames(result) <- rep("", nrow(result))
    colnames(result) <- rep("", ncol(result))
    print(noquote(result))
    invisible(x)
}

