Factor <- function(x, name = deparse(substitute(x)))
    RowFactor(x, name = name, spacing=FALSE)

RowFactor <- function(x, name = deparse(substitute(x)), spacing=3, space=1,
                      nopagebreak = "\\nopagebreak ") {
    force(name)
    x <- as.factor(x)
    levs <- levels(x)
    n <- length(levs)
    if (is.numeric(spacing) && spacing > 0) {
        groups <- TRUE
        spacing <- seq_len(n) %% spacing == 0
        spacing[n] <- FALSE
    } else {
    	groups <- FALSE
    	spacing <- rep(FALSE, n)
    }
    if (n) {
        f <- call("*", call("Heading", as.name(levs[1])), 
                       call("==", x, levs[1]))
        for (i in seq_along(levs)[-1]) {
            if (groups && spacing[i]) insert <- paste(nopagebreak, "\\rule[-", space+1, "ex]{0pt}{0pt}", sep="")
            else if (!groups || spacing[i-1]) insert <- ""
            else insert <- nopagebreak
            catname <- paste(insert, levs[i], sep="")
            f <- call("+", f, call("*", call("Heading", as.name(catname)), 
                                                call("==", x, levs[i])))
        }
        return(call("*", call("Heading", name), f))
     } else
        stop("No levels in x!")
}
