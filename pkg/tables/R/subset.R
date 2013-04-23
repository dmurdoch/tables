`[.tabular` <- function(x, i, j, ..., drop=FALSE) {
	
    if (drop) return(unclass(x)[i,j, drop=TRUE])

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
    orig <- row(rowLabels)
    for (k in seq_len(nrow(orig))[-1]) 
	orig[k,] <- ifelse(is.na(rowLabels[k,]), orig[k-1,], orig[k,])
    orig <- orig[i,, drop=FALSE]
    rowLabels <- rowLabels[cbind(c(orig), c(col(orig)))]
    dim(rowLabels) <- dim(orig)
    for (k in seq_len(nrow(orig))[-1])
	rowLabels[k,] <- ifelse(orig[k,] == orig[k-1,], NA, rowLabels[k,])
    rattrs$dimnames[1] <- list(NULL)

    # Do the same for column labels
    colLabels <- attrs$colLabels
    cattrs <- attributes(colLabels)
    cattrs$justification <- cattrs$justification[,j, drop=FALSE]
    cattrs$dim <- dim(cattrs$justification)
    orig <- col(colLabels)
    for (k in seq_len(ncol(orig))[-1]) 
	orig[,k] <- ifelse(is.na(colLabels[,k]), orig[,k-1], orig[,k])
    orig <- orig[,j, drop=FALSE]
    colLabels <- colLabels[cbind(c(row(orig)), c(orig))]
    dim(colLabels) <- dim(orig)
    for (k in seq_len(ncol(orig))[-1])
	colLabels[,k] <- ifelse(orig[,k] == orig[,k-1], NA, colLabels[,k])
    cattrs$dimnames[2] <- list(NULL)

    # Put it all back together
    attributes(rowLabels) <- rattrs
    attrs$rowLabels <- rowLabels
    attributes(colLabels) <- cattrs
    attrs$colLabels <- colLabels
    attributes(x) <- attrs
    x
}