#' Download data on local candidates' personal financial disclosures
#'
#' \code{personal_finances_local()} downloads and aggregates the data on local candidates' personal financial disclosures. The function returns a \code{data.frame} where each observation corresponds to a candidate's property.
#'
#' @note For the elections prior to 2000, some information may be incomplete.
#'
#' @param year Election year. For this function, only the years 1996, 2000, 2004, 2008, 2012, 2016 and 2020
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
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
#' @return \code{assets_candidate_local()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- personal_finances_local(2000)
#' }

personal_finances_local <- function(year,
                                    uf = "all",  
                                    encoding = "latin1",
                                    temp = TRUE){
  
  
  .Deprecated("elections_tse", msg = "personal_finances_local is deprecated. Please use the elections_tse function")
  
  answer <- personal_finances(year, 
                              uf,
                              encoding, 
                              temp)
  return(answer)
}