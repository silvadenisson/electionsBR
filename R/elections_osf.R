#' Function for downloading electoral data from the TSE repository, by backup salve in platform OSF.
#'
#' The \code{elections_osf()} function is a wrapper that allows users to download electoral data from Brazil's TSE repository. This function provides data on candidates, electoral results, personal finances, and other election-related information from 1998 to 2024. The returned \code{data.frame} contains observations corresponding to candidates, cities, or electoral zones.
#'
#' @note For elections prior to 2002, some information may be incomplete. For the 2014 and 2018 elections, additional columns are available. It is also important to note that in recent years, the TSE has changed the format of some data files, using CSV format with a header.
#'
#' @param year Election year. Valid options are 1998, 2002, 2006, 2010, 2014, 2018, and 2022 for federal elections; and 1996, 2000, 2004, 2008, 2012, 2016, 2020, and 2024 for municipal elections.
#' 
#' @return The \code{elections_osf()} function returns a \code{data.frame} with the requested electoral data.
#' 
#' @param type Requested data type. Valid options are:
#' 
#' The \code{elections_osf()} function supports the following types of data downloads:
#' 
#' * \code{candidate}: Downloads data on the candidates. Each observation corresponds to a candidate.
#' * \code{candidate_add_infor}: Downloads data on the candidates - Addtional information. Each observation corresponds to a candidate, available for 2024.
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
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' file by setting this argument to \code{TRUE} (may not work for some elections and, in 
#' others, it only retrieves electoral data for presidential elections, which are absent in other files).
#'
#' 
#' @param export (\code{logical}). Should the downloaded data be saved as .dta and .sav files in the current directory?
#' 
#' @param data_table should the returned object be a data.table? Defaults to FALSE.
#' 
#' @param readme_pdf should the original README file be saved as a PDF in the working directory? Defaults to FALSE.
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{elections_osf()} returns a \code{data.frame} with the following variables:
#'
#'
#' @import utils
#' @import osfr
#' 
#' @export
#' @examples
#' \dontrun{
#' # Download data on the candidates in the 2002 elections
#' cands <- elections_osf(2002, type = "candidate")
#' }

elections_osf <- function(year, type,
                          br_archive = FALSE,
                          export = FALSE, 
                          data_table = FALSE, 
                          readme_pdf = FALSE){
  
  # test type
  test_type(type)
  test_year(year)
  
 
  projeto <- osfr::osf_retrieve_node("pt63m")
  arquivos <- osfr::osf_ls_files(projeto, n_max = Inf)
  
  arq <- arquivos[arquivos$name == paste0(type, year, ".Rds"), ]
  
  if(length(arq) != 0){
    
    message("Processing the data...")
    
    down <- osfr::osf_download(arq, conflicts = T)
    
    banco <- readRDS(down$local_path)
    
    unlink(down$local_path,  recursive = T)
    
    
    if(readme_pdf == TRUE){
      
      arqread <- arquivos[arquivos$name == paste0("readme_", type, ".pdf"), ]
      
      osfr::osf_download(arqread, conflicts = T)
      
    }
  } else{
    
    message("Invalid input. Please, check the documentation and try again.")
  }
  
  # for data.table
  if(data_table) banco <- data.table::data.table(banco)
  
  # Export
  if(export) export_data(banco)
  
  message("Done.\n")
  return(banco)

}
