HTMLfootnotes <- function(tab, ...) {
  notes <- list(...)
  names <- names(notes)
  if (is.null(names))
    markers <- rep("", length(notes))
  else
    markers <- paste0('<sup>', names, '</sup>')
  notes <- unlist(notes)
  paste0('<tr><td colspan=', ncol(tab) + ncol(rowLabels(tab)), '>',
         paste0(markers, notes, collapse = '<br>\n'),
         '</td></tr>\n')
}
