
useGroupLabels <- function(tab, col = 1, indent = "  ", newcolumn = 1, singleRow = TRUE, extraLines = 0) {
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
  tmp <- rowlabels[, newcolumn]
  tmp[is.na(tmp)] <- ""
  tmp <- paste0(indent, tmp)
  rowlabels[, newcolumn] <- tmp
  newgroup <- !is.na(colvals) & colvals != ""
  first <- which(newgroup)
  last <- c(first[-1] - 1, nrow(tab))
  for (i in rev(seq_along(first))) {
    single <- singleRow && 
              first[i] == last[i] && 
              rowlabels[first[i], newcolumn] == indent
    if (i == 1)
      extraLines <- 0
    if (single) 
      extras <- extraLines
    else
      extras <- 1 + extraLines
    
    rows <- c(seq_len(first[i] - 1), rep(first[i], extras), first[i]:nrow(rowlabels))
    rowlabels <- rowlabels[rows,,drop = FALSE]
    if (extras > 0) {
      rowlabels[first[i] + extras,] <- rowlabels[first[i],]
      rowlabels[first[i] + seq_len(extras) - 1,] <- ""
    }
    # This is tricky.  If single is TRUE, want it on the last
    # line, which is first[i] + extras.  If not, want it
    # on the line before that, which is first[i] + extras - 1
    rowlabels[first[i] + extras - !single, newcolumn] <- colvals[first[i]]
    tab <- tab[rows,,drop = FALSE]
    if (extras > 0)
      tab[first[i] + seq_len(extras) - 1, ] <- ""
  }
  rowLabels(tab) <- rowlabels
  tab
}
