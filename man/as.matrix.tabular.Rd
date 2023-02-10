\name{as.matrix.tabular}
\alias{as.matrix.tabular}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Convert tabular object to matrix
}
\description{
Convert a tabular object to a matrix of the strings that would print, or a matrix of values.
}
\usage{
\method{as.matrix}{tabular}(x, format = TRUE, 
    rowLabels = TRUE, colLabels = TRUE, justification = "n", ...)
}
\arguments{
  \item{x}{
A \code{"tabular"} object.
}
  \item{format}{
How to format; see Details below.
}
  \item{rowLabels, colLabels}{
Whether to include the row or column labels; only used
if \code{format = TRUE}.
}
  \item{justification}{
How to justify values; only used if \code{format = TRUE}.
}
  \item{\dots}{
Other parameters to pass to \code{\link{format.tabular}}.
}
}
\details{
If \code{format=TRUE}, then a matrix of formatted strings is produced.  If not, then
the \code{format} argument is assumed to be a function (or name of a function passed as
a character vector) to convert the list-mode matrix to another mode, e.g. \code{as.numeric}.
}
\value{
A matrix.
}
\examples{

table <-
    tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )

print(table)
as.matrix(table)
as.matrix(table, format=as.numeric)
}
