Factor <- function(x, name = deparse(substitute(x)), levelnames=levels(x),
		   texify = TRUE) {
    x <- as.factor(x)
    if (texify) 
    	levels(x) <- texify(levels(x))    
    force(levelnames)
    RowFactor(x, name = name, levelnames = levelnames, spacing=FALSE, 
              texify = FALSE)
}

Multicolumn <- function(x, name = deparse(substitute(x)),
                        levelnames = levels(x),
                        width = 2, first = 1, justify = "l", 
                        texify = TRUE) {
    x <- as.factor(x)
    levelnames <- sprintf("\\multicolumn{%d}{%s}{%s} \\\\ %s",
                  width, justify, levelnames, 
                  paste(rep("&", first-1), collapse=" "))
    RowFactor(x, name, levelnames, spacing=FALSE, texify = texify)
}

RowFactor <- function(x, name = deparse(substitute(x)), levelnames=levels(x),
                      spacing=3, space=1, nopagebreak = "\\nopagebreak ",
                      texify = TRUE) {
    force(name)
    x <- as.factor(x)
    if (texify)
    	levels(x) <- texify(levels(x))        
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
        f <- call("*", call("Heading", as.name(levelnames[1])), 
                       call("==", x, levs[1]))
        for (i in seq_along(levs)[-1]) {
            if (groups && spacing[i]) insert <- paste(nopagebreak, "\\rule[-", space+1, "ex]{0pt}{0pt}", sep="")
            else if (!groups || spacing[i-1]) insert <- ""
            else insert <- nopagebreak
            catname <- paste(insert, levelnames[i], sep="")
            f <- call("+", f, call("*", call("Heading", as.name(catname)), 
                                                call("==", x, levs[i])))
        }
        return(call("*", call("Heading", name), f))
     } else
        stop("No levels in x!")
}
