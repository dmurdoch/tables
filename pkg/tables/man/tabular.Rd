\name{tabular}
\alias{tabular}
\alias{tabular.default}
\alias{tabular.formula}
\alias{print.tabular}
\alias{format.tabular}
\alias{[.tabular}
\alias{cbind.tabular}
\alias{rbind.tabular}
\title{
Compute complex table
}
\description{
Computes a table of summary statistics, cross-classified by various variables.
}
\usage{
tabular(table, ...)
\method{tabular}{default}(table, ...)
\method{tabular}{formula}(table, data = NULL, n, suppressLabels = 0, ...)
\method{print}{tabular}(x, justification="n", ...)
\method{format}{tabular}(x, digits=4, justification="n", latex=FALSE, html=FALSE, 
                         leftpad = TRUE, rightpad = TRUE, minus = TRUE, 
			 mathmode = TRUE, ...)
\method{[}{tabular}(x, i, j, ..., drop=FALSE)
\method{cbind}{tabular}(..., deparse.level = 1)
\method{rbind}{tabular}(..., deparse.level = 1)
}
\arguments{
  \item{table}{
A table expression.  See the Details below.
}
  \item{data}{
An optional dataframe, list or environment in which to look for variables in the table.
}
  \item{n}{
An optional value giving the length of the data.  See the Details below.
}
  \item{suppressLabels}{
How many initial labels to suppress?
}
  \item{x}{ 
The object to print, format, or subset.
}
  \item{digits, ...}{
In the print and format methods, how many significant digits or other parameters to show by default?  See
Formatting below.
}
  \item{justification}{
The default justification to use in the table.
}
  \item{latex}{
If \code{TRUE}, the \code{\link{latexNumeric}} function will be applied when formatting
numeric columns after \code{\link{format}}, to maintain spacing and handle signs properly.
}
  \item{html}{
If \code{TRUE}, the \code{\link{htmlNumeric}} function will be applied when formatting
numeric columns after \code{\link{format}}, to maintain spacing and handle signs properly.
}
  \item{leftpad, rightpad, minus, mathmode}{
Options to pass to \code{\link{latexNumeric}} or \code{\link{htmlNumeric}} to
control details of formatting.  See those pages for details.
}
  \item{i, j, drop}{
The usual arguments for matrix indexing, but see the Details below.
}
  \item{deparse.level}{
Ignored.  (Present because the generic requires it.)
}

}
\details{
For the purposes of this function, a "table" is a rectangular array of values, computed
using a formula expression.  The left hand side of the formula describes the rows
of the table, the right hand side describes the columns.

Within the expression for the rows or columns, the operators \code{+}, \code{*}
and \code{=} have special meanings.  

The \code{+} operator represents concatenation, so that \code{x + y ~ z} says to
show the rows corresponding to \code{x} above the rows corresponding to \code{y}.

The \code{*} operator represents nesting, so that \code{x*y ~ z} says to
show the rows of \code{y} within each row corresponding to \code{x}.

The \code{=} operator sets a new name for a term; it is an abbreviation
for the \code{Heading()} pseudo-function.  (\dQuote{Pseudo-functions} are
described in the \code{tables} vignette.)  Note that
\code{=} has low operator precedence and may be confused by the parser
with setting function arguments, so parentheses are usually needed.

Parentheses may be used to group terms in the usual arithmetic way, so 
\code{(x + y)*(u + v)} is equivalent to \code{x*u + x*v + y*u + y*v}.

The names \code{Format}, \code{.Format}
and \code{Heading} have special meaning; see the section on Formatting below.

The interpretation of other terms in the formulas depends on how they evaluate.  

If the term evaluates to a function, it should be a summary function that 
produces a scalar value when applied to a vector of values, and that scalar will be displayed
in the table.  For example, \code{ (mean + var) ~ x } will display the mean of
\code{x} above the variance of \code{x}.  If no function is specified, \code{length}
is assumed, so the table will display counts.  (At most one summary function may
be specified in any one term, so \code{mean*var} would be an error.)

If the term evaluates to a logical vector, it is assumed to specify a subset.  For example,
\code{ ~ (x > 3) + (x > 5)} will tabulate the counts of those two subsets.  

If the term evaluates to a factor, it generates multiple rows or columns, corresponding
to the different levels of the factor.  For example if \code{A} has three levels, then
\code{A ~ mean*x} will calculate the mean of \code{x} within each level of \code{A}.

If the term evaluates to a language object, it is treated as a macro, and expanded 
in place in the formula.

Other terms are assumed to be R expressions producing a vector of values to be
summarized in the table.  Only one vector of values can be specified in any given term,
but different terms can summarize different values.  \code{\link{is.atomic}} must 
evaluate to \code{TRUE} for these values for them to be recognized.

All logical, factor or other values in the table should be the same length, as if
they were columns in a dataframe (but they can be computed values).  If \code{n} is
missing but \code{data} is a dataframe, \code{n} is set from that.  Otherwise, if terms such
as \code{1} appear in a table, the length is assumed to be the same as for previous terms.
As a last resort, set the \code{n} argument in the call to \code{tabular()} explicitly.

The \code{"["} method extracts a subset of the table.
For indexing, consider the table to consist of a matrix containing the values.
If \code{drop=TRUE}, the labels and attributes are dropped.  If \code{drop=FALSE},
the default, the \code{i} and \code{j} indices must select 
a rectangular block of the table; matrix indexing (using a two column
matrix or a full matrix of logical values) is not supported.

}

\section{Formatting}{
The \code{tabular()} function does no formatting of computed values, but 
it records requests for formatting.
The \code{format.tabular()}, \code{print.tabular()} and \code{latex.tabular()} 
functions make use of these requests.

By default, columns are formatted using the \code{\link{format}} function, with
arguments \code{digits} and any other arguments passed in \code{...}.  Each
column is formatted separately, similarly to how a matrix is printed by default.

To request special formatting, four pseudo-functions are provided.  The first is
\code{Format}.  Normally it includes arguments to pass to the \code{format()}
function, e.g. \code{Format(digits=2)}.  It may instead include
a call to a function, e.g. \code{Format(sprintf("\%.2f")}.  In either case
the summary values from
cells in the table that are nested below the \code{Format} specification
will be passed to that function in an argument named \code{x}, i.e. in the first
example, the values would be formatted using \code{format(digits=2, x=values)}, 
and in the second, using \code{sprintf("\%.2f", x=values)}.  Users can supply
their own function to be used for formatting; it should take values in a named
argument \code{x} and return a character vector of the same length.

This can be used to control formatting in multiple columns at once.  For example,
\code{Format(digits=2)*(mean + sd)} will print both the mean and standard deviation
in a single call to \code{\link{format}}, guaranteeing that the same number of decimal
places is used in both.  (The \code{iris} example below demonstrates this.)

If the \code{latex} argument to \code{latex.tabular} is \code{TRUE}, then 
an effort is made to retain spacing, and to convert minus signs to the 
appropriate type of dash using the \code{\link{latexNumeric}} function. 

The second pseudo-function \code{.Format} is mainly intended for internal use.  It
takes a single integer argument, saying that data governed by this call uses the
same formatting as another format specification.  In this way entries can be
commonly formatted even when they are not contiguous.  The integers are assigned
sequentially as the format specification is parsed; users will likely need
trial and error to find the right value in a complicated table with multiple formats.

A third pseudo-function is \code{Justify}.  It takes character values or names as arguments;
how they are treated depends on the output format.  In \code{format.tabular}, coarse
justification is done to left, right or center, using \code{l}, \code{r} or \code{c}
respectively.
For LaTeX formatting, any string acceptable as a justification
string to LaTeX will be passed on.

A final pseudo-function is \code{Heading}.  Use this function in the
row definitions to set a heading on the following column of row
labels.  (Internally this is how the headings on factor columns are
implemented.) If it is called with no argument, it suppresses the
following heading.  The \code{suppressLabels=n} argument to
\code{tabular()} is equivalent to repeating \code{Heading()} \code{n}
times at the start of the table formula.  The \code{=} operator is an
abbreviation for \code{Heading()}; see above.
}
\section{\code{tabular} methods}{
The default \code{tabular} method just applies \code{\link{as.formula}} to
\code{table}, and then calls \code{tabular.formula}.

The \code{tabular.formula} method is the main workhorse of the
package.  Other authors who wish to produce tables directly from their
own structures should normally create a formula whose environment
contains all mentioned variables and call \code{tabular.formula} with
appropriate arguments. 
}
\value{
An object of S3 class \code{"tabular"}.  This is a matrix of mode list,
whose entries are computed summary values, with the following attributes:
\item{rowLabels}{A matrix of labels for the rows.  This will have the same number of rows
as the main matrix, but may have multiple columns for different nested levels of labels.
If a label covers multiple rows, it is entered in the first row, and \code{NA} is used to
fill following rows.}
\item{colLabels}{Like \code{rowLabels}, but labelling the columns.}
\item{table}{The original table expression being displayed.  A list of the original
format specifications are attached as a \code{"fmtlist"} attribute.}
\item{formats}{A matrix of the same shape as the main result, containing \code{NA}
for default formatting, or an index into the format list.}
}
\references{
This function was inspired by my 20 year old memories of the SAS TABULATE procedure.
}
\author{
Duncan Murdoch
}
\seealso{
\code{\link{table}} and \code{\link{ftable}} are base R functions which produce
tables of counts.  The \code{tables} vignette has many more examples and displays the
formatted output.
}
\examples{
tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris )

# This example shows some of the less common options         
Sex <- factor(sample(c("Male", "Female"), 100, rep=TRUE))
Status <- factor(sample(c("low", "medium", "high"), 100, rep=TRUE))
z <- rnorm(100)+5
fmt <- function(x) {
  s <- format(x, digits=2)
  even <- ((1:length(s)) \%\% 2) == 0
  s[even] <- sprintf("(\%s)", s[even])
  s
}
tab <- tabular( Justify(c)*Heading()*z*Sex*Heading(Statistic)*Format(fmt())*(mean+sd) 
                ~ Status )
tab
tab[1:2, c(2,3,1)]
}
