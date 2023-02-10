\name{html.tabular}
\alias{html.tabular}
\alias{toHTML}
\alias{writeCSS}
\title{
Display a tabular object using HTML.
}
\description{
This is similar to \code{\link{print.tabular}}, but it inserts the code to
display the table in an HTML table.
}
\usage{
toHTML(object, file = "", options = NULL, 
                       id = NULL, append = FALSE, 
                       browsable = TRUE, ...)
html.tabular(object, ...)
writeCSS(CSS = htmloptions()$CSS, id = NULL)
}
\arguments{
  \item{object}{
The tabular object.
}
  \item{file}{
A filename or connection to which to write the HTML code, or
\code{""} to write to the console.
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
  \item{browsable}{
Should the output be marked as browsable?  
}
  \item{...}{
Settings for default formatting.  See Details below.
}  
  \item{CSS}{
A character vector to use as CSS.
}
}
\details{
The \code{toHTML()} function produces HTML output suitable for inclusion in an HTML page.

The \code{html.tabular} function is set up
to work as a method for the \code{html} generic in \pkg{Hmisc},
but is not registered as a method, so that \pkg{tables} can
work when \pkg{Hmisc} is not installed.

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
If \code{file = ""} (the default), the \code{toHTML()}
function creates an HTML object using the
\code{htmltools::HTML} function and returns it. 
If \code{file} is a character value or a connection, the results are written there and the HTML object is returned
invisibly.
}
\seealso{
\code{\link{print.tabular}}, \code{\link{toLatex.tabular}}, \code{\link[Hmisc]{html}}, \code{\link{htmloptions}}
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

toHTML(tab, con, options=htmloptions(head=TRUE, table=FALSE))

writeLines("<p>This table has pad = FALSE.  The centered numbers look
sloppy.<br>", con)

toHTML(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=FALSE))

writeLines("<p>This table has pad = FALSE and justification=\"r\".
The justification makes the columns of numbers look all right (except
for the hyphens used as minus signs), but they are placed poorly
relative to the labels.<br>", con)

toHTML(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=FALSE, justification="r"))

writeLines("<p>This one has pad = TRUE. It looks best, but if you cut
and paste, the spacing characters may cause problems.<br>", con)

toHTML(tab, con, options=htmloptions(head=FALSE, table=TRUE, pad=TRUE))

table_options(save)
close(con)
browseURL(f)
}
}
