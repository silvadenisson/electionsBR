% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/voter_profile.R
\name{voter_profile}
\alias{voter_profile}
\title{Download data on the voters' profile}
\usage{
voter_profile(year, ascii = FALSE, encoding = "windows-1252")
}
\arguments{
\item{year}{Election year (\code{integer}). For this function, the following years are available: 1994, 1996, 1998,
2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014 and 2016.}

\item{ascii}{(\code{logical}). Should the text be transformed from Latin-1 to ASCII format?}

\item{encoding}{Data original encoding (defaults to 'windows-1252'). This can be changed to avoid errors
when \code{ascii = TRUE}.}
}
\value{
\code{voter_profile()} returns a \code{data.frame} with the following variables:

\itemize{
  \item PERIODO: Election year.
  \item UF: Units of the Federation's acronym in which occurred the election.
  \item MUNICIPIO: Municipality name.
  \item COD_MUNICIPIO_TSE: Municipal's Supreme Electoral Court code (number).
  \item NR_ZONA: Electoral zone's Supreme Electoral Court code (number).
  \item SEXO: Voters' sex.
  \item FAIXA_ETARIA: Voters' age group.
  \item GRAU_DE_ESCOLARIDADE: Voters' education degree.
  \item QTD_ELEITORES_NO_PERFIL: Absolute number of voters.
}
}
\description{
\code{voter_profile()} downloads and cleans data on the voters' profile aggregated by state, city and electoral zone.
The function returns a \code{data.frame} where each observation corresponds to a voter profile type.
}
\examples{
\dontrun{
df <- voter_profile(2002)
}
}
