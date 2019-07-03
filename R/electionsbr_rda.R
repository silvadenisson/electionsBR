#' Download data on the candidates' background in local elections
#'
#' @param year Election year. For this function, onlye the years of 1996, 2000, 2004, 2008, 2012 and 2016
#' are available for local level. 1994, 1998, 2002, 2006, 2010, 2014, 2018 are available for fed level.
#' @param level Election level podem ser fed (default) or local. 
#' @param archive archive corresponde a um da funcoes basicas do pacote, podem ser: candidate (default), vote_mun_zone,
#' legend, party_mun_zone, personal_finances, details_mun_zone and seats
#' atualizacao do arquivo a cada 1 ano 
#' 
#' @import utils
#' @export
#' @examples
#' \dontrun{
#' df <- elections_rda(2018)
#' }

elections_rda <- function(year, level = "fed", archive = "candidate"){
  
   if(level == "fed"){
     test_fed_year(year)
   } else{
     test_local_year(year)
   }
  
  if(!(archive %in% c("candidate", "vote_mun_zone", "legend",
                      "party_mun_zone", "personal_finances", 
                      "details_mun_zone", "seats"))) stop("Invalid 'archive'. Please check the documentation and try again.")
  
  message("Download the data...")
  
  # download data
  load(url(sprintf("http://electionsbr.com/api_rda/%s_%s_%s.Rda", archive, level, year)))
  
  # get object
  banco <- get(setdiff(ls(), c("cand", "level", "year", "archive")))
  
  message("Done.\n")
  return(banco)
}

