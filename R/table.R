latexTable <- function(table, format = "latex", longtable = FALSE, ...) {
  if (inherits(table, "formula"))
    table <- tabular(table)
  if (!inherits(table, "tabular"))
    stop("'table' must be a 'tabular' or 'formula' object")
  kableArgs <- list(...)
  badnames <- intersect(names(kableArgs), 
                        c("format", "digits", "row.names", "col.names",
                          "align", "format.args", "valign", "vline",
                          "toprule", "bottomrule", "midrule", "linesep"))
  if (length(badnames)) {
    warning("'kable' arguments ", sQuote(badnames), " ignored.")
    keep <- !(names(kableArgs) %in% badnames)
    kableArgs <- kableArgs[keep]
  }
  ktable <- do.call(kable, c(list(0, format, longtable = longtable), kableArgs))
  klines <- strsplit(unclass(ktable), "\n")[[1]]
  format <- attr(ktable, "format")
  if (format == "latex") {
    tlines <- toLatex(table)
    tabularStart <- grep(if (longtable) "\\begin{longtable}" else "\\begin{tabular}", klines, fixed = TRUE)
    tabularEnd <- grep(if (longtable) "\\end{longtable}" else "\\end{tabular}", klines, fixed = TRUE)
    if (length(tabularStart) != 1L || length(tabularEnd) != 1 || tabularStart > tabularEnd)
      stop("tabular part not found in kable dummy table")
    lines <- c(klines[seq_len(tabularStart - 1)],
               tlines,
               klines[seq_len(length(klines) - tabularEnd) + tabularEnd])
  } else 
    stop("Currently only 'latex' format is supported.")
  result <- paste(lines, collapse = "\n")
  attributes(result) <- attributes(ktable)
  result
}