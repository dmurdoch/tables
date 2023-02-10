\name{All}
\alias{All}
\title{
Include all columns of a dataframe.
}
\description{
This constructs a formula object for all the columns of a dataframe.
}
\usage{
All(df, numeric=TRUE, character=FALSE, logical=FALSE, factor=FALSE, 
        complex=FALSE, raw=FALSE, other=FALSE,
        texify=getOption("tables.texify", FALSE))
}
\arguments{
  \item{df}{
The dataframe in which to find the columns.
}
  \item{numeric, character, logical, factor, complex, raw}{
Whether to include columns of specified types.  See the Details below.
}
  \item{other}{
Whether to include columns that match none of the previous types.
}
  \item{texify}{
Whether to escape LaTeX special characters in column names.
}
}
\details{
This function constructs a formula from the columns of a dataframe.
By default, only numeric columns are included.  The arguments 
\code{numeric}, \code{character}, \code{logical}, \code{factor}, \code{complex}
and \code{raw} control the inclusion of columns of the corresponding types.  
The argument \code{other} controls inclusion of any other columns.

If these arguments are \code{TRUE}, such columns will be included in
the formula.

If a function (or the name of a function given as a character string)
is passed, such columns will be transformed by the function before
inclusion.  For example, \code{All(df, factor=as.character)} will
convert all factor columns into their character representation for
inclusion.

In other cases, the columns will be skipped.
}
\value{
Language to insert into the table formula to achieve the desired table.
}
\examples{
# Show mean and sd of all numeric columns in the iris data
tabular( Species  ~ 
       All(iris)*(mean + sd), data=iris )
}

