makeName <- function(s) {
  stopifnot(length(s) == 1)
  if (!nchar(s))
    s <- " "
  as.name(s)
}
