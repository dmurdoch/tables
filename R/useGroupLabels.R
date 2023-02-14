
useGroupLabels <- function(tab, col = 1, indent = "  ", newcolumn = 1, singleRow = TRUE) {
  rowlabels <- rowLabels(tab)
  if (ncol(rowlabels) < col)
    stop("Column ", col, " not found in row labels.")
  colvals <- rowlabels[, col]
  while (ncol(rowlabels) < newcolumn + 1) {
    rowlabels <- rowlabels[, c(seq_len(ncol(rowlabels)), 1)]
    rowlabels[, ncol(rowlabels)] <- ""
    colnames(rowlabels)[ncol(rowlabels)] <- ""
  }
  rowlabels <- rowlabels[, -col]
  while (newcolumn < 1) {
    rowlabels <- rowlabels[, c(1, seq_len(ncol(rowlabels)))]
    rowlabels[, 1] <- ""
    colnames(rowlabels)[1] <- ""
    newcolumn <- newcolumn + 1
  }
  rowlabels[, newcolumn] <- paste0(indent, rowlabels[, newcolumn])
  newgroup <- !is.na(colvals) & colvals != ""
  first <- which(newgroup)
  last <- c(first[-1] - 1, nrow(tab))
  labelcols <- ncol(rowlabels)
  tablecols <- ncol(tab)
  for (i in rev(seq_along(first))) {
    single <- singleRow && 
              first[i] == last[i] && 
              rowlabels[first[i], newcolumn] == indent
    if (single)
      rows <- seq_len(nrow(rowlabels))
    else
      rows <- c(seq_len(first[i] - 1), first[i], first[i]:nrow(rowlabels))
    rowlabels <- rowlabels[rows,,drop = FALSE]
    if (!single) {
      rowlabels[first[i] + 1,] <- rowlabels[first[i],]
      rowlabels[first[i],] <- ""
    }
    rowlabels[first[i], newcolumn] <- colvals[first[i]]
    tab <- tab[rows,,drop = FALSE]
    if (!single)
      tab[first[i], ] <- ""
  }
  rowLabels(tab) <- rowlabels
  tab
}
