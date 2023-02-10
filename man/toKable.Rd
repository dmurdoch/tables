\name{toKable}
\alias{toKable}
\alias{getKnitrFormat}
\title{
Convert \code{tabular} object to \code{knitr_kable} format.
}
\description{
Converts the output of the \code{\link{tabular}} and related
functions to a format consistent with the output of the
\code{\link[knitr]{kable}} function, so that it can be 
customized using the \pkg{kableExtra} package.
}
\usage{
toKable(table, format = getKnitrFormat(), booktabs = TRUE, ...)
getKnitrFormat(default = "latex")
}
\arguments{
  \item{table}{
An object of class \code{tabular}.
}
  \item{format}{
The type of \code{knitr_kable} object desired; currently
only \code{"latex"} and \code{"html"} are supported.
}
  \item{booktabs}{
Should the table be rendered in \code{\link{booktabs}} style?
This only affects LaTeX output.
}
  \item{...}{
Additional arguments to pass to \code{\link{html.tabular}} or \code{\link{latex.tabular}}.
}
  \item{default}{
The default type of output if not running in a \pkg{knitr}
document.
}
}
\value{
An object of class \code{knitr_kable}, suitable for passing
to functions in the \pkg{kableExtra} package.
}

\seealso{
\code{\link[kableExtra]{kableExtra-package}} 
}
\examples{
if (requireNamespace("kableExtra")) {
  tab <-  tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
          (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
  print(kableExtra::kable_styling(toKable(tab), latex_options = "striped"))
  cat("\n")
  toKable(tab, format = "html", options = list(HTMLcaption = "Fisher's iris data"))
}
}
