#' Download data on local election coalitions in Brazil
#'
#' \code{legend_local()} downloads and aggregates the party denominations (coalitions or parties) from the local elections in Brazil,
#' disaggregated by cities. The function returns a \code{data.frame} where each observation
#' corresponds to a city.
#'
#'
#' @param year Election year. For this function, only the years  2008, 2012 and 2016
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
#' @return \code{legend_local()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- legend_local(2000)
#' }

legend_local <- function(year, 
                         uf = "all", 
                         encoding = "latin1", 
                         temp = TRUE){


  .Deprecated("elections_tse", msg = "legend_local is deprecated. Please use the elections_tse function")
  
  answer <- legends(year, 
                      uf,
                      encoding, 
                      temp)

  return(answer)
  
}
