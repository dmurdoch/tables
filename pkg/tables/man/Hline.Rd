\name{Hline}
\alias{Hline}
\title{
Add a horizontal line to a LaTeX table.
}
\description{
This function inserts a LaTeX directive to draw a full or partial 
line in a table.  
}
\usage{
Hline(columns)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{columns}{
Which columns should receive the line?
}
}
\details{
\code{Hline()} is not very flexible:  it must be the leftmost header in a row specification
for the table, i.e. \code{mean * Hline()} is not allowed.  Anything to the right of the
\code{Hline()} factor will be ignored.
}
\value{
Produces an expression to insert a label which will be interpreted by LaTeX as a request
for a horizontal line.
}

\examples{
latex( tabular( Species + Hline() + 1 ~ mean*Sepal.Width, data=iris) )
}
