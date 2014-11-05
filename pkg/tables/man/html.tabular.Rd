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
\method{html}{tabular}(object, file = "", options = NULL, 
                       id = NULL, append = FALSE, ...)
}
\arguments{
  \item{object}{
The tabular object.
}
  \item{file}{
A filename or connection to which to write the HTML code, or
\code{""} to write to the standard output.
}
  \item{options}{
A list of options to set for the duration of the call.
}
  \item{id}{
A unique identifier to set for this table and the associated
CSS style, or \code{NULL}, for no id.
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
The \code{html()} method produces HTML output suitable for inclusion in an HTML page.

In HTML, it is mainly the CSS style sheet that determines the look of the table.  
When formatting a table, \code{html.tabular} sets the CSS class according to the
table's \code{Justify} setting; justifications of \code{c("l", "c", "r")} are
translated to classes \code{c("left", "center", "right")} respectively; other strings
will be passed through and used directly as class names.  
If the \code{id} value is not \code{NULL}, then it will be used
as the CSS id selector when searching for a style.
See \code{\link{table_options}} for a number of options that control formatting, including
the default style sheet.
}
\value{
The \code{html()} method writes the HTML code to \code{file} and returns a list containing 
that name, with class \code{"html"}.
}
\seealso{
\code{\link{print.tabular}}, \code{\link{latex.tabular}}, \code{\link[Hmisc]{html}}, \code{\link{htmloptions}}
}
\examples{
\donttest{
X <- rnorm(125, sd=100)
Group <- factor(sample(letters[1:5], 125, rep=TRUE))

tab <- tabular( Group ~ (N=1)+Format(digits=2)*X*((Mean=mean) + Heading("Std Dev")*sd) )

save <- table_options()
table_options(rowlabeljustification="c")

f <- tempfile(fileext=".html")
con <- file(f, "wt")

html(tab, con, options=htmloptions(head=TRUE, table=FALSE))

writeLines("<p>This table has pad = FALSE.  The centered numbers look
sloppy.<br>", con)

html(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=FALSE))

writeLines("<p>This table has pad = FALSE and justification=\"r\".
The justification makes the columns of numbers look all right (except
for the hyphens used as minus signs), but they are placed poorly
relative to the labels.<br>", con)

html(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=FALSE, justification="r"))

writeLines("<p>This one has pad = TRUE. It looks best, but if you cut
and paste, the spacing characters may cause problems.<br>", con)

html(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=TRUE))

table_options(save)
close(con)
browseURL(f)
}
}
