#' Download data on the candidates' links social media in federal elections
#'
#' \code{social_media()} downloads data on the candidates' link social média 
#' federal elections in Brazil. The function returns a \code{data.frame} where each observation
#' corresponds to a candidates' links.
#'
#'
#' @param year Election year (\code{integer}). For this function, only the years 2022
#' are available.
#' 
#'
#' @param encoding Data original encoding (defaults to 'latin1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). elections_rda
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'  
#'
#' @return \code{social_media()} returns a \code{tbl, data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @examples
#' \dontrun{
#' df <- social_media(2022)
#' }

social_media <- function(year,
                         encoding = "latin1", 
                         temp = TRUE){
  #provisorio
  uf = "all"
  br_archive = FALSE
  
  # Input tests
  test_encoding(encoding)
  test_year(year)


  filenames  <- paste0("/rede_social_candidato_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/consulta_cand%s"
  
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
  unlink(as.character(year), recursive = T)
  
  message("Done.\n")
  return(banco)
}
