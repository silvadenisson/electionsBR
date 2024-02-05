#' Download data on candidate electoral results in federal elections in Brazil
#'
#' \code{vote_mun_zone_fed()} downloads and aggregates data on the verification of federal elections in Brazil,
#' disaggregated by cities and electoral zone. The function returns a \code{data.frame} where each observation
#' corresponds to a city/zone.
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014 and 2018 elections, more variable are available.
#'
#' @param year Election year. For this function, only the years 1998, 2002, 2006, 2010, 2014, and 2018
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
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
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#' 
#' @param readme_pdf original readme
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{vote_mun_zone_fed()} returns a \code{data.frame} with the following variables:
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- vote_mun_zone_fed(2002)
#' }

vote_mun_zone_fed <- function(year, 
                              uf = "all", 
                              br_archive = FALSE, 
                              encoding = "latin1", 
                              temp = TRUE,
                              readme_pdf = FALSE){
  
  
  .Deprecated("elections_tse", msg = "vote_mun_zone_fed is deprecated. Please use the elections_tse function")
  
  answer <- vote_mun_zone(year, 
                          uf,
                          br_archive, 
                          encoding, 
                          temp,
                          readme_pdf)
  return(answer)
}