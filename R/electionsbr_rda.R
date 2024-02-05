#' Download data on the candidates' background in local elections
#'
#' @param year Election year. For this function, only the years of 1996, 2000, 2004, 2008, 2012 and 2016
#' are available for local level. 1994, 1998, 2002, 2006, 2010, 2014, 2018 are available for the federal level.
#' @param level Election level podem ser fed (default) or local. 
#' @param archive Corresponds to one the following options: \code{candidate}, to download candidates' data; 
#' \code{vote_mun_zone}, to download electoral results; \code{legend}, to download data on parties' labels;
#' \code{party_mun_zone}, to download electoral results by party; \code{personal_finances}, to download
#' candidates' personal finances; \code{details_mun_zone}, to download data on the verification of elections;
#' and \code{seats}, to download data on available seats.
#' 
#' @import utils
#' @examples
#' \dontrun{
#' df <- elections_rda(2018)
#' }

elections_rda <- function(year, level = "fed", archive = "candidate"){
  
  test_year(year)
 
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

