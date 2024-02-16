\name{toTinytable}
\alias{toTinytable}
\title{
Convert \code{tabular} object to \code{tinytable} format.
}
\description{
Converts the output of the \code{\link{tabular}} and related
functions to a format consistent with the output of the
\code{\link[tinytable]{tt}} function, so that it can be 
customized using the \pkg{tinytable} package.
}
\usage{
toTinytable(table, ...)
}
\arguments{
  \item{table}{
An object of class \code{tabular}.
}
  \item{...}{
Additional arguments to pass to \code{\link[tinytable]{tt}}.
}
}
\value{
An object of class \code{tinytable}, suitable for passing
to functions in the \pkg{tinytable} package. These tables
can be exported to several formats, including LaTeX, HTML,
Markdown, Word, Typst, PDF, and PNG.
}

\seealso{
\code{\link[tinytable]{tinytable-package}} 
}
\examples{
if (requireNamespace("tinytable")) {

  tab <-  tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
          (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
  tab <- toTinytable(tab, theme = "striped")
  tab <- tinytable::style_tt(tab, i = 1:2, background = "teal", color = "white")
  tab

}

}
