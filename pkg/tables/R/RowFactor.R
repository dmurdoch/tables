Factor <- function(x, name = deparse(substitute(x)), levelnames=levels(x),
		   texify = TRUE) {
    force(name)
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
                      spacing=3, space=1, suppressfirst=TRUE,
                      nopagebreak = "\\nopagebreak ",
                      texify = TRUE) {
    force(name)
    x <- as.factor(x)
    if (texify)
    	levels(x) <- texify(levels(x))        
    levs <- levels(x)
    n <- length(levs)
    if (is.numeric(spacing) && spacing > 0) {
        groups <- TRUE
        spacing <- (seq_len(n) %% spacing == 1)
        if (suppressfirst)
            spacing[1] <- FALSE
    } else {
    	groups <- FALSE
    	spacing <- rep(FALSE, n)
    }
    if (n) {
        for (i in seq_along(levs)) {
            if (groups && spacing[i]) insert <- sprintf("\\rule{0pt}{%.1f\\normalbaselineskip}", space+0.7)
            else if (!groups) insert <- ""
            else insert <- nopagebreak
            catname <- paste(insert, levelnames[i], sep="")
            term <- call("*", call("Heading", as.name(catname)), 
                                                call("==", x, levs[i]))
            if (i == 1)
            	f <- term
            else
            	f <- call("+", f, term)
        }
        return(call("*", call("Heading", name), f))
     } else
        stop("No levels in x!")
}
