#' Download data on candidate electoral results in local elections in Brazil by electoral section
#'
#' \code{vote_section_local()} downloads and cleans data on the verification of local elections in Brazil,
#' disaggregated by electoral section. Different from other electionsBR's functions, results are only extract for individual states, one at a time. The function returns a \code{data.frame} where each observation
#' corresponds to an electoral section in a given Brazilian state.
#'
#' @note For the elections prior to 2002, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years 1996, 2000, 2004, 2008, 2012, 2016 and 2020
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
#' @return \code{vote_section_local()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- vote_section_local(2000)
#' }

vote_section_local <- function(year, 
                               uf = "AC", 
                               encoding = "latin1",
                               temp = TRUE){
  
  
  .Deprecated("elections_tse", msg = "vote_section_local is deprecated. Please use the elections_tse function")
  
  answer <- vote_section(year, 
                         uf,
                         encoding, 
                         temp)
  return(answer)
}
