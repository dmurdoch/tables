\name{labels}
\alias{rowLabels}
\alias{rowLabels<-}
\alias{colLabels}
\alias{colLabels<-}
\alias{[.tabularColLabels}
\alias{[.tabularRowLabels}
\title{
Retrieve or modify the row or column labels.
}
\description{
These functions allow the row or column labels of a tabular
object to be retrieved or modified.
}
\usage{
rowLabels(x)
rowLabels(x) <- value
colLabels(x)
colLabels(x) <- value
\method{[}{tabularRowLabels}(x, i, j, ..., drop = FALSE)
\method{[}{tabularColLabels}(x, i, j, ..., drop = FALSE)
}
\arguments{
  \item{x}{
A \code{"tabular"}, \code{"tabularRowLabels"} or \code{"tabularColLabels"} object.
}
  \item{value}{
A replacement
}
  \item{i, j, ..., drop}{
Arguments used for subsetting the labels.  See Details below.
}
}
\details{
Subsetting the row labels does not allow the number of rows
to be changed; likewise, subsetting the column labels does
not allow the number of columns to be changed.  To change both, 
subset the original \code{"tabular"} object.
}
\value{
\code{rowLabels} and the corresponding subsetting method
return an object of class \code{"tabularRowLabels"}.

\code{colLabels} and the corresponding subsetting method 
return an object of class \code{"tabularColLabels"}.

The assignment functions return \code{"tabular"} objects.
}

\seealso{
\code{\link{[.tabular}}
}
\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
colLabels(tab)
colLabels(tab) <- colLabels(tab)[1,]
tab
}