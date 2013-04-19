\name{html.tabular}
\alias{html.tabular}
\title{
Display a tabular object using HTML.
}
\description{
This is similar to \code{\link{print.tabular}}, but it inserts the code to
display the table in an HTML table.
}
\usage{
\method{html}{tabular}(object, file="", options=NULL, id="", ...)
}
\arguments{
  \item{object}{
The tabular object.
}
  \item{file}{
A filename to which to write the HTML code.
}
  \item{options}{
A list of options to set for the duration of the call.
}
  \item{id}{
A unique identifier to set for this table (and if chosen, the associated
CSS style)
}
  \item{...}{
Settings for default formatting.  See Details below.
}  
}
\details{
The \code{html()} method produces HTML output suitable for inclusion in an \code{\link{HTML}} page.

See \code{\link{table_options}} for a number of options that control formatting. 

}
\value{
The \code{html()} method writes the HTML code to \code{file} and returns a list containing 
that name, with class \code{"html"}.
}
\seealso{
\code{\link{print.tabular}}, \code{\link{latex.tabular}}, \code{\link[Hmisc]{html}}, \code{\link{htmloptions}}
}
\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )

save <- table_options()
f <- tempfile(fileext=".html")
con <- file(f, "wt")

html(tab, con, options=htmloptions(head=TRUE, table=FALSE))

writeLines("<br>This table has pad=FALSE:<br>", con)
html(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=FALSE))

writeLines("<br>This one has pad=TRUE.  It looks better, but if you cut and 
paste, the spacing characters may cause problems:<br>", con)
html(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=TRUE))

table_options(save)
close(con)
browseURL(f)

}
