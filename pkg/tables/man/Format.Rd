\name{Format}
\alias{Format}
\alias{.Format}
\title{
\code{Format} pseudo-function
}
\usage{
Format(...)
.Format(n)
}
\arguments{
  \item{...}{
Arguments to pass to a formatting function, or a call to a formatting function.
}
  \item{n}{
A format number.
}
}

\description{
\code{Format} controls the formatting
of the cells it applies to.  \code{.Format} is mainly for internal use.
}

\details{

The \code{Format} pseudo-function changes the
formatting of table cells, and it specifies that all values it applies to will be
formatted together. 

In the first form, the \dQuote{call} to \code{Format} looks like a call to
\code{format}, but without specifying the argument \code{x}.  When
\code{tabular()} formats the output it will construct \code{x} from
the entries in the table governed by the \code{Format()}
specification, and pass it to the standard \code{\link{format}} function
along with the other arguments.

In the second form, the \dQuote{call} to \code{Format} contains a 
call to a function to do the formatting.  Again, an argument
\code{x} will be added to the call, containing the values to be formatted.

In the first form, or if the explicit function is named \code{format}, any cells
in the table with character values will not be formatted.  This is
done so that a column can have mixed numeric and character values, and
the numerics are not converted to character before formatting.

The pseudo-function \code{.Format} is mainly intended for internal
use. It takes a single integer argument, saying that data governed by
this call uses the same formatting as the format specification
indicated by the integer. In this way entries can be commonly
formatted even when they are not contiguous. The integers are assigned
sequentially as the format specification is parsed; users will likely
need trial and error to find the right value in a complicated table
with multiple formats.
}
\section{Pseudo-functions}{
This is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}.
}
\examples{
# Using the first form
tabular( (Sepal.Length+Sepal.Width) ~ 
         Format(digits=2)*(mean + sd), data=iris )
         
# The same table, using the second form
tabular( (Sepal.Length+Sepal.Width) ~ 
         Format(format(digits=2))*(mean + sd), data=iris )

}
