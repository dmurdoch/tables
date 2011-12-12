\name{RowFactor}
\alias{Factor}
\alias{RowFactor}
\title{
Use a variable as a factor to give rows in a table.
}
\description{
Both \code{Factor} and \code{RowFactor}
take a variable and treat it as a factor in a table.  \code{RowFactor} 
is designed for LaTeX output, adding
extra spacing to make the table more readable.
}
\usage{
Factor(x, name)
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
\value{
Language to insert into the table formula to achieve the desired table.
}
\examples{
tabular( Factor(1:10, "row") ~
       All(iris[1:10,])*Heading()*identity )
latex( tabular( RowFactor(1:10, "", 5)  ~ 
       All(iris[1:10,])*Heading()*identity )) 
}
