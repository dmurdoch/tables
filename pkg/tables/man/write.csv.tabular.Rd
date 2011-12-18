\name{write.csv.tabular}
\alias{write.csv.tabular}
\alias{write.table.tabular}
\title{
Write table to file in CSV or other format.
}
\description{
This writes the formatted table into a CSV or other delimeted
file, for import into a spreadsheet or other 
report writer.
}
\usage{
write.csv.tabular(x, file="", 
    justification = "n", row.names=FALSE, 
    write.options=list(), ...)
write.table.tabular(x, file="", 
    justification = "n", row.names=FALSE, col.names=FALSE,
    write.options=list(), ...)
}
\arguments{
  \item{x}{
An object from \code{\link{tabular}}.
}
  \item{file}{
A filename or connection to which to write.
}
  \item{justification, \dots}{
Parameters to pass to \code{\link{format.tabular}}.
}
  \item{row.names, col.names, write.options}{
Parameters to pass to \code{\link{write.csv}} or \code{\link{write.table}}
}
}
\details{
\code{write.csv.tabular} writes a simple version of the table (similar
to what is produced by \code{\link{print.tabular}}) to the given
connection in CSV format, using \code{\link{write.csv}}.
\code{write.table.tabular} does similarly using the more general
\code{\link{write.table}}.
}
\value{
The return value from \code{\link{write.csv}} or \code{\link{write.table}}.
}
\examples{
\dontrun{
# This writes a table to the clipboard on Windows

write.table.tabular( 
    tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris ),
    "clipboard", sep="\t")
}    
}    
    