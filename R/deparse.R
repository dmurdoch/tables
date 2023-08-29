# base::deparse might return more than one line; this 
# replaces it with a function that chops the results

deparse <- function(expr, width.cutoff = 500L, nlines = 1L, ...) {
  base::deparse(expr, width.cutoff = width.cutoff, nlines = nlines, ...)
}
