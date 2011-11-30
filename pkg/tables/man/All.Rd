\name{All}
\alias{All}
\title{
Include all columns of a dataframe.
}
\description{
This constructs a formula object for all the columns of a dataframe.
}
\usage{
All(df, factorsAsStrings = TRUE)
}
\arguments{
  \item{df}{
The dataframe in which to find the columns.
}
  \item{factorsAsStrings}{
Whether to convert factors to character vectors for display.
}
}
\value{
Language to insert into the table formula to achieve the desired table.
}
\examples{
tabular( Species  ~ 
       All(iris)*(min + max), data=iris )
}

