Heading <- function(name = NULL, override = TRUE, character.only = FALSE,
		    nearData = TRUE) 
    stop("This is a pseudo-function, not meant to be called.")
    
Justify <- function(labels, data=labels)
    stop("This is a pseudo-function, not meant to be called.")

Format <- function(...) 
    stop("This is a pseudo-function, not meant to be called.")

.Format <- function(n) 
    stop("This is a pseudo-function, not meant to be called.")

Percent <- function(denom = "all", fn = percent)
    stop("This is a pseudo-function, not meant to be called.")

percent <- function(x, y) 100*length(x)/length(y)

Arguments <- function (...)
    stop("This is a pseudo-function, not meant to be called.")

DropEmpty <- function (empty = "", which = c("row", "col", "cell"))
    stop("This is a pseudo-function, not meant to be called.")
