#' Download data on the verification of local elections in Brazil
#'
#' \code{details_mun_zone_local()} downloads and aggregates the data on the verification of local elections in Brazil,
#' disaggregated by electoral zone. The function returns a \code{data.frame} where each observation
#' corresponds to a town/zone.
#'
#' @note For the elections prior to 2000, some information can be incomplete.
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
#' @param temp (\code{logical}). elections_rda
#' 
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{details_mun_zone_local()} returns a \code{data.frame} with the following variables:
#'
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- details_mun_zone_local(2000)
#' }

details_mun_zone_local <- function(year,
                                   uf = "all", 
                                   encoding = "latin1",
                                   temp = TRUE){


 
  .Deprecated("elections_tse", msg = "details_mun_zone_local is deprecated. Please use the elections_tse function")
  
  answer <- details_mun_zone(year,
                             uf, 
                             encoding = encoding, 
                             temp = temp)
  return(answer)
}
