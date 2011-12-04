\name{RowFactor}
\alias{RowFactor}
\title{
Use a variable as a factor to give rows in a table.
}
\description{
This takes a variable and treats it as a factor in a table.  It adds
extra spacing to make the table more readable.
}
\usage{
RowFactor(x, name = deparse(substitute(x)), spacing = 3, space = 1,
          nopagebreak = "\\\\nopagebreak ")
}
\arguments{
  \item{x}{
A variable to be treated as a factor.
}
  \item{name}{
The display name for the factor.
}
  \item{spacing}{
Extra spacing will be added after every \code{spacing} lines.
}
  \item{space}{
How much extra space to add, in \code{ex} units.
}
  \item{nopagebreak}{
LaTeX macro to insert to suppress page breaks except between groups.
}
}
\details{
This function is only useful for LaTeX output.
}
\value{
Language to insert into the table formula to achieve the desired table.
}
\examples{
latex( tabular( RowFactor(1:10, "", 5)  ~ 
       All(iris[1:10,])*Heading()*identity )) 
}
