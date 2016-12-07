#' Download data on the voters' profile
#'
#' \code{voter_profile()} downloads and cleans data on the voters' profile aggregated by state, city and electoral zone.
#' The function returns a \code{data.frame} where each observation corresponds to a voter profile type.
#'
#' @param year Election year (\code{integer}). For this function, the following years are available: 1994, 1996, 1998,
#' 2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014 and 2016.
#' 
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'windows-1252'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#'
#' @return \code{voter_profile()} returns a \code{data.frame} with the following variables:
#'
#' \itemize{
#'   \item PERIODO: Election year.
#'   \item UF: Units of the Federation's acronym in which occurred the election.
#'   \item MUNICIPIO: Municipality name.
#'   \item COD_MUNICIPIO_TSE: Municipal's Supreme Electoral Court code (number).
#'   \item NR_ZONA: Electoral zone's Supreme Electoral Court code (number).
#'   \item SEXO: Voters' sex.
#'   \item FAIXA_ETARIA: Voters' age group.
#'   \item GRAU_DE_ESCOLARIDADE: Voters' education degree.
#'   \item QTD_ELEITORES_NO_PERFIL: Absolute number of voters.
#' }
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- voter_profile(2002)
#' }

voter_profile <- function(year, ascii = FALSE, encoding = "windows-1252"){
  
  
  # Inputs
  if(!year %in% seq(1994, 2016, by = 2)) stop("Invalid 'year'. Please check the documentation and try again.")
  test_encoding(encoding)
  
  # Download data
  dados <- tempfile()
  local <- tempdir()
  sprintf("http://agencia.tse.jus.br/estatistica/sead/odsele/perfil_eleitorado/perfil_eleitorado_%s.zip", year) %>%
    download.file(dados)
  unzip(dados, exdir = local)
  unlink(dados)
  
  # Join data
  message("Processing the data...")
  
  orig <- getwd()
  setwd(local)
  banco <- Sys.glob("*.txt") %>%
    read.table(header = F, sep = ";", stringsAsFactors = F, fill = T, fileEncoding =  encoding)
  
  setwd(orig)
  
  # Change variable names
  names(banco) <- c("PERIODO", "UF", "MUNICIPIO", "COD_MUNICIPIO_TSE", "NR_ZONA",
                    "SEXO", "FAIXA_ETARIA", "GRAU_DE_ESCOLARIDADE", "QTD_ELEITORES_NO_PERFIL")
  
  # Change to ascii
  if(ascii) banco <- to_ascii(banco, encoding)
  
  message("Done.\n")
  banco
}

