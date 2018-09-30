#' Download data on the candidates' background in local elections
#'
#' @param year Election year. For this function, onlye the years of 1996, 2000, 2004, 2008, 2012 and 2016
#' are available.
#' @export
#' @examples
#' \dontrun{
#' candidate_fed_rda(2000)
#' }

candidate_fed_rda <- function(year){
  load(url(paste0("http://electionsbr.com/api_rda/candidate_fed_", year, ".Rda")))
}



