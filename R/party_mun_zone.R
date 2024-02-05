#' Download data on the polls by parties from federal elections in Brazil
#'
#' \code{party_mun_zone()} downloads and aggregates the data on the polls by parties from the federal elections in Brazil,
#' disaggregated by cities and electoral zones. The function returns a \code{data.frame} where each observation
#' corresponds to a city/zone.
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014 and 2018 elections, more variable are available.
#'
#' @param year Election year. For this function, only the years 1994, 1998, 2002, 2006, 2010, 2014 and 2018
#' are available.
#' 
#' @param uf Filter results by Federation Unit acronym (\code{character vector}).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recovers only electoral data for presidential elections, absent in other files).
#'
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#'
#' @param readme_pdf original readme
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{party_mun_zone()} returns a \code{data.frame}.
#'
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @examples
#' \dontrun{
#' df <- party_mun_zone(2002)
#' }

party_mun_zone <- function(year, 
                           uf = "all",
                           br_archive = FALSE,
                           encoding = "latin1", 
                           temp = TRUE,
                           readme_pdf = FALSE){
  
  
  # Test the input
  test_encoding(encoding)
  test_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)
  
  filenames  <- paste0("/votacao_partido_munzona_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/votacao_partido_munzona%s"
  
  # Downloads the data
  download_unzip(url, dados, filenames, year)
  
  # remover temp file
  if(temp == FALSE){
    unlink(dados)
  }
  
  # Cleans the data
  setwd(as.character(year))
  banco <- juntaDados(uf, encoding, br_archive)
  setwd("..")
  if(readme_pdf){
    file.rename(paste0(year ,"/leiame.pdf"), paste0("readme_party_mun_zone_", year,".pdf"))
  }
  unlink(as.character(year), recursive = T)
  
  
  message("Done.\n")
  return(banco)
}
