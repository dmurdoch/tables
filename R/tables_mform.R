# This method lets tables work with functions from the 
# formatters package.

matrix_form.tabular <- function(df) {
  if (!requireNamespace("formatters"))
    stop("This method requires the formatters package.")
  header <- attr(df, "colLabels")
  body_norl <- as.matrix(df, rowLabels = FALSE,
                        colLabels = FALSE)
  body_wrl <- as.matrix(df, rowLabels = TRUE,
                         colLabels = FALSE)
  nrl <- ncol(body_wrl) - ncol(body_norl)
  header <- cbind(matrix("", nrow = nrow(header), ncol = nrl), ## above row labels
                 header)

  strings <- rbind(header, body_wrl)

  rows <- nrow(strings)
  cols <- ncol(strings)

  spans <- matrix(NA, rows, cols)
  span <- rep(1, rows)

  # Tables marks multi-column entries by putting NA
  # in following columns.  This converts that to the
  # spans matrix that formatters wants.
  spans <- matrix(NA, rows, cols)
  span <- rep(1, rows)
  ## my code handles row by row, rather than full columns in a single go.
  for (i in seq_len(rows)) {
    nas <- is.na(strings[i,])
    ## how many values to be printed we have seen. When this stays constant we have a span.
    groups <- cumsum(!nas)
    ## Just in case there are leading NAs, we handle them separately
    nzero <- sum(groups == 0)
    groups <- groups[groups > 0]
    spans[i,] <- c(rep(1, times = nzero), ## leading NAs in strings if any
                   unlist(lapply(split(groups, groups), function(x) rep(length(x), length(x)))))

  }

  ## we're done inferring span from NAs in strings so we need to take them out
  ## ones that were subsumed in spans would be ok, but leading ones are going to be "printed"
  ## so they need to be "", and replacing the spanned-over ones wont' hurt anything
#  strings[is.na(strings)] <- ""
  aligns <- cbind(matrix("c", ncol = nrl, nrow = rows),
                      rbind(attr(attr(df, "colLabels"), "justification"),
                            attr(df, "justification")))
  formats <- matrix("xx", rows, cols)
  row_info <- formatters::basic_pagdf(1:(rows - nrow(header)))
  nrow_header <- nrow(header)
  
  # formatters has renamed the matrix_print_form function to
  # MatrixPrintForm
  MatrixPrintForm <- try(get("MatrixPrintForm", envir = asNamespace("formatters")), silent = TRUE)
  if (inherits(MatrixPrintForm, "try-error"))
    MatrixPrintForm <- get("matrix_print_form", envir = asNamespace("formatters"))

  MatrixPrintForm(strings = strings,
                    spans = spans,
                    aligns = aligns,
                    formats = formats,
                    row_info = row_info,
                    nrow_header = 2,
                    has_rowlabs = FALSE,
                    has_topleft = FALSE)
}
