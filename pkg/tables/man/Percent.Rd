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
defined as 
\verb{
percent <- function(x, y) 
    if (length(x)) 
        100*length(x)/length(y) 
    else 
        0
}

With the default \code{denom = "all"}, all values of the
analysis variable in the dataset are used as the reference.  Other possibilities
are \code{denom = "row"} or \code{denom = "col"}, for which
the values of the variable corresponding to the current row
or column subset are used.  

The special syntax \code{denom = Equal(...)} will evaluate 
each expression in \code{...} and defines the reference values to be
all of those which evaluate to one of the same values as
the current cell's subset does.  Similarly, \code{denom = Unequal(...)}
sets the reference values to be those that differ in any
of the \code{...} expressions.

Finally, other possible \code{denom} values 
are a logical vector, in which
case those values are used, or anything else, which will
be passed to \code{fn} as \code{y}.
}
\section{Pseudo-functions}{
\code{Percent} is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}.  \code{Equal} and \code{Unequal}
are also pseudo-functions, but are only special when used
as the \code{denom} argument to \code{Percent}.
}

\examples{
x <- factor(sample(LETTERS[1:2], 1000, rep=TRUE))
y <- factor(sample(letters[3:4], 1000, rep=TRUE))
z <- factor(sample(LETTERS[5:6], 1000, rep=TRUE))

# These both do the same thing:
tabular( (x + 1)*(y + 1) ~ (z + 1)*(1+(RowPct=Percent("row"))))
tabular( (x + 1)*(y + 1) ~ (z + 1)*(1+(xyPct=Percent(Equal(x, y)))))
}
