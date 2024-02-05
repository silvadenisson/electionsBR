#' Download data on federal candidates' personal financial disclosures
#'
#' \code{personal_finances_local()} downloads and aggregates the data on federal candidates' personal financial disclosures. The function returns a \code{data.frame} where each observation corresponds to a candidate's property.
#'
#' @note For the elections prior to 2000, some information may be incomplete.
#'
#' @param year Election year. For this function, only the years 2006, 2010, 2014 and 2018 are available.
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
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{personal_finances_fed()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- personal_finances_fed(2006)
#' }

personal_finances_fed <- function(year, uf = "all",
                                  br_archive = FALSE, 
                                  encoding = "latin1", 
                                  temp = TRUE){
  
  .Deprecated("elections_tse", msg = "personal_finances_fed is deprecated. Please use the elections_tse function")
  
  answer <- personal_finances(year, 
                           uf,
                           br_archive,
                           encoding, 
                           temp)
  return(answer)
} 

