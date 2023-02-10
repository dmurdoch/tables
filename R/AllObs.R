obsNumber <- function(within = NULL, data = NULL) {
  if (is.null(within))
    n <- NROW(data)
  else {
    if (is.language(within))
      within <- list(within)
    if (is.list(within)) {
      within <- lapply(within, function(x) if (is.language(x)) attr(x, "row") else x)
      n <- NROW(within[[1]])
    } else
      n <- NROW(within)
  }
  obs <- seq_len(n)
  if (!is.null(within)) {
    index <- do.call(rbind, tapply(obs, within, function(x) 
    	cbind(x, seq_along(x)), 
		                   simplify = FALSE))
    obs[index[,1]] <- index[,2]
  }
  obs
}

rowNumber <- function(obs, perrow = 5) {
  (obs - 1) %/% perrow + 1
}

RowNum <- function(within = NULL, perrow = 5, show = FALSE, label = "Row", data = NULL) {
  obs <- obsNumber(within, data)
  row <- rowNumber(obs, perrow)
  result <- if (show) 
    substitute(Factor(row, name = label), 
    	       list(row = row, label = label))
  else
    substitute(Heading()*Heading()*Heading()*Factor(row),
               list(row = row))
  structure(result, row = row)
}

AllObs <- function(data = NULL, show = FALSE, label = "Obsn.", within = NULL) {
  obs <- obsNumber(within, data)
  if (show) 
    head <- substitute(Factor(obs, name = label), list(obs = obs, label = label))
  else
    head <- substitute(Heading()*Heading()*Heading()*Heading()*Factor(obs),
    		   list(obs = obs))
  substitute(head*Heading()*(fn)*DropEmpty(), 
  	     list(fn = function(x) x[1], head = head))
}