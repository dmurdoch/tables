getHeading <- function(head, subst, character.only) {
    if (missing(head)) quote(Heading())
    else if (!character.only) substitute(Heading(head), list(head=subst))
    else substitute(Heading(head), list(head = head))	
}

Paste <- function(..., head, digits=2, justify="c", prefix="", sep="", postfix="",
		  character.only = FALSE) {
    head <- getHeading(head, substitute(head), character.only)
    args <- sys.call()[-1]
    names <- names(args)
    if (!is.null(names)) {
      drop <- names %in% c("head", "digits", "sep", "justify", "prefix", "postfix",
      		           "character.only")
      args <- args[!drop]
      names <- names[!drop]
    }
    len <- length(args)
    if (!len) stop("Nothing to Paste")
    
    if (is.null(names)) names <- rep("", len)
    
    sep <- rep(sep, length.out = len-1)
    justify <- rep(justify, length.out = len)
    if (length(digits) > 1) digits <- rep(digits, length.out = len)
    
    for (i in 1:len) {
      xhead <- if (names[i] == "") quote(Heading())
               else substitute(Heading(head), list(head=names[i]))
      just <- if (i < len) paste0(justify[i], "@{", sep[i], "}")
                 else justify[i]
      if (prefix != "" && i == 1)
        just <- paste0("@{\\hspace{\\tabcolsep}", prefix, "}", just)
      if (postfix != "" && i == len)
        just <- paste0(just, "@{", postfix, "\\hspace{\\tabcolsep}}")
      term <- substitute(xhead*Justify(just)*x,
                       list(xhead=xhead, just=just, x=args[[i]]))
      if (length(digits) > 1)
        term <- substitute(Format(digits=digits)*term, 
                       list(digits = digits[i], term = term))
      result <- if (i == 1) term
                else substitute(result + term, list(result=result, term=term))
    }
    result <- substitute( head*1*result,
                list(head=head, result=result) )
    if (length(digits) == 1)
      result <- substitute(Format(digits=digits)*result, 
                       list(digits=digits, result=result))
    result
}
