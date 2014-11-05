\name{latex.tabular}
\alias{latex.tabular}
\title{
Display a tabular object using LaTeX.
}
\description{
This is similar to \code{\link{print.tabular}}, but it inserts the code to
display the table in a LaTeX tabular environment.
}
\usage{
\method{latex}{tabular}(object, file = "", options = NULL, append = FALSE, ...)
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
The \code{latex()} method produces LaTeX output suitable for inclusion in a \code{\link{Sweave}} document.
}
\value{
The \code{latex()} method returns \code{x} invisibly, and prints the LaTeX script to the console.

\code{table_options()} and \code{booktabs()} return the previous settings.
}
\seealso{
\code{\link{print.tabular}}, \code{\link{table_options}}, \code{\link[Hmisc]{latex}}
}
\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
latex(tab)
save <- booktabs()
latex(tab)
table_options(save)
}
