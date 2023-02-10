\name{PlusMinus}
\alias{PlusMinus}
\title{
Generate \code{x +/- y} terms in table.
}
\description{
This function generates a component of a table formula to output
two columns separated by a \code{+/-} sign.  It is 
designed only for LaTeX output.
}
\usage{
PlusMinus(x, y, head, xhead, yhead, digits = 2, 
          character.only = FALSE, ...)
}
\arguments{
  \item{x,y}{
Expressions to be displayed in the columns on the left and right of the \code{+/-} sign,
respectively.
}
  \item{head}{
If not missing, this will be used as a column heading for the two columns.
}
  \item{xhead, yhead}{
If not missing, these will be used as individual column headings.
}
  \item{digits, \dots}{
Parameters to pass to the \code{\link{format}} function.
}
  \item{character.only}{
If \code{TRUE}, the \code{head}, \code{xhead} and \code{yhead} 
arguments will be interpreted
as expressions evaluating to character values.
}
}
\value{
An expression which will produce the requested output in LaTeX. 
}
\examples{
stderr <- function(x) sd(x)/sqrt(length(x))
toLatex( tabular( (Species+1) ~ Sepal.Length*
          PlusMinus(mean, stderr, digits=1), data=iris ) )
}
