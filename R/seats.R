#' Download data on the number of seats under dispute in federal elections
#'
#' \code{seats()} downloads and aggregates data on the number of seats under dispute in
#' federal elections in Brazil. The function returns a \code{tbl, data.frame} where each observation
#' corresponds to a district-office dyad.
#'
#' @note For the elections prior to 2000, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years of 1998, 2002, 2006, 2010, 2014 and 2018
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character} vector).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recovers only electoral data for presidential elections, absent in other files).
#'
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param temp (\code{logical}). If \code{TRUE} keep temporary compressed file
#'
#' @param readme_pdf original readme
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{seats()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @examples
#' \dontrun{
#' df <- seats(2000)
#' }

seats  <- function(year, 
                    uf = "all",  
                    br_archive = FALSE, 
                    encoding = "latin1", 
                    temp = TRUE,
                   readme_pdf = FALSE){
  
  
  # Input tests
  test_encoding(encoding)
  test_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)
  
  filenames  <- paste0("/consulta_vagas_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/consulta_vagas%s"
  
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
    file.rename(paste0(year ,"/leiame.pdf"), paste0("readme_seats_", year,".pdf"))
  }
  unlink(as.character(year), recursive = T)
  
  message("Done.\n")
  return(banco)
}

