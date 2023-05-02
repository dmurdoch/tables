\name{HTMLfootnotes}
\alias{HTMLfootnotes}
\title{
Construct footnotes
}
\description{
This function constructs HTML code for footnotes
to insert at the bottom of the table.
}
\usage{
HTMLfootnotes(tab, ...)
}
\arguments{
  \item{tab}{
A tabular object, used only so
that the column width of the footnotes matches.
}
  \item{\dots}{
The footnotes.  If named, will be preceded with the
name as a superscript.
}
}
\value{
A character string containing HTML code for the
footnotes.  Use this in \code{\link{table_options}(HTMLfooter = ...)}
}

\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
footnote <- HTMLfootnotes(tab, 
                          "This is a footnote with no marker.", 
                          "*" = "This is a footnote with an asterisk.")
if (interactive())
  toHTML(tab, options = list(doFooter = TRUE,
                           HTMLfooter = footnote))
}
