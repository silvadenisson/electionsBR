#' Function for downloading electoral data from the TSE repository
#'
#' The \code{elections_tse()} function is a wrapper that allows users to download and clean electoral data from Brazil's TSE repository. This function provides data on candidates, electoral results, personal finances, and other election-related information from 1998 to 2022. The returned \code{data.frame} contains observations corresponding to candidates, cities, or electoral zones.
#'
#' @note For elections prior to 2002, some information may be incomplete. For the 2014 and 2018 elections, additional columns are available. It is also important to note that in recent years, the TSE has changed the format of some data files, using CSV format with a header.
#'
#' @param year Election year. Valid options are 1998, 2002, 2006, 2010, 2014, 2018, and 2022 for federal elections; and 1996, 2000, 2004, 2008, 2012, 2016, and 2020 for municipal elections.
#' 
#' @return The \code{elections_tse()} function returns a \code{data.frame} with the requested electoral data.
#' 
#' @param type Requested data type. Valid options are:
#' 
#' The \code{elections_tse()} function supports the following types of data downloads:
#' 
#' * \code{candidate}: Downloads data on the candidates. Each observation corresponds to a candidate.
#' * \code{vote_mun_zone}: Downloads data on the verification, disaggregated by cities and electoral zones. Each observation corresponds to a city/zone.
#' * \code{details_mun_zone}: Downloads data on the details, disaggregated by town and electoral zone. Each observation corresponds to a town/zone.
#' * \code{legends}: Downloads data on the party denomination (coalitions or parties), disaggregated by cities. Each observation corresponds to a city.
#' * \code{party_mun_zone}: Downloads data on the polls by parties, disaggregated by cities and electoral zones. Each observation corresponds to a city/zone.
#' * \code{personal_finances}: Downloads data on personal financial disclosures. Each observation corresponds to a candidate's property.
#' * \code{seats}: Downloads data on the number of seats under dispute in elections.
#' * \code{vote_section}: Downloads data on candidate electoral results in elections in Brazil by electoral section.
#' * \code{voter_profile_by_section}: Downloads data on the voters' profile by vote section.
#' * \code{voter_profile}: Downloads data on the voters' profile.
#' * \code{social_media}: Downloads data on the candidates' links to social media in federal elections.
#' 
#' @param uf Federation Unit acronym (\code{character}).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' file by setting this argument to \code{TRUE} (may not work for some elections and, in 
#' others, it only retrieves electoral data for presidential elections, which are absent in other files).
#'
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param export (\code{logical}). Should the downloaded data be saved as .dta and .sav files in the current directory?
#' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary files for future use (recommended).
#' 
#' @param data_table should the returned object be a data.table? Defaults to FALSE.
#' 
#' @param readme_pdf should the original README file be saved as a PDF in the working directory? Defaults to FALSE.
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{elections_tse()} returns a \code{data.frame} with the following variables:
#'
#'
#' @import utils
#' 
#' 
#' @export
#' @examples
#' \dontrun{
#' # Download data on the candidates in the 2002 elections
#' cands <- elections_tse(2002, type = "candidate")
#' }

elections_tse <- function(year, type,
                          uf = "all", br_archive = FALSE,
                          ascii = FALSE, encoding = "latin1", 
                          export = FALSE, temp = TRUE, 
                          data_table = FALSE, readme_pdf = FALSE){
  
  # test type
  test_type(type)
  
  # type
    if(type == "candidate"){
      
      banco <- candidate(year, 
                         uf, 
                         br_archive,
                         encoding, 
                         temp,
                         readme_pdf)
      
    } else if(type == "vote_mun_zone"){
      
      banco <- vote_mun_zone(year, 
                             uf, 
                             br_archive,
                             encoding, 
                             temp,
                             readme_pdf)
      
    } else if(type == "details_mun_zone"){
      
      banco <- details_mun_zone(year, 
                                uf, 
                                br_archive, 
                                encoding,
                                temp,
                                readme_pdf)
      
    } else if(type == "legends"){
      
      banco <- legends(year, 
                       uf, 
                       br_archive,
                       encoding,
                       temp,
                       readme_pdf)
      
    } else if(type == "party_mun_zone"){
      
      banco <- party_mun_zone(year, 
                              uf,
                              br_archive,
                              encoding,
                              temp,
                              readme_pdf)
      
    } else if(type == "personal_finances"){
      
      banco <- personal_finances(year, 
                                 uf,
                                 br_archive,
                                 encoding, 
                                 temp,
                                 readme_pdf)
      
    } else if(type == "seats"){
      
      banco <- seats(year, 
                     uf,  
                     br_archive,
                     encoding, 
                     temp,
                     readme_pdf)
      
    } else if(type == "vote_section"){
      
      banco <- vote_section(year, 
                            uf, 
                            encoding, 
                            temp,
                            readme_pdf)
      
    } else if(type == "voter_profile_by_section"){
      
      banco <- voter_profile_by_section(year, 
                                        uf, 
                                        encoding,
                                        temp,
                                        readme_pdf)
    } else if(type == "voter_profile"){
      
      banco <- voter_profile(year,  
                             encoding,
                             temp,
                             readme_pdf)
      
    } else if(type == "social_media"){
      
      banco <- social_media(year,
                            encoding,
                            temp,
                            readme_pdf)
      
    }
  
  # for data.table
  if(data_table) banco <- data.table::data.table(banco)
  
  # Change to ascii
  if(ascii) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)
  
  return(banco)
  
}
