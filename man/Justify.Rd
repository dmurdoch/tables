\name{Justify}
\alias{Justify}
\title{
\code{Justify} pseudo-function
}
\usage{
Justify(labels, data=labels)
}
\arguments{
  \item{labels}{
Justification to use for labels
}
  \item{data}{
Justification to use for data.
}
}

\description{
The \code{Justify} pseudo-function sets the justification
of the following items in the table.
}
\details{
The justification can be an R name if that is syntactically valid, 
or a quoted string.
}
\section{Pseudo-functions}{
This is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}.
}

\examples{
tabular( Justify(c,l)*Heading(Var)*(Sepal.Length+Sepal.Width) ~ 
         Justify(c)*(mean + sd), data=iris )
}
