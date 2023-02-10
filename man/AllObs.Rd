\name{AllObs}
\alias{AllObs}
\alias{RowNum}
\title{
Display all observations in a table.
}
\description{
These functions generate the code for a \code{\link{tabular}} table
to include all observations in a dataset, possibly divided up according
to other factors.
}
\usage{
AllObs(data = NULL, show = FALSE, label = "Obsn.", within = NULL)
RowNum(within = NULL, perrow = 5, show = FALSE, label = "Row", data = NULL)
}
\arguments{
  \item{data}{
The full dataset, used only to find the number of observations.
}
  \item{show}{
Whether to show the observation number or row number in the table.
}
  \item{label}{
The label to use when \code{show = TRUE}.
}
  \item{within}{
A factor or list of factors by which to break up the observations.
}
  \item{perrow}{
How many observations per row when \code{RowNum} is used in 
the row specification, or per column when it is part of the
column specification.
}
}
\details{
\code{AllObs} is used to display all of the observations in a dataset.
It generates a (usually undisplayed) factor with a different level for each observation,
sets a function to display the value, and calls \code{\link{DropEmpty}}
to suppress display of empty rows, columns or cells.

If the \code{within} argument is specified in \code{AllObs}, the 
factor levels are restarted within each grouping.  (\code{within}
is interpreted as the \code{INDEX} argument of \code{\link{tapply}},
with one exception described below.)  This may be useful when
displaying the observation number, and is definitely useful
if \code{AllObs} is used as a column specification in the table.
It will also save some computation time if the table is very
large, since fewer factor levels will be generated and 
later dropped.

\code{RowNum} is unlikely to be useful in a table by itself,
but is helpful when displaying large datasets with \code{AllObs}.
It allows a large number of observations to be broken into
several rows and columns.  

Because \code{RowNum} affects both rows and
columns, its use is somewhat unusual.  Normally it should be called
before calling \code{\link{tabular}}, and its result saved in a
variable.  That variable (e.g. \code{rownum}) is used in the
row specification for the table wrapped in \code{\link{I}()}, and
in the column specification of the table in the \code{within}
argument to \code{AllObs}.  (This is the exception mentioned above.)

Despite its name, \code{RowNum} can be used as a column specifier,
if you'd prefer column-major ordering of the values displayed 
in the table.
}
\value{
Both \code{AllObs} and \code{RowNum} return language objects
to be used on \code{\link{tabular}} formulas.
}

\seealso{
\code{\link{tabular}}, \code{\link{DropEmpty}}
}
\examples{
tabular(Factor(cyl)*Factor(gear)*AllObs(mtcars) ~ 
               rownames(mtcars) + mpg, data=mtcars)
    
rownum <- with(mtcars, RowNum(list(cyl, gear)))
tabular(Factor(cyl)*Factor(gear)*I(rownum) ~
        mpg * AllObs(mtcars, within = list(cyl, gear, rownum)), 
        data=mtcars)
}