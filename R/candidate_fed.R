#' Download data on the candidates' background in local elections
#'
#' \code{candidate_fed()} downloads and aggregates the data on the candidates' background who vied
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
#' @param encoding Data original encoding (defaults to 'latin1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recovers only electoral data for presidential elections, absent in other files).
#' 
#' @param temp (\code{logical}). elections_rda
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{candidate_local()} returns a \code{data.frame} 
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- candidate_fed(2000)
#' }

candidate_fed <- function(year,
                          uf = "all",
                          br_archive = FALSE,
                          encoding = "latin1", 
                          temp = TRUE){
  
  .Deprecated("elections_tse", msg = "candidate_fed is deprecated. Please use the elections_tse function")
  
  answer <- candidate(year, 
                      uf,
                      br_archive,
                      encoding, 
                      temp)
  return(answer)
  
  
}
