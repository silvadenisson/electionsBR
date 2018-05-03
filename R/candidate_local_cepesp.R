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
#' @param export (\code{logical}). Should the downloaded data be saved in .dta and .sav in the current directory?
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
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

candidate_local_cepesp <- function(position, year){
  
  test_local_possition(position)
  test_local_year(year)
  
  message("Processing the data...")
  dados <-  GET(paste0("http://cepesp.io/api/consulta/candidatos?ano=", year ,"2014&cargo=",
                       replace_position_cod(position))
  
  dados = content(dados)
  
  message("Done.\n")
  return(dados)
  
}
