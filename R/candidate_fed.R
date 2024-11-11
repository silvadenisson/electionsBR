#' Download data on the candidates' background in federal elections
#'
#' \code{candidate_fed()} downloads and aggregates the data on the candidates' background who competed in the
#' federal elections in Brazil. The function returns a \code{data.frame} where each observation
#' corresponds to a candidate.
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014, 2018, and 2022 elections, more variables are available.
#'
#' @param year Election year. For this function, only the years 1994, 1998, 2002, 2006, 2010, 2014, 2018, and 2022
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
  
  .Deprecated("elections_tse", msg = "candidate_fed is deprecated and will no longer be supported in electionsBR 1.0.0. Please use the elections_tse function")
  
  answer <- candidate(year, 
                      uf,
                      br_archive,
                      encoding, 
                      temp)
  return(answer)
  
  
}
