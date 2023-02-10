\name{Literal}
\alias{Literal}
\title{
Insert a literal entry into a table margin.
}
\description{
This allows insertion of arbitrary LaTeX text into a table.
}
\usage{
Literal(x, nearData = TRUE)
}
\arguments{
  \item{x}{
A character string to insert.
}
  \item{nearData}{
See the Details section of \code{\link{Heading}}.
}
}
\details{
In LaTeX the \code{literal} string should usually end with a \code{\%} comment
character to avoid having a blank line inserted.
}
\value{
Produces an expression to insert a label containing the literal text.
}
\seealso{
\code{\link{Hline}}, which uses this to insert lines.
}
\examples{
tabular( (Literal("Some text") + Species)  ~ 
       All(iris)*mean, data=iris )
}
