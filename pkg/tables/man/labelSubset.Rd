\name{labelSubset}
\alias{labelSubset}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Add a label to a logical vector.
}
\description{
This function is mainly for internal use.  It adds a label to 
a logical vector, so that the \code{\link{Percent}} pseudo-function
can ignore it when forming a denominator.
}
\usage{
labelSubset(subset, label)
}
\arguments{
  \item{subset}{
A logical vector describing a subset of the dataset.
}
  \item{label}{
A character label to use to describe this subset in a call
to \code{Equal} or \code{Unequal} within \code{\link{Percent}}.
}
}
\value{
A vector of class \code{"labelledSubset"} with the label 
recorded as an attribute.
}
\author{
Duncan Murdoch
}
\seealso{
\code{\link{Percent}}
}
