All <- function(df,
           numeric = TRUE,
           character = FALSE,
           logical = FALSE,
           factor = FALSE,
           complex = FALSE,
           raw = FALSE,
           other = FALSE,
           texify = getOption("tables.texify", FALSE)) {
    names <- colnames(df)
    if (texify)
      names <- Hmisc::latexTranslate(names)
    
    f <- NULL
    for (i in seq_along(names)) {
      value <- df[[i]]
      if (is.numeric(value))
        sel <- numeric
      else if (is.character(value))
        sel <- character
      else if (is.logical(value))
        sel <- logical
      else if (is.factor(value))
        sel <- factor
      else if (is.complex(value))
        sel <- complex
      else if (is.raw(value))
        sel <- raw
      else
        sel <- other
      
      if (is.character(sel))
        sel <- get(sel, mode = "function", envir = parent.frame())
      
      if (is.function(sel))
        value <- sel(value)
      else if (isTRUE(sel))
        value <- call("[[", substitute(df), i)
      else
        next
      
      f1 <- call("*", call("Heading", makeName(names[i])),
                 value)
      if (is.null(f))
        f <- f1
      else
        f <- call("+", f, f1)
    }
    f
  }
