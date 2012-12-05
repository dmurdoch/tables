factors <- function(e) {
    if (is.name(e)) list(e)
    else switch(as.character(e[[1]]),
    	"*" = c(factors(e[[2]]),factors(e[[3]])),
    	"(" = factors(e[[2]]),
    	list(e))
}

term2table <- function(rowterm, colterm, env, n) {
    rowargs <- factors(rowterm)
    colargs <- factors(colterm)
    allargs <- c(rowargs, colargs)
    rowsubset <- TRUE
    colsubset <- TRUE
    values <- NULL
    summary <- NULL
    format <- NA
    justification <- NA
    for (i in seq_along(allargs)) {
        e <- allargs[[i]]
        fn <- ""
        if (is.call(e) && (fn <- as.character(e[[1]])) == ".Format")
            format <- e[[2]]
        else if (fn == "Justify") 
            justification <- as.character(e[[if (length(e) > 2) 3 else 2]])
        else if (fn == "Percent") {
            env1 <- new.env(parent=env)
            percent <- function(x, y) 100*length(x)/length(y)
            env1$Percent <- function(denom="all", fn=percent) {
              if (is.null(summary)) {
                if (identical(denom, "all")) summary <<- function(x) fn(x, values)
                else if (identical(denom, "row")) summary <<- function(x) fn(x, values[rowsubset])
                else if (identical(denom, "col")) summary <<- function(x) fn(x, values[colsubset])
                else if (is.logical(denom)) summary <<- function(x) fn(x, values[denom])
                else summary <<- function(x) fn(x, denom)
                summaryname <<- "Percent"
              } else
    	        stop("Summary fn not allowed with Percent")
            }
            eval(e, env1)
        } else if (fn != "Heading" && !identical(e, 1)) {
    	    arg <- eval(e, env)
    	    asis <- inherits(arg, "AsIs")
    	    if (asis || is.vector(arg)) {
    	    	if (missing(n)) n <- length(arg)
    	    	else if (n != length(arg))
    	    	    stop("Argument ", deparse(e), " is not length ", n)
    	    }
    	    
    	    if (!asis && is.logical(arg)) {
    	    	arg <- arg & !is.na(arg)
    	    	if (i <= length(rowargs))
    	    	    rowsubset <- rowsubset & arg
    	    	else
    	    	    colsubset <- colsubset & arg
    	    } else if (asis || is.atomic(arg)) {
    	    	if (is.null(values)) {
    	    	    values <- arg
    	    	    valuename <- e
    	    	} else 
    	    	    stop("Duplicate values: ", deparse(valuename),
    	    	         " and ", deparse(e))
    	    } else if (is.function(arg)) {
    	    	if (is.null(summary)) {
    	    	    summary <- arg
    	    	    summaryname <- e
    	    	} else
    	    	    stop("Duplicate summary fn: ", deparse(summaryname),
    	    	         " and ", deparse(e))
    	    } else 
    	    	stop("Unrecognized entry ", deparse(e))
    	}
    }
    if (missing(n))
    	stop("Length of ", deparse(rowterm), "~", deparse(colterm),
    	     "indeterminate")    
    if (is.null(summary)) summary <- length
    if (is.null(values)) values <- rep(NA, n)
    subset <- rowsubset & colsubset 
    structure(list(summary(values[subset])), n=n, format=format, 
                   justification=justification)
}

getLabels <- function(e, rows=TRUE, justify=NA, head=NULL, suppress=0) {
    op <- ""
    justification <- NULL
    colnamejust <- character(0)
    Heading <- head
    result <- if (rows) matrix(NA, ncol=0, nrow=1)
    	      else      matrix(NA, ncol=1, nrow=0)
    if (is.call(e) && (op <- as.character(e[[1]])) %in% c("*", "+") ) {
        leftLabels <- getLabels(e[[2]], rows, justify, head, suppress)
	nrl <- nrow(leftLabels)
	ncl <- ncol(leftLabels)
	# Heading and justify are the settings to carry on to later terms
	# justification is the matrix of justifications for
	# each label
	leftjustify <- attr(leftLabels, "justify")
	Heading <- attr(leftLabels, "Heading")
	leftsuppress <- attr(leftLabels, "suppress")
	if (op == "*") {
	    righthead <- Heading
	    suppress <- leftsuppress
	    if (!is.null(leftjustify))
	    	justify <- leftjustify
	} else righthead <- head   
	leftjustification <- attr(leftLabels, "justification")
	leftcolnamejust <- attr(leftLabels, "colnamejust")

	rightLabels <- getLabels(e[[3]], rows, justify, righthead, suppress)
	nrr <- nrow(rightLabels)
	ncr <- ncol(rightLabels)
	rightjustify <- attr(rightLabels, "justify")
	Heading <- attr(rightLabels, "Heading")
	suppress <- attr(rightLabels, "suppress")
	if (op == "*") {
	    if (!is.null(rightjustify))
		justify <- rightjustify
	}
	rightjustification <- attr(rightLabels, "justification")
	rightcolnamejust <- attr(rightLabels, "colnamejust")
    	switch(op,
        "*" = {
            if (rows) {
		result <- justification <- matrix(NA_character_, nrl*nrr, ncl + ncr)
		colnames(result) <- c(colnames(leftLabels), colnames(rightLabels))
		colnamejust <- c(leftcolnamejust, rightcolnamejust)
		if (!is.null(head)) {
		    if (ncr > 0) {
		        colnames(result)[ncl + 1] <- head
		        colnamejust[ncl + 1] <- leftjustify
		    } else if (is.null(Heading))
		    	Heading <- head
		}
		for (i in seq_len(nrl)) {
		    j <- 1 + (i-1)*nrr
		    k <- seq_len(ncl)
		    result[j, k] <- leftLabels[i,]
		    if (!is.null(leftjustification))
		    	justification[j, k] <- leftjustification[i,]
		    j <- (i-1)*nrr + seq_len(nrr)
		    k <- ncl+seq_len(ncr)
		    result[j, k] <- rightLabels
		    if (!is.null(rightjustification))
		    	justification[j, k] <- rightjustification
		}
	    } else {
		result <- justification <- matrix(NA_character_, nrl + nrr, ncl*ncr)
		for (i in seq_len(ncl)) {
		    j <- seq_len(nrl)
		    k <- 1 + (i-1)*ncr
		    result[j, k] <- leftLabels[,i]
		    if (!is.null(leftjustification))
		    	justification[j,k] <- leftjustification[,i]
		    j <- nrl+seq_len(nrr)
		    k <- (i-1)*ncr + seq_len(ncr)
		    result[j, k] <- rightLabels
		    if (!is.null(rightjustification))
		    	justification[j,k] <- rightjustification
		}
	    }
        },
        "+" = {
            if (rows) {
		cols <- max(ncl, ncr)
		result <- matrix("", nrl + nrr, cols)
		justification <- matrix(NA_character_, nrl + nrr, cols)
		colnames(result) <- colnames(leftLabels)
		colnamejust <- leftcolnamejust
		j <- seq_len(nrl)
		k <- (cols-ncl) + seq_len(ncl)
		result[j, k] <- leftLabels
		if (!is.null(leftjustification))
		    justification[j, k] <- leftjustification
		j <- nrl+seq_len(nrr)
		k <- (cols-ncr) + seq_len(ncr)
		result[j, k] <- rightLabels
		if (!is.null(rightjustification))
		    justification[j, k] <- rightjustification 
	    } else {
		nrows <- max(nrl, nrr)
		result <- matrix("", nrows, ncl + ncr)
		justification <- matrix(NA_character_, nrows, ncl + ncr)
		j <- (nrows-nrl) + seq_len(nrl)
		k <- seq_len(ncl)
		result[j, k] <- leftLabels
		if (!is.null(leftjustification))
		    justification[j, k] <- leftjustification
		j <- (nrows-nrr) + seq_len(nrr)
		k <- ncl+seq_len(ncr)
		result[j,k] <- rightLabels
		if (!is.null(rightjustification))
		    justification[j, k] <- rightjustification
	    }
        })
    } else if (op == "(") {
    	result <- getLabels(e[[2]], rows, justify, NULL, suppress)
    	if (!is.null(head)) {
	    if (suppress == 0) {
		saveattrs <- attributes(result)
		if (rows) {
		    result <- cbind("", result)
		    justification <- cbind(justify, justification)
		} else {
		    result <- rbind("", result)
		    justification <- rbind(justify, justification)
		}
		result[1,1] <- head
	    } else 
		suppress <- suppress - 1
        } 	
    } else if (op == ".Format") {
    	result <- if (rows) matrix(NA, ncol=0, nrow=1)
    		  else      matrix(NA, ncol=1, nrow=0)
    } else if (op == "Heading") {
    	if (length(e) > 1) {
    	    if (suppress <= 0) {
    	    	if (is.character(e[[2]]))
    	    	    Heading <- e[[2]]
    	    	else
    	    	    Heading=deparse(e[[2]])
    	    } else 
    	    	suppress <- suppress - 1
    	} else
    	    suppress <- suppress + 1
    } else if (op == "Justify") {
    	justify <- as.character(e[[2]])
    } else if (suppress > 0) {  # The rest just add a single label; suppress it
    	suppress <- suppress - 1
    } else if (op == "Percent" && is.null(head)) {
      result <- matrix("Percent", 1,1, dimnames=list(NULL, ""))
    } else if (!is.null(head)) {
    	result <- matrix(head, 1,1, dimnames=list(NULL, ""))
    	Heading <- NULL
    } else if (identical(e, 1)) 
    	result <- matrix("All", 1,1, dimnames=list(NULL, ""))
    else
    	result <- matrix(deparse(e), 1,1, dimnames=list(NULL, ""))
    if (is.null(justification))
    	justification <- matrix(justify, nrow(result), ncol(result))
    structure(result, justification = justification, 
    	colnamejust = colnamejust, justify = justify,
   	Heading = Heading, suppress = suppress)
}

expandExpressions <- function(e, env) {
    if (is.call(e)) {
	if ((op <- as.character(e[[1]])) %in% c("*", "+", "~", "(", "=") ) {
	    e[[2]] <- expandExpressions(e[[2]], env)
	    if (length(e) > 2)
		e[[3]] <- expandExpressions(e[[3]], env)
	} else if (op == "Format" || op == ".Format" 
	        || op == "Heading" || op == "Justify"
	        || op == "Percent")
	    e
	else {
	    v <- eval(e, envir=env)
	    if (is.language(v)) 
		e <- expandExpressions(v, env)
	}
    }
    e
}

collectFormats <- function(table) {
    formats <- list()
    recurse <- function(e) {
    	if (is.call(e)) {
    	    if ((op <- as.character(e[[1]])) %in% c("*", "+", "~", "(") ) {
    	    	e[[2]] <- recurse(e[[2]])
    	    	if (length(e) > 2)
	    	    e[[3]] <- recurse(e[[3]])
    	    } else if (op == c("Format")) {
    	    	if (length(e) == 2 && is.null(names(e)))
    	    	    formats <<- c(formats, list(e[[2]]))
    	    	else {
    	    	    e[[1]] <- as.name("format")
    	    	    formats <<- c(formats, list(e))
    	    	}    
    	    	e <- call(".Format", length(formats))
    	    }
    	}
    	e
    }
    result <- recurse(table)
    structure(result, fmtlist=formats)
}

# This both expands factors and rewrites "bindings"

expandFactors <- function(e, env) {
    op <- ""
    if (is.call(e) && (op <- as.character(e[[1]])) %in% c("*", "+") ) 
    	call(op, expandFactors(e[[2]],env),expandFactors(e[[3]],env))
    else if (op == "(")
    	expandFactors(e[[2]],env)
    else if (op == "=")
    	call("*", call("Heading", as.name(deparse(e[[2]]))),
    		  expandFactors(e[[3]], env))
    else if (op == ".Format" || op == "Heading" || 
             op == "Justify" || op == "Percent")
    	e
    else {
    	v <- eval(e, envir=env)
    	if (is.factor(v) & !inherits(v, "AsIs")) {
    	    levs <- levels(v)
    	    if (length(levs)) {
    	     	f <- call("*", call("Heading", as.name(levs[1])), 
    	     		       call("==", call("as.integer", e), 1L))
    	     	for (i in seq_along(levs)[-1]) {
    	     	    test <- i  # Work around a bug in R 2.12.x!
    	     	    test <- call("==", call("as.integer", e), i)
    	     	    f <- call("+", f, call("*", call("Heading", as.name(levs[i])), 
    	     	                                test))
    	     	}
    	     	e <- call("*", call("Heading", as.name(deparse(e))), f)
    	     }
    	}
    	e
    }
}


# A sum of products is a list whose elements are atoms or products of atoms.

sumofprods <- function(e) {
    if (!is.language(e)) return(list(e))
    if (is.expression(e)) e <- e[[1]]
    if (is.name(e)) result <- list(e)
    else {
	chr <- as.character(e[[1]])
	if (chr == "+") result <- c(sumofprods(e[[2]]),sumofprods(e[[3]]))
    	else if (chr == "*") {
	    left <- sumofprods(e[[2]])
	    right <- sumofprods(e[[3]])
	    result <- list()
	    for (i in 1:length(left)) 
	       for (j in 1:length(right)) 
		    result <- c(result, list(call("*", left[[i]], right[[j]])))
    	} else if (chr == "(") result <- sumofprods(e[[2]])
    	else if (chr == "~") stop("nested formulas not supported")
    	else result <- list(e)

    }    	
    result
}

tabledims <- function(e) {
    if (identical(e,1)) return(list(1))
    if (!is.language(e)) stop('Need an expression')
    if (is.expression(e)) e <- e[[1]]
    if (is.name(e)) result <- list(e)
    else {
        result <- list()
	chr <- as.character(e[[1]])
	if (chr == "~") {
	    if (length(e) == 2)
		result <- c(result, tabledims(e[[2]]))
	    else
	    	result <- c(result, tabledims(e[[2]]),tabledims(e[[3]]))
    	} else result <- list(e)
    }    	
    if (length(result) > 2) stop("only 2 dim tables supported")
    result
}

tabular <- function(table, ...) 
    UseMethod("tabular")
    
tabular.default <- function(table, ...) {
    tabular.formula(as.formula(table, env=parent.frame()), ...)
}

tabular.formula <- function(table, data=NULL, n, suppressLabels=0, ...) {
    if (length(list(...)))
	warning(gettextf("extra argument(s) %s will be disregarded",
			 paste(sQuote(names(list(...))), collapse = ", ")),
		domain = NA)
    if (missing(n) && inherits(data, "data.frame"))
    	n <- nrow(data)
    if (is.null(data))
    	data <- environment(table)
    else if (is.list(data))
    	data <- list2env(data, parent=environment(table))
    else if (!is.environment(data))
    	stop("data must be a dataframe, list or environment")
    	
    table <- expandExpressions(table, data)
    table <- collectFormats(table)
    dims <- tabledims(table)
    if (length(dims) == 1) dims <- c(list(quote((` `=1))), dims)
    dims[[1]] <- expandFactors(dims[[1]], data)
    rlabels <- getLabels(dims[[1]], rows=TRUE, suppress=suppressLabels)
    suppressLabels <- attr(rlabels, "suppress")
    justify <- attr(rlabels, "justify")
    dims[[2]] <- expandFactors(dims[[2]], data)
    clabels <- getLabels(dims[[2]], rows=FALSE, justify=justify,
			 suppress=suppressLabels)
    rows <- sumofprods(dims[[1]])
    cols <- sumofprods(dims[[2]])
    result <- NULL
    formats <- NULL
    justifications <- NULL
    for (i in seq_along(rows)) {
    	row <- NULL
    	rowformats <- NULL
    	rowjustification <- NULL
    	for (j in seq_along(cols)) {
    	    # term2table checks that n matches across calls
    	    term <- term2table(rows[[i]], cols[[j]], data, n)
    	    n <- attr(term, "n")
    	    format <- attr(term, "format")
    	    justification <- attr(term, "justification")
    	    row <- cbind(row, term)
    	    rowformats <- cbind(rowformats, format)
    	    rowjustification <- cbind(rowjustification, justification)
    	}
    	result <- rbind(result, row)
    	formats <- rbind(formats, rowformats)
    	justifications <- rbind(justifications, rowjustification)
    }
    structure(result, rowLabels=rlabels, colLabels=clabels, table=table,
    	      formats = formats, justification = justifications, 
    	      class = "tabular")
}

justify <- function(x, justification="c", width=max(nchar(x))) {
    justification <- rep(justification, len=length(x))
    change <- justification %in% c("c", "l", "r")
    if (!any(change)) return(x)
    y <- x[change]
    justification <- justification[change]
    y <- sub("^ *", "", y)
    y <- sub(" *$", "", y)
    width <- rep(width, len=length(x))
    lens <- nchar(y)
    ind <- justification == "c"
    if (any(ind)) {
    	left <- (width[ind] - lens[ind]) %/% 2
    	right <- width[ind] - lens[ind] - left
    	y[ind] <- sprintf("%*s%s%*s", left, "", y[ind], right, "")
    }
    ind <- justification == "l"
    if (any(ind)) {
    	right <- width[ind] - lens[ind]
    	y[ind] <- sprintf("%s%*s", y[ind], right, "")
    }
    ind <- justification == "r"
    if (any(ind)) {
    	left <- width[ind] - lens[ind]
    	y[ind] <- sprintf("%*s%s", left, "", y[ind])
    }
    x[change] <- y
    x
}

latexNumeric <- function(chars, minus=TRUE, leftpad=TRUE, rightpad=TRUE,
			 mathmode=TRUE) {
    regexp <- "^( *)([-]?)([^ -][^ ]*)( *)$"
    leadin <- sub(regexp, "\\1", chars)
    sign <- sub(regexp, "\\2", chars)
    rest <- sub(regexp, "\\3", chars)
    tail <- sub(regexp, "\\4", chars)
    
    if (minus && any(neg <- sign == "-")) {
    	if (any(leadin[!neg] == ""))
    	    leadin <- sub("^", " ", leadin)
    	leadin[!neg] <- sub(" ", "", leadin[!neg])
    	sign[!neg] <- "\\phantom{-}"
    }
    if (leftpad && any(ind <- leadin != "")) 
    	leadin[ind] <- paste("\\phantom{", 
    	                     gsub(" ", "0", leadin[ind]),
    	                     "}", sep="")
    if (rightpad && any(ind <- tail != ""))
    	tail[ind] <- paste("\\phantom{",
    			   gsub(" ", "0", tail[ind]),
    			   "}", sep="")
    if (mathmode)
    	paste("$", leadin, sign, rest, tail, "$", sep="")
    else
    	paste(leadin, sign, rest, tail, sep="")
}

format.tabular <- function(x, digits=4, justification="n", 
                           latex=FALSE, ...) {
    result <- unclass(x) 
    formats <- attr(x, "formats")
    fmtlist <- attr(attr(x, "table"), "fmtlist")
    justify <- attr(x, "justification")
    justify[is.na(justify)] <- justification
    chars <- matrix(NA_character_, nrow(result), ncol(result))
    for (i in seq_len(ncol(result))) {
        ind <- col(result) == i & is.na(formats)
        if (any(ind)) {
            x <- do.call(c, result[ind])
    	    chars[ind] <- format(x, digits=digits, ...)
    	    if (latex && is.numeric(x))
    	    	chars[ind] <- latexNumeric(chars[ind])
    	}
    }
    for (i in seq_along(fmtlist)) {
    	ind <- !is.na(formats) & formats == i
    	if (any(ind)) {        
            call <- fmtlist[[i]]
	    last <- length(call)
       	    x <- do.call(c, result[ind])
       	    call[[last+1]] <- x
       	    names(call)[last+1] <- "x"
       	    chars[ind] <- eval(call, parent.frame())
       	    if (latex && identical(call[[1]], as.name("format")))
       	    	if (is.numeric(x))
       	    	    chars[ind] <- latexNumeric(chars[ind])
       	    	else
       	    	    chars[ind] <- texify(chars[ind])
       	}
    }
    if (!latex)
    	for (i in seq_len(ncol(result))) 
    	    chars[,i] <- justify(chars[,i], justify[,i])
    chars
}
