% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ldapErrorParser.R
\name{ldapErrorParser}
\alias{ldapErrorParser}
\title{ldapErrorParser}
\usage{
ldapErrorParser(status)
}
\arguments{
\item{status}{An error code returned by the loginLdap function}
}
\value{
A human readable string describing the error code.
}
\description{
Returns a human readable string describing the error code.
}
\examples{
result <- loginLdap("user", "pass")
    message(ldapErrorParser(result$status))
}
