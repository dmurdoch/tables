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
\method{latex}{tabular}(object, file="", justification="c", 
        tabular="tabular", ...)
}
\arguments{
  \item{object}{
The tabular object.
}
  \item{file}{
A filename to which to write the LaTeX code.
}
  \item{justification}{
Default justification for the table.
}
  \item{tabular}{
The LaTeX environment to use for the table.  
}
  \item{...}{
Settings for default formatting.
}
}
\value{
Returns \code{x} invisibly, and prints the LaTeX script to the console.
}
\seealso{
\code{\link{print.tabular}}, \code{\link[Hmisc]{latex}}
}
\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
latex(tab)
}
