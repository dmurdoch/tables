\name{Arguments}
\alias{Arguments}
\title{
\code{Arguments} pseudo-function
}
\usage{
Arguments(...)
}
\arguments{
  \item{...}{
Arguments to pass to the analysis function.
}
}

\description{
The \code{Arguments} pseudo-function enables the use
of analysis functions that take multiple arguments.
}
\details{
The arguments to \code{Arguments}
are evaluated in full, then those which are length \code{n} are subsetted for
each cell in the table.

If no analysis variable has been specified, but \code{Arguments()} has been, then 
the analysis function will be called with arguments matching those
give in \code{...}.  If an analysis variable was specified, it will
be inserted as an unnamed first argument to the analysis function.

The \code{Arguments()} entry will not create a heading.

Only one \code{Arguments()} specification may be active in any
term in the tabular formula.
}
\section{Pseudo-functions}{
This is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}.
}

\examples{
# This is the example from the weighted.mean help page
wt <- c(5,  5,  4,  1)/15
x <- c(3.7,3.3,3.5,2.8)
gp <- c(1,1,2,2)
tabular( (Factor(gp) + 1) 
	  ~ weighted.mean*x*Arguments(w = wt) )
}
