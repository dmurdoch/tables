\name{table_options}
\alias{table_options}
\alias{booktabs}
\alias{htmloptions}
\title{
Set or query options for the table formatting.
}
\description{
These functions set or query options for table formatting in LaTeX or HTML output.
}
\usage{
table_options(...)
booktabs(...)
htmloptions(head=TRUE, table=TRUE, pad=FALSE, 
            ...)
}
\arguments{
  \item{head}{logical; enables all of the HTML header options}
  \item{table}{logical; enables output of all parts of the table itself}
  \item{pad}{logical; enables all of the HTML padding options}
  \item{...}{
Any of the options listed in the Details below.
}  
}
\details{
The \code{table_options()} function sets a number of options that control formatting.  Currently the 
options that affect both LaTeX and HTML output are:
\describe{
  \item{\code{justification = "c"}}{
Default justification for the data columns in the table.
}
  \item{\code{rowlabeljustification = "l"}}{
Default justification for row labels.
}
  \item{\code{doBegin, doHeader, doBody, doFooter, doEnd}}{
These logical values (all defaults are \code{TRUE}) control the inclusion of specific parts of
the output table.}
}
These options are only used for LaTeX output:
\describe{
  \item{\code{tabular = "tabular"}}{
The LaTeX environment to use for the table.  Other choices such as \code{"longtable"} might
make sense.
}
  \item{\code{toprule, midrule, bottomrule}}{
The LaTeX macros to use for the lines in the table.  By default they are all \code{"\\hline"}.
}
  \item{\code{titlerule = NULL}}{
The LaTeX macro to use to underline multicolumn titles.  If \code{NULL}, no underlining
is done.  
}
  \item{\code{latexleftpad, latexrightpad, latexminus, mathmode}}{
These control formatting of numbers in the table.  If \code{TRUE} (the default), blanks
in \R's formatting are converted to hard spaces in the LaTeX output, and negative
signs are rendered properly.  Generally this makes output look better, but
the \file{.tex} input may be harder to read.
}
}
These options are only used for HTML output:
\describe{
\item{\code{doHTMLheader, doCSS, doHTMLbody}}{
These control output of the material at the top of an HTML page.
}
\item{\code{HTMLhead, CSS, HTMLbody}}{
These are the default strings to output when the corresponding element is selected.
If present, the string \code{"CHARSET"} will be replaced with the result of
\code{\link{localeToCharset}()} in the \code{HTMLhead}.  The string
\code{"#ID"} will be replaced with \code{"#"} followed by the \code{id}
argument to \code{\link{html.tabular}} (or removed if that is blank).
}
\item{\code{HTMLcaption}}{
This is an optional HTML caption for the table.  If \code{NULL}, no
caption is emitted.
}
\item{\code{HTMLleftpad, HTMLrightpad, HTMLminus}}{
These control formatting of numbers in the table.  If \code{TRUE}, blanks
in \R's formatting are converted to hard spaces in the HTML output, and negative
signs are rendered properly.  Generally this makes output look better, but 
cut and paste from the table may include these special characters
and not be recognized by other software.  The default is \code{FALSE}.
}
\item{\code{HTMLattributes}}{
This is a string to add to the \code{"<table>"} declaration at the top of the table.  By
default, the attributes are \code{'frame="hsides" rules="groups"'}.
These set horizontal rules on the top and bottom of the table and between the header,
body, and footer (if present).
}
\item{\code{HTMLfooter}}{
This is \code{NULL} for no footer, or HTML code to insert in the table.  Note
that in HTML the footer should be specified before the body of the table;
\code{\link{html.tabular}} will do this if both are written in the same call.
}
}
These may be set persistently by calling \code{table_options()}, or just for the duration
of the call by passing them in a list via \code{latex(options=list( ... ))}.  Additional 
\code{...} arguments to \code{latex} are passed to \code{\link{format}}.

The \code{booktabs()} function sets the \code{table_options()} values to different defaults, 
suitable for use with the \pkg{booktabs} LaTeX package.

The \code{htmloptions()} function constructs a list suitable for the \code{options}
argument to \code{\link{html.tabular}}, with grouping of options that
rarely differ from each other.

Note that any LaTeX code can be used in the rule options; for example, see
the \code{longtable} example in the vignette.  Material to go above the headers
goes into \code{toprule}, material between the headers and the body goes into \code{midrule},
and material at the bottom of the table goes into \code{bottomrule}.
}

\value{
\code{table_options()} and \code{booktabs()} return the previous settings.

\code{htmloptions()} returns a list of settings without changing the defaults.
}
\seealso{
\code{\link{latex.tabular}},  \code{\link{html.tabular}}
}
\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
latex(tab)
save <- booktabs()
latex(tab)
table_options(save)

\donttest{
f <- tempfile(fileext = ".html")
browseURL( html(tab, f, 
  options=htmloptions(HTMLcaption="Table of Iris Data",
                      pad = TRUE))$file )
}
}
