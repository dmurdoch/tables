toTinytable <- function(object, file = "", ...) {

  rowLabels <- attr(object, "rowLabels")
  rowLabels[is.na(rowLabels)] <- ""

  clabels <- attr(object, "colLabels")

  # pad column labels based on row stubs
  pad <- matrix("", nrow = nrow(clabels), ncol = ncol(rowLabels))
  pad[nrow(pad),] <- colnames(rowLabels)
  clabels <- cbind(pad, clabels)

  chars <- format(object, latex = FALSE, minus = opts$latexminus, 
                  leftpad = opts$latexleftpad, 
                  rightpad = opts$latexrightpad,...) # format without justification

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

  # convert to tinytable format
  out <- tinytable::tt(chars)

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

  spans <- rev(apply(clabels, 1, get_span)[1:(nrow(clabels) - 1)])

  for (s in spans) {
    out <- tinytable::group_tt(out, j = s)
  }

  return(out)
}
