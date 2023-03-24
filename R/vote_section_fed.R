#' Download data on candidate electoral results in federal elections in Brazil by electoral section
#'
#' \code{vote_section_fed()} downloads and cleans data on the verification of federal elections in Brazil,
#' disaggregated by electoral section. Different from other electionsBR's functions, results are only extract for individual states, one at a time. The function returns a \code{data.frame} where each observation
#' corresponds to an electoral section in a given Brazilian state.
#'
#' @note For the elections prior to 2002, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years 1998, 2002, 2006, 2010, and 2014
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}). Defaults to \code{'AC'} (Acre).
#'
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#'
#' @details If export is set to \code{TRUE}, the data is saved as .dta and .sav
#'  files in the working directory.
#'
#' @return \code{vote_section_fed()} returns a \code{data.frame}.
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- vote_section_fed(2002)
#' }

vote_section_fed <- function(year,
                             uf = "AC", 
                             encoding = "latin1", 
                             temp = TRUE){
  
  
  .Deprecated("elections_tse", msg = "vote_section_fed is deprecated. Please use the elections_tse function")
  
  answer <- vote_section(year, 
                              uf,
                              encoding, 
                              temp)
  return(answer)
}
