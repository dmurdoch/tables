Hline <- function(columns) {
    if (missing(columns))
    	latex <- "\\hline"
    else
    	latex <- paste(sprintf("\\cline{%d-%d}", columns, columns), 
    		       collapse=" ")
    latex <- paste(latex, "%")
    substitute(Heading(latex)*1*Format((function(x)"")()),
    	       list(latex=latex))
}
