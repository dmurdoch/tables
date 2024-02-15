toTinytable <- function(table, ...) {

  if (!inherits(table, "tabular"))
    stop("'table' must be a 'tabular' object.")

  if (!requireNamespace("tinytable"))
    stop("Please install the 'tinytable' package.")

  rowLabels <- attr(table, "rowLabels")
  rowLabels[is.na(rowLabels)] <- ""

  clabels <- attr(table, "colLabels")

  # pad column labels based on row stubs
  pad <- matrix("", nrow = nrow(clabels), ncol = ncol(rowLabels))
  pad[nrow(pad),] <- colnames(rowLabels)
  clabels <- cbind(pad, clabels)

  chars <- format(table, latex = FALSE)

  chars <- data.frame(rowLabels, chars)
  colnames(chars) <- clabels[nrow(clabels),]

  # fill in missing column labels
  for (i in seq_len(nrow(clabels))) {
    for (j in seq_len(ncol(clabels))) {
      if (j != 1 && is.na(clabels[i, j])) {
        clabels[i, j] <- clabels[i, j - 1]
      }
    }
  }

  out <- tinytable::tt(chars, ...)

  # TODO: allow justification on a cell-by-cell basis. Currently we only columns.
  just <- cbind(
    attr(attr(table, "rowLabels"), "justification"),
    attr(table, "justification"))
  for (j in seq_len(ncol(just))) {
    align <- unique(just[, j])
    if (length(align) == 1 && align %in% c("l", "r", "c")) {
      out <- tinytable::style_tt(out, j = j, align = align)
    }
  }

  # column spans
  get_span <- function(x) {
    x <- trimws(x)
    idx <- rle(x)
    end <- cumsum(idx$length)
    start <- end - idx$length + 1
    span <- lapply(seq_along(idx$values), function(i) start[i]:end[i])
    names(span) <- idx$values
    span <- span[names(span) != ""]
    return(span)
  }

  # entries in the first row of clabels are already colnames in out
  if (nrow(clabels) > 1) {
    for (i in (nrow(clabels) - 1):1) {
      s <- get_span(clabels[i,])
      out <- tinytable::group_tt(out, j = s)
    }
  }

  return(out)
}
