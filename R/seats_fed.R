#' Download data on the number of seats under dispute in federal elections
#'
#' \code{seats_fed()} downloads and aggregates data on the number of seats under dispute in
#' federal elections in Brazil. The function returns a \code{tbl, data.frame} where each observation
#' corresponds to a district-office dyad.
#'
#' @note For the elections prior to 2000, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years of 1998, 2002, 2006, 2010, 2014 and 2018
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character} vector).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recovers only electoral data for presidential elections, absent in other files).
#'
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). If \code{TRUE} keep temporary compressed file
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{seats_fed()} returns a \code{data.frame} with the following variables:
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- seats_fed(2000)
#' }

seats_fed <- function(year, uf = "all",  
                      br_archive = FALSE, 
                      encoding = "latin1", 
                      temp = TRUE){
  
  
  .Deprecated("elections_tse", msg = "seats_fed is deprecated. Please use the elections_tse function")
  
  answer <- seats(year, 
                  uf, 
                  br_archive, 
                  encoding, 
                  temp)
  return(answer)
}

