\name{Percent}
\alias{Percent}
\title{
\code{Percent} pseudo-function
}
\usage{
Percent(denom = "all", fn = percent)
}
\arguments{
  \item{denom}{
How the denominator should be calculated.  See below.
}
  \item{fn}{
The two argument function to calculate the statistic.
}
}

\description{
The \code{Percent} pseudo-function is used to specify
a statistic that depends on other values in the table.
}
\details{
The function \code{fn} will be called with two
arguments.  The first is the usual vector of values
to which this statistic applies, and the second 
is another vector of reference values, determined
by \code{denom}.  The default function is \code{percent},
defined as \code{function(x, y) 100*length(x)/length(y)}.

With the default \code{denom = "all"}, all values of the
analysis variable in the dataset are used as the reference.  Other possibilities
are \code{denom = "row"} or \code{denom = "col"}, for which
the values of the variable corresponding to the current row
or column subset are used, or a logical vector, in which
case those values are used, or anything else, which will
be passed as \code{y}.
}
\section{Pseudo-functions}{
This is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}.
}

\examples{
x <- factor(sample(LETTERS[1:2], 1000, rep=TRUE))
y <- factor(sample(letters[3:4], 1000, rep=TRUE))
tabular( (x + 1) ~ (y + 1)*(RowPct=Percent("row")))
}
