#' function elections data from TSE repository
#'
#' \code{elections_tse()} data download from TSE repository
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014 and 2018 elections, more variable are available.
#'
#' @param year Election year. From 1998 to 2022.
#' are available.
#' 
#' @param type tipo de dados 
#' 
#' \itemize{
#'   \item candidate: downloads the data on the candidates'. 
#'   Where each observation corresponds to a candidate.
#'   \item vote_mun_zone: downloads data on the verification, disaggregated by cities and electoral zone.
#'    Where each observation corresponds to a city/zone.
#'   \item details_mun_zone: downloads THE data on disaggregated by town and electoral zone.
#'   Where each observation corresponds to a town/zone.
#'   \item legends: downloads the data on the party denomination (coalitions or parties), disaggregated bi cities. 
#'   Where each observation corresponds to a city.
#'   \item party_mun_zone: downloads the data on the polls by parties, disaggregated by cities and electoral zones. 
#'   Where each observation corresponds to a city/zone.
#'   \item personal_finances: download the data on personal financial disclosures. 
#'   Where each observation corresponds to a candidate's property.
#'   \item seats: download data on the number of seats under dispute in elections
#'   \item vote_section: download data on candidate electoral results in elections in Brazil by electoral section
#'   \item voter_profile_by_section: download data on the voters' profile by vote section
#'   \item voter_profile: download data on the voters' profile
#'   \item social_media: download data on the candidates' links social media in federal elections
#' }
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recoverns only electoral data for presidential elections, absent in other files).
#'
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param export (\code{logical}). Should the downloaded data be saved in .dta and .sav in the current directory?
#' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#' 
#' @param data_table for data.table
#' 
#' @param readme_pdf is original readme 
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
#' df <- elections_tse(2002, type = "candidate")
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
                     br_archive, #verificar necessitosidade desse argumento
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
