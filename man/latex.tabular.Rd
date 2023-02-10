\name{latex.tabular}
\alias{toLatex}
\alias{latex.tabular}
\alias{toLatex.tabular}
\title{
Display a tabular object using LaTeX.
}
\description{
This is similar to \code{\link{print.tabular}}, but it inserts the code to
display the table in a LaTeX tabular environment.  The \code{toLatex.tabular} method works with the \code{\link{toLatex}} generic
from \pkg{utils}.  
}
\usage{
toLatex(object, ...)
\method{toLatex}{tabular}(object, file = "", options = NULL, append = FALSE, ...)
latex.tabular(object, ...)
}
\arguments{
  \item{object}{
The tabular object.
}
  \item{file}{
A filename or connection to which to write the LaTeX code, or
\code{""} to write to the standard output.
}
  \item{options}{
A list of options to set for the duration of the call.
}
  \item{append}{
If \code{TRUE}, opens \code{file} for appending (if it is
a filename rather than a connection).
}
  \item{...}{
Settings for default formatting.  See Details below.
}  
}
\details{
The \code{toLatex()} method produces LaTeX output suitable for inclusion in a \code{\link{Sweave}} document. 

The \code{latex.tabular} function is set up
to work as a method for the \code{latex} generic in \pkg{Hmisc},
but is not registered as a method, so that \pkg{tables} can
work when \pkg{Hmisc} is not installed.
}
\value{
The \code{toLatex()} method returns \code{x} invisibly, and prints the LaTeX script to the console.

\code{table_options()} and \code{booktabs()} return the previous settings.
}
\seealso{
\code{\link{print.tabular}}, \code{\link{table_options}},
\code{\link{toLatex}}, \code{\link[Hmisc]{latex}}
}
\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
toLatex(tab)
save <- booktabs()
toLatex(tab)
table_options(save)
}
