\name{useGroupLabels}
\alias{useGroupLabels}
\title{
Format table with groups of lines
}
\description{
When a factor level applies to multiple lines in a table,
normally an extra column of row labels is added to 
show the levels.  This function merges that column
into another column in the labels.
}
\usage{
useGroupLabels(tab, col = 1, 
               indent = "  ", 
               newcolumn = 1,
               singleRow = TRUE,
               extraLines = 0)
}
\arguments{
  \item{tab}{
A tabular object.
}
  \item{col}{
Which column defines the groups?
}
  \item{indent}{
A prefix to add to existing entries in the new column.
}
  \item{newcolumn}{Which column gets the 
group headings?}
  \item{singleRow}{If a group has a single row
and there is no entry in \code{newcolumn} in that row,
put the group label in the same row rather than in
a separate row.}
  \item{extraLines}{Add this many blank lines to separate
the groups in addition to the line containing the group
label.}
}
\value{
A tabular object, modified to include header rows
as specified.
}
\details{
If \code{newcolumn} is less than 1 or greater than the 
number of row label columns (after removing column \code{col}), extra columns will be added.
}
\examples{
set.seed(123)
n <- 10
df <- data.frame(a = factor(sample(1:3, n, replace=TRUE)),
                 b = factor(sample(1:3, n, replace=TRUE)),
                 x = rnorm(n))
levels(df$a) <- c("Long name 1", "Long name 2", "Long name 3")
levels(df$b) <- c("a", "abc", "abcdef")
library(tables)
tab <- tabular(a*Heading()*b ~ mean*x, data = df)
tab <- tab[!is.na(tab[,1])]
useGroupLabels(tab)
}