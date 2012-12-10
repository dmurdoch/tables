Factor <- function(x, name = deparse(expr), levelnames=levels(x),
		   texify = TRUE, expr = substitute(x)) {
    force(name)
    force(expr)
    x <- as.factor(x)
    if (texify) 
    	levels(x) <- texify(levels(x))    
    force(levelnames)
    RowFactor(x, name = name, levelnames = levelnames, spacing=FALSE, 
              texify = FALSE, expr = expr)
}

Multicolumn <- function(x, name = deparse(expr),
                        levelnames = levels(x),
                        width = 2, first = 1, justify = "l", 
                        texify = TRUE, expr = substitute(x)) {
    force(name)
    force(expr)
    x <- as.factor(x)
    levelnames <- sprintf("\\multicolumn{%d}{%s}{%s} \\\\ %s",
                  width, justify, levelnames, 
                  paste(rep("&", first-1), collapse=" "))
    RowFactor(x, name, levelnames, spacing=FALSE, texify = texify, 
              expr = expr)
}

RowFactor <- function(x, name = deparse(expr), levelnames=levels(x),
                      spacing=3, space=1, suppressfirst=TRUE,
                      nopagebreak = "\\nopagebreak ",
                      texify = TRUE, expr = substitute(x) ) {
    force(name)
    force(expr)
    x <- as.factor(x)
    if (texify)
    	levels(x) <- texify(levels(x))        
    levs <- levels(x)
    n <- length(levs)
    if (is.numeric(spacing) && spacing > 0) {
        groups <- TRUE
        if (spacing > 1)
            spacing <- (seq_len(n) %% spacing == 1)
        else
            spacing <- rep(TRUE, n)
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
    	    test <- i  # Work around a bug in R 2.12.x!
    	    test <- call("==", call("as.integer", call("as.factor", expr)), i)
            term <- call("*", call("Heading", as.name(catname)), 
                              test)
            if (i == 1)
            	f <- term
            else
            	f <- call("+", f, term)
        }
        return(call("*", call("Heading", name), f))
     } else
        stop("No levels in x!")
}
