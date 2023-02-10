Literal <- function(x, nearData = TRUE) {
    substitute(Heading(literal, nearData = ndval)*1*Format((function(x)"")()),
               list(literal=x, ndval = nearData))
}

Hline <- function(columns, nearData = FALSE) {
    opts <- table_options()
    if (missing(columns))
    	latex <- opts$midrule
    else {
        rule <- opts$titlerule
    	if (is.null(rule)) 
    	    latex <- paste(sprintf("\\cline{%d-%d}", columns, columns), 
    		       collapse=" ")
        else {
            latex <- character(0)
            firstcol <- columns[1]
            thiscol <- firstcol
            columns <- c(columns, max(columns) + 2) # add sentinel
            for (i in seq_along(columns)[-1]) {
            	if (columns[i] > thiscol + 1)  {
            	    latex <- c(latex, sprintf("%s{%d-%d}", rule, firstcol, thiscol))
            	    firstcol <- columns[i]
            	    thiscol <- firstcol
            	} else
            	    thiscol <- columns[i]
            }
            latex <- paste(latex, collapse=" ")
        }
    }    	    
    latex <- paste(latex, "%")
    Literal(latex, nearData = nearData)
}
