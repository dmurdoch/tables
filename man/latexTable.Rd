\name{latexTable}
\alias{latexTable}
\title{
Create table in full table environment
}
\description{
The \code{\link{tabular}} function creates a table which usually 
renders as a \verb{tabular} environment when displayed in LaTeX, 
not as a "float" with caption, label, etc.  This function
wraps the \code{\link{tabular}} result in the result of a call to the
\code{knitr::\link[knitr]{kable}} function.
}
\usage{
latexTable(table, format = "latex", longtable = FALSE, ...)
}
\arguments{
  \item{table}{
Either a formula to be passed to \code{\link{tabular}}, or the
result of a call to that function.
}
  \item{format}{
Currently only \code{"latex"} format output is supported.
}
  \item{longtable, \dots}{
Additional arguments to be passed to the \code{knitr::\link[knitr]{kable}}
function.  See details below.
}
}
\details{
Rather than redoing all the work of generating LaTeX code to wrap the
\code{\link{tabular}} result, this function works by generating a dummy
\code{\link[knitr]{kable}} table, and replaces the \verb{tabular} part
with the \code{\link{tabular}} result.

Many of the arguments to \code{\link[knitr]{kable}} deal with the
content of the table, not the wrapper.  These will be ignored with a
warning.  Currently the arguments that will not be ignored, with their
defaults, are:
\describe{
\item{\code{caption = NULL}}{The caption to use on the table.}
\item{\code{label = NULL}}{Part of the LaTeX label to use on the table.  The
full label will have \code{"tab:"} prepended by  \code{\link[knitr]{kable}}.}
\item{\code{escape = TRUE}}{Whether to escape special characters in the caption.}
\item{\code{booktabs = FALSE, longtable = FALSE}}{Logical values to indicate that style
of table.  These must also be specified to \code{\link{tabular}}; see
the main \href{../doc/index.html}{vignette} for details.}
\item{\code{position = ""}}{The instruction to LaTeX about how to position
the float in the document.}
\item{\code{centering = TRUE}}{Whether to center the table in the float.}
\item{\code{caption.short = ""}}{Abbreviated caption to use in TOC.}
\item{\code{table.envir = if (!is.null(caption)) "table"}}{Name of
outer environment.}
}
These arguments are all defined in the \pkg{knitr} package, and 
may change in the future.
}
\value{
An object of class \code{"knitr_kable"} suitable to include in a \code{\link{Sweave}} or \pkg{knitr} \file{.Rnw} document.
}

\examples{
cat(latexTable(tabular((Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris ),
    caption = "Iris sepal data", label = "sepals"))
}