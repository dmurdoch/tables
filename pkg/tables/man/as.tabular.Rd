\name{as.tabular}
\alias{as.tabular}
\alias{as.tabular.default}
\alias{as.tabular.data.frame}
\title{
Convert matrix or dataframe to tabular object.
}
\description{
These functions construct or copy labels onto an existing
matrix or dataframe.
}
\usage{
as.tabular(x, like = NULL)
\method{as.tabular}{default}(x, like = NULL)
\method{as.tabular}{data.frame}(x, like = NULL)
}
\arguments{
  \item{x}{
  The object to convert.
}
  \item{like}{
  If not \code{NULL}, should be a tabular object with the
  same number of rows and columns as \code{x}.  Its labels
  will be used on the result.
}
}
\value{
A \code{tabular} object.
}

\seealso{
\code{as.matrix.tabular}
}
\examples{
model <- tabular( (Species + 1) ~ (n=1) + Sepal.Length + Sepal.Width, data=iris )
model
as.tabular(matrix(1:12, 4,3), like=model)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
