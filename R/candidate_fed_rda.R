#' Download data on the candidates' background in local elections
#'
#' @param year Election year. For this function, onlye the years of 1996, 2000, 2004, 2008, 2012 and 2016
#' are available.
#' atualizacao do arquivo a cada 6 meses
#' @export
#' @examples
#' \dontrun{
#' candidate_fed_rda(2018)
#' }

candidate_fed_rda <- function(year){
  data <- readRDS(url(paste0("http://electionsbr.com/api_rda/candidate_fed_", year, ".Rda")))
  return(data)
}



