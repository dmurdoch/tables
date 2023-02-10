\name{Heading}
\alias{Heading}
\title{
\code{Heading} pseudo-function
}
\usage{
Heading(name = NULL, override = TRUE, character.only = FALSE, nearData = TRUE)
}
\arguments{
  \item{name}{
A legal R variable name, or a character constant.
}
  \item{override}{
Whether this heading should override one that is already present.
}
  \item{character.only}{
If \code{TRUE}, the \code{name} argument will be interpreted
as an expression evaluating to a character value.
}
  \item{nearData}{
See Details below.
}
}

\description{
The \code{Heading} pseudo-function normally overrides the automatic
heading on the following items in a table.  Setting 
\code{override=FALSE} is used in automatically 
generated expressions.
}
\details{
This replaces the automatic heading or row label on the following item
with the \code{name} or string as specified.  If no argument
is given, the heading or label is suppressed.  

An alternative form of \code{Heading(name)} is \code{(name=...)}, where
\code{...} is an expression to be displayed in the table.

If \code{override = FALSE}, the label is only supplied if there is no other label.
This is used in the code for \code{\link{Factor}}.

The \code{nearData} argument is rarely used.  It
affects the situation where \code{"+"} is used to
join tables with different numbers of labels.  
If \code{nearData = TRUE} (the default), the shorter
list of labels are pushed close to the data, i.e.
to the right side for row labels, the bottom for
column labels.  If \code{FALSE}, they are pushed
to the opposite side.
}
\section{Pseudo-functions}{
This is a \dQuote{pseudo-function}:  it takes the form of a function call, but is
never actually called:  it is 
handled specially by \code{\link{tabular}}.
}

\examples{
tabular( (Sepal.Length+Sepal.Width) ~ 
         (Heading(Mean)*mean + (S.D.=sd)), data=iris )

heading <- "Variable Heading"
tabular( (Sepal.Length+Sepal.Width) ~ 
         (Heading(heading, character.only = TRUE)*mean + (S.D.=sd)), 
         data=iris )
}
