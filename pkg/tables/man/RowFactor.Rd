\name{RowFactor}
\alias{Factor}
\alias{RowFactor}
\alias{Multicolumn}
\title{
Use a variable as a factor to give rows in a table.
}
\description{
The functions take a variable and treat it as a factor in a table.
\code{RowFactor} is designed for LaTeX output, adding extra spacing to
make the table more readable.  \code{Multicolumn} also works only in
LaTeX, and displays the label in a style with the level on a line by
itself, spanning multiple columns.
}
\usage{
Factor(x, name, levelnames = levels(x), texify = TRUE)
RowFactor(x, name = deparse(substitute(x)), 
	  levelnames = levels(x), 
          spacing = 3, space = 1, suppressfirst = TRUE,
          nopagebreak = "\\\\nopagebreak ",
          texify = TRUE)
Multicolumn(x, name, levelnames = levels(x), 
            width=2, first=1, justify="l",
            texify = TRUE)
}
\arguments{
  \item{x}{
A variable to be treated as a factor.
}
  \item{name}{
The display name for the factor.
}
  \item{levelnames}{
The strings to use as levels of \code{x}.
}
  \item{texify}{
If \code{TRUE}, characters that would be interpreted specially by LaTeX 
are escaped (using \code{\link[Hmisc]{latexTranslate}}) so
they will print properly.
}
  \item{spacing}{
Extra spacing will be added before every \code{spacing} lines.
}
  \item{space}{
How much extra space to add, in \code{ex} units.
}
  \item{suppressfirst}{
Whether to suppress the spacing in the first group.
}
  \item{nopagebreak}{
LaTeX macro to insert to suppress page breaks except between groups.
}
  \item{width}{
How many columns should the label span?
}
  \item{first}{
Which is the first column in which this label appears?
}
  \item{justify}{
How should the label be justified in the columns?
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
