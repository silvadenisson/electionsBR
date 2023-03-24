#' function elections
#'
#' \code{elections_tse()} downloads and aggregates data on the verification of federal elections in Brazil,
#' disaggregated by cities and electoral zone. The function returns a \code{data.frame} where each observation
#' corresponds to a city/zone.
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014 and 2018 elections, more variable are available.
#'
#' @param year Election year. For this function, only the years 1998, 2002, 2006, 2010, 2014, and 2018
#' are available.
#' 
#' @param type tipo de dados 
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

elections_tse <- function(year, type, uf = "all", br_archive = FALSE,
                      ascii = FALSE, encoding = "latin1", 
                      export = FALSE, temp = TRUE){
  
  # test type
  test_type(type)
  
  # type
    if(type == "candidate"){
      
      banco <- candidate(year, uf, 
                         br_archive,
                             encoding, 
                             temp)
      
    } else if(type == "vote_mun_zone"){
      
      banco <- vote_mun_zone(year, uf, 
                             br_archive,
                         encoding, 
                         temp)
      
    } else if(type == "details_mun_zone"){
      
      banco <- details_mun_zone(year, uf, 
                               br_archive, 
                               encoding,
                               temp)
      
    } else if(type == "legends"){
      
      banco <- legends(year, uf, 
                     br_archive,
                     encoding,
                     temp)
      
    } else if(type == "party_mun_zone"){
      
      banco <- party_mun_zone(year, uf,
                             br_archive,
                             encoding,
                             temp)
      
    } else if(type == "personal_finances"){
      
      banco <- personal_finances(year, uf,
                                 br_archive,
                                 encoding, 
                                 temp)
      
    } else if(type == "seats"){
      
      banco <- seats(year, uf,  
                    br_archive, #verificar necessitosidade desse argumento
                    encoding, 
                    temp)
      
    } else if(type == "vote_section"){
      
      banco <- vote_section(year, uf, 
                           encoding, 
                           temp)
      
    } else if(type == "vote_profile_by_section"){
      
      banco <- voter_profile_by_section(year, 
                                       uf, 
                                       encoding,
                                       temp)
    } else if(type == "vote_profile"){
      
      banco <- voter_profile(year,  
                            encoding,
                            temp)
      
    } else if(type == "social_media"){
      
      banco <- social_media(year,
                           encoding,
                           temp)
      
    }
    
  
  # Change to ascii
  if(ascii) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)
  
  return(banco)
  
}
