\name{knit_print.tabular}
\alias{knit_print.tabular}
\title{
Custom printing of \code{tabular} objects.
}
\description{
Automatically print \code{tabular} objects with formatting when
in a \pkg{knitr} document.
}
\usage{
\S3method{knit_print}{tabular}(x, format = getKnitrFormat(), ...)
}
\arguments{
  \item{x}{
A \code{tabular} object.
}
  \item{format}{
Which output format?  \code{"latex"} and \code{"html"} are supported.
}
  \item{\dots}{
Other parameters, currently ignored.
}
}
\details{
This function is not normally called by a user.  It is designed to
be called by \pkg{knitr} while processing a \file{.Rmd} or \file{.Rnw} document.

If \code{table_options()$knit_print} is \code{TRUE} and the output
format is supported, this method will prepare output suitable for
formatted printing in a \pkg{knitr} document using \code{\link{asis_output}}.  Otherwise,
the usual unformatted print display will be done by \code{\link{normal_print}}.
}
\value{
An object marked for printing in a \pkg{knitr} document.
}
\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
knitr::knit_print(tab)
}
