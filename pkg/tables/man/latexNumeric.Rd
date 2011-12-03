\name{latexNumeric}
\alias{latexNumeric}
\title{
Process numeric LaTeX values.
}
\description{
This takes formatted strings as produced by \code{\link{format}} from numeric
values, and modifies them to LaTeX code that retains the spacing, and renders
minus signs properly.  The default formatting in \code{\link{tabular}}
uses this to maintain proper alignment.
}
\usage{
latexNumeric(chars, minus = TRUE, leftpad = TRUE, rightpad = TRUE, mathmode = TRUE)
}
\arguments{
  \item{chars}{
A character vector of numeric values.
}
  \item{minus}{
Whether to pad cases with no minus sign with spacing of the same width.
}
  \item{leftpad,rightpad}{
Whether to pad cases that have leading or trailing blanks with spacing matching a digit width per space.
}
  \item{mathmode}{
Whether to wrap the result in dollar signs, so LaTeX renders minus signs properly.
}
}
\value{
A character vector of the same length as \code{chars}, with modifications
to render properly in LaTeX.
}
\examples{
latexNumeric(format(c(1.1,-1,10,-10)))
}
