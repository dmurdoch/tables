\name{DropEmpty}
\alias{DropEmpty}
\title{
\code{DropEmpty} pseudo-function
}
\description{
Pseudo-function to indicate that rows or columns containing
no observations should be dropped.
}
\usage{
DropEmpty(empty = "", which = c("row", "col", "cell"))
}
\arguments{
  \item{empty}{
String to use in empty cells.  
}
  \item{which}{
A vector indicating what should be dropped.  See the Details
below.
}
}
\details{
If the \code{which} argument contains \code{"row"}, then
any row in the table in which all cells are empty will be dropped.
Similarly, if it contains \code{"col"}, empty columns
will be dropped.  If it contains \code{"cell"}, then cells
in rows and columns that are not dropped will be set to
the \code{empty} string.

}
\section{Pseudo-functions}{
This is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}. 
}

\examples{
df <- data.frame(row = factor(1:10), value = rnorm(10))
subset <- df[sample(10, 5),, drop = FALSE]

# Some rows did not get selected, so this looks ugly
tabular(row ~ value*mean, data = subset)

# This only shows rows with data in them
tabular(row*DropEmpty() ~ value*mean, data = subset)

# This shows empty cells as "(empty)"
tabular(row*DropEmpty("(empty)", "cell") ~ value*mean, data = subset)
}
