getKnitrFormat <- function(default = "latex") {
  options <- opts_knit$get(c("out.format", "rmarkdown.pandoc.to"))
  result <- default
  if (identical(options$out.format, "markdown"))
    result <- options$rmarkdown.pandoc.to
  else if (!is.null(options$out.format))
    result <- options$out.format
  if (result %in% c("html4", "html5")) result <- "html"
  result
}

toKable <- function(table, format = getKnitrFormat(), booktabs = TRUE, ...)
{ 
  if (!inherits(table, "tabular"))
    stop("'table' must be a 'tabular' object.")
	
  format <- match.arg(format, c("latex", "html", "markdown", "pandoc",
  			        "rst"))
  if (!(format %in% c("latex", "html")))
    stop("Only 'latex' and 'html' format are currently supported.")
  
  if (format == "latex") {
    save <- if (booktabs) booktabs() else table_options()
    lines <- paste(toLatex(table)$text, collapse = "")
    table_options(save)
  } else {
    lines <- toHTML(table)
  }
  structure(lines,
	  format = format, class = "knitr_kable",
	  n_head = nrow(attr(table, "colLabels")))
}
