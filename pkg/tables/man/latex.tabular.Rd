\name{latex.tabular}
\alias{latex.tabular}
\alias{table_options}
\alias{booktabs}
\title{
Display a tabular object using LaTeX.
}
\description{
This is similar to \code{\link{print.tabular}}, but it inserts the code to
display the table in a LaTeX tabular environment.
}
\usage{
\method{latex}{tabular}(object, file="", options=NULL, ...)
table_options(...)
booktabs(...)
}
\arguments{
  \item{object}{
The tabular object.
}
  \item{file}{
A filename to which to write the LaTeX code.
}
  \item{options}{
A list of options to set for the duration of the call.
}
  \item{...}{
Settings for default formatting.  See Details below.
}  
}
\details{
The \code{latex()} method produces LaTeX output suitable for inclusion in a \code{\link{Sweave}} document.

The \code{table_options()} function sets a number of options that control formatting.  Currently the 
options are:
\describe{
  \item{\code{justification = "c"}}{
Default justification for the data columns in the table.
}
  \item{\code{rowlabeljustification}}{
Default justification for row labels.
}
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
  \item{\code{doBegin, doHeader, doBody, doFooter, doEnd}}{
These logical values (all defaults are \code{TRUE}) control the inclusion of specific parts of
the output table.
}
}
These may be set persistently by calling \code{table_options()}, or just for the duration
of the call by passing them in a list via \code{latex(options=list( ... ))}.  Additional 
\code{...} arguments to \code{latex} are passed to \code{\link{format}}.

The \code{booktabs()} function sets the \code{table_options()} values to different defaults, 
suitable for use with the \pkg{booktabs} LaTeX package.

Note that any LaTeX code can be used in the rule options; for example, see
the \code{longtable} example in the vignette.  Material to go above the headers
goes into \code{toprule}, material between the headers and the body goes into \code{midrule},
and material at the bottom of the table goes into \code{bottomrule}.
}
\value{
The \code{latex()} method returns \code{x} invisibly, and prints the LaTeX script to the console.

\code{table_options()} and \code{booktabs()} return the previous settings.
}
\seealso{
\code{\link{print.tabular}}, \code{\link[Hmisc]{latex}}
}
\examples{
tab <- tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )
latex(tab)
save <- booktabs()
latex(tab)
table_options(save)
}
