Literal <- function(x) {
    substitute(Heading(literal)*1*Format((function(x)"")()),
               list(literal=x))
}

Hline <- function(columns) {
    if (missing(columns))
    	latex <- "\\hline"
    else
    	latex <- paste(sprintf("\\cline{%d-%d}", columns, columns), 
    		       collapse=" ")
    latex <- paste(latex, "%")
    Literal(latex)
}
