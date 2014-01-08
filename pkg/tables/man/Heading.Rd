\name{Heading}
\alias{Heading}
\title{
\code{Heading} pseudo-function
}
\usage{
Heading(name = NULL, override = TRUE)
}
\arguments{
  \item{name}{
A legal R variable name, or a character constant.
}
  \item{override}{
Whether this heading should override one that is already present.
}
}

\description{
By default, the \code{Heading} pseudo-function overrides the automatic
heading on the following items in a table.  
}
\details{
This replaces the automatic heading or row label on the following item
with the \code{name} or string as specified.  If no argument
is given, the heading or label is suppressed.  

An alternative form of \code{Heading(name)} is \code{(name=...)}, where
\code{...} is an expression to be displayed in the table.

If \code{override = FALSE}, the label is only supplied if there is no other label.
This is used in the code for \code{\link{Factor}}.
}
\section{Pseudo-functions}{
This is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}.
}

\examples{
tabular( (Sepal.Length+Sepal.Width) ~ 
         (Heading(Mean)*mean + (S.D.=sd)), data=iris )
}
