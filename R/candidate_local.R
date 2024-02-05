#' Download data on the candidates' background in local elections
#'
#' \code{candidate_local()} downloads and aggregates the data on the candidates' background who vied
#' local elections in Brazil. The function returns a \code{data.frame} where each observation
#' corresponds to a candidate.
#'
#' @note For the elections prior to 2000, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years of 1996, 2000, 2004, 2008, 2012, 2016, and 2020
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
#'
#'
#' @param encoding Data original encoding (defaults to 'latin1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). elections_rda
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{candidate_local()} returns a \code{data.frame} with the following variables:
#'
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- candidate_local(2000)
#' }

candidate_local <- function(year,
                            uf = "all", 
                            encoding = "latin1", 
                            temp = TRUE){

  .Deprecated("elections_tse", msg = "candidate_local is deprecated. Please use the elections_tse function")
  
  answer <- candidate(year,
                      uf,
                      encoding =  encoding, 
                      temp = temp)
  return(answer)
    
}
