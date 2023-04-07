\name{matrix_form.tabular}
\alias{matrix_form.tabular}
\title{
Transform tabular object to matrices printable by formatters package
}
\description{
The \pkg{formatters} package provides methods for displaying
and breaking up tables into smaller pieces.
}
\usage{
matrix_form.tabular(df)
}
\arguments{
  \item{df}{
A tabular object.
}
}
\details{
The \pkg{formatters} package provides a \code{matrix_form}
generic function for S4 objects.  \code{"tabular"} objects
are S3 objects, so it won't dispatch to this function, 
which must be fully specified when called.
}
\author{
Duncan Murdoch with help from Gabe Becker.
}
\examples{
if (requireNamespace("formatters")) {
  Sex <- factor(sample(c("Male", "Female"), 100, rep=TRUE))
  Status <- factor(sample(c("low", "medium", "high"), 100, rep=TRUE))
  z <- rnorm(100) + 5
  fmt <- function(x) {
  s <- format(x, digits=2)
  even <- ((1:length(s)) \%\% 2) == 0
  s[even] <- sprintf("(\%s)", s[even])
  s
}
  tab <- tabular( Justify(c)*Heading()*z*Sex*Heading(Statistic)*Format(fmt())*(mean+sd) 
                  ~ Status )
  mform <- matrix_form.tabular(tab)
  page <- 1
  cat("Page ", page, " Full table\n\n")
  cat(formatters::toString(mform))
  
  # This shows automatic pagination, breaking up the
  # table by rows
  byrow <- formatters::pag_indices_inner(formatters::mf_rinfo(mform),
                              rlpp = 2,
                              min_siblings = 1)
  for (i in seq_along(byrow)) {
    mform2 <- matrix_form.tabular(tab[byrow[[i]], ])
    page <- page + 1
    cat("\nPage ", page, " Rows", byrow[[i]], "\n\n")
    cat(formatters::toString(mform2))
  }
  
  # This gives the breaks by columns, counting the
  # row label columns:
  bycol <- formatters::vert_pag_indices(mform, cpp = 30,  rep_cols = 2)
  # Display the table with both kinds of breaks
  for (i in seq_along(byrow)) {
    rows <- byrow[[i]]
    for (j in seq_along(bycol)) {
      cols <- bycol[[j]]
      cols <- cols[cols > 2] - 2  # cols includes the row labels
      mform3 <- matrix_form.tabular(tab[rows, cols, drop = FALSE])
      page <- page + 1
      cat("\nPage ", page, "Rows", rows, "column", cols, "\n\n")
      cat(formatters::toString(mform3))
    }
  }
}
}