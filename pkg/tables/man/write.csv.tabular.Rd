\name{write.csv.tabular}
\alias{write.csv.tabular}
\title{
Write table to CSV file
}
\description{
This writes the formatted table into a CSV file, for import into a spreadsheet or other 
report writer.
}
\usage{
write.csv.tabular(x, file = "", justification = "n", ...)
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
}
\details{
This writes a simple version of the table (similar to what is produced by \code{\link{print.tabular}})
to the given connection in CSV format.  
}
\value{
The return value from \code{\link{write.csv}}.
}
\examples{
\dontrun{
# This writes a table to the clipboard on Windows

write.csv.tabular( 
    tabular( (Species + 1) ~ (n=1) + Format(digits=2)*
         (Sepal.Length + Sepal.Width)*(mean + sd), data=iris ),
    "clipboard")
}    
}    
    