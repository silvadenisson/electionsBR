#' Download data on federal candidates' personal financial disclosures
#'
#' \code{personal_finances()} downloads and aggregates the data on federal candidates' personal financial disclosures. The function returns a \code{data.frame} where each observation corresponds to a candidate's property.
#'
#' @note For the elections prior to 2000, some information may be incomplete.
#'
#' @param year Election year. For this function, only the years 2006, 2010, 2014, 2018 and 2022 are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recovers only electoral data for presidential elections, absent in other files).
#'
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#'  
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#' 
#' @param readme_pdf original readme
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{personal_finances()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @examples
#' \dontrun{
#' df <- personal_finances(2006)
#' }

personal_finances <- function(year, uf = "all",
                                  br_archive = FALSE, 
                                  encoding = "latin1", 
                                  temp = TRUE,
                              readme_pdf = FALSE){
  
  # Input tests
  test_encoding(encoding)
  test_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)
  
  if(year < 2006) stop("Not disponible. Please, only from 2006.\n")
    
  filenames  <- paste0("/bem_candidato_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/bem_candidato%s"
  
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
      file.rename(paste0(year ,"/leiame.pdf"), paste0("readme_personal_finances_", year,".pdf"))
    }
    unlink(as.character(year), recursive = T)
    
    message("Done.\n")
    return(banco)
} 

  