# Create a function that applies a common format to its argument,
# then removes leading blanks by column.

multicolumnFormat <- function(digits = 2, ...) {
  function(x){
    s <- format(x, digits=digits, ...)
    if (!is.null(col <- attr(x, "col"))) {
      for (j in unique(col)) {
        blanks <- nchar(sub("[^ ].*$", "", s[col == j]))
        if (all(blanks > 0))
          s[col == j] <- substring(s[col == j], min(blanks) + 1)
      }
    }
    latexNumeric(s)
  }
}

PlusMinus <- function(x, y, head, xhead, yhead, digits=2, character.only = FALSE,  ...) {
  head <- getHeading(head, substitute(head), character.only)
  xhead <- getHeading(xhead, substitute(xhead), character.only)
  yhead <- getHeading(yhead, substitute(yhead), character.only)
  
  fmt <- multicolumnFormat(digits, ...)
  
  substitute( head*1*Format(fmt())*(xhead*Justify("r@{}")*x 
                                      + yhead*Justify("@{ $\\pm$ }l")*y),
                list(x=substitute(x), y=substitute(y), 
                     head=head, xhead=xhead, yhead=yhead, fmt=fmt))
}
