\name{Paste}
\alias{Paste}
\title{
Generate terms to paste values together in table.
}
\description{
This function generates a component of a table formula to output
multiple columns with punctuation between.  It is 
designed only for LaTeX output.
}
\usage{
Paste(..., head, digits=2, justify="c", prefix="", sep="", postfix="",
      character.only = FALSE)
}
\arguments{
  \item{...}{
Expressions to be displayed in the columns of the table.  If they are
named, they will get those names as headings, otherwise they will not be labelled.
}
  \item{head}{
If not missing, this will be used as a column heading for the combined columns.
}
  \item{digits}{
Will be passed to the \code{\link{format}} function.  If \code{digits} is
length one, all columns use a common format; otherwise they are
formatted separately.
}
  \item{justify}{
One or more justifications to use on the individual columns.
}
  \item{sep}{
One or more separators to use between columns.  
}
  \item{prefix, postfix}{
Additional text to insert before and after the group of columns.
}
  \item{character.only}{
If \code{TRUE}, the \code{head} argument will be interpreted
as an expression evaluating to a character value.
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
