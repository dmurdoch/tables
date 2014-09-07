\name{Percent}
\alias{Percent}
\alias{Equal}
\alias{Unequal}
\title{
Pseudo-function to compute a statistic relative to a reference
set.
}
\usage{
Percent(denom = "all", fn = percent)
}
\arguments{
  \item{denom}{
How the reference set (the denominator in case
of a percentage calculation) should be calculated.  See below.
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
arguments.  The first argument is the usual \dQuote{value vector} 
of values
corresponding to this cell in the table,
and the second 
is another vector of reference values, determined
by \code{denom}.  

The default value of \code{fn} is the \code{percent} function,
defined as \code{function(x, y) 100*length(x)/length(y)}.  This
gives the ratio of the number of values in the current cell
relative to the reference values, expressed as a percentage.
Using \code{fn = function(x, y) 100*sum(x)/sum(y)} would give
the percentage of the sum of the values in the current cell to
the sum in the reference set.

With the default \code{denom = "all"}, all values of the
analysis variable in the dataset are used as the reference.  Other possibilities
are \code{denom = "row"} or \code{denom = "col"}, for which
the values of the variable corresponding to the current row
or column subset are used.  

The special syntax \code{denom = Equal(...)} will record 
each expression in \code{...}.  The
reference set will be the cases with equal values of all
expressions in \code{...} to those of the current cell.
The similar form \code{denom = Unequal(...)}
sets the reference values to be those that differ in any
of the \code{...} expressions from the current cell.  (In
fact, these can be used somewhat more generally; see the 
vignette for details.)

Finally, other possible \code{denom} values 
are a logical vector, in which
case the values marked \code{TRUE} are used, or anything else, which will
be passed to \code{fn} as \code{y}.
}
\section{Pseudo-functions}{
\code{Percent} is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}.  \code{Equal} and \code{Unequal}
are also pseudo-functions, but are only special when used
in the \code{denom} argument to \code{Percent}.
}
\seealso{\code{\link{Arguments}} for a different way to specify
a multiple argument analysis function.}
\examples{
x <- factor(sample(LETTERS[1:2], 1000, rep=TRUE))
y <- factor(sample(letters[3:4], 1000, rep=TRUE))
z <- factor(sample(LETTERS[5:6], 1000, rep=TRUE))

# These both do the same thing:
tabular( (x + 1)*(y + 1) ~ (z + 1)*(1+(RowPct=Percent("row"))))
tabular( (x + 1)*(y + 1) ~ (z + 1)*(1+(xyPct=Percent(Equal(x, y)))))
}
