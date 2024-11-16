#' Downloads data on the candidates - Addtional information
#'
#' \code{candidate_add_infor()} downloads and aggregates data on the candidates' background who ran in
#' elections in Brazil. The function returns a \code{data.frame} where each observation
#' corresponds to a candidate.
#'
#' @note For the elections prior to 2024.
#'
#' @param year Election year (\code{integer}). For this function, only the years 2024
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recovers only electoral data for presidential elections, absent in other files).
#' 
#'
#' @param encoding Data original encoding (defaults to 'latin1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). temp
#' 
#' @param readme_pdf original readme
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'  
#'
#' @return \code{candidate_add_infor} returns a \code{tbl, data.frame} with the following variables:
#'
#' 
#' @import utils
#' @importFrom magrittr "%>%"
#' 
#' @examples
#' \dontrun{
#' df <- candidate_add_infor(2024)
#' }

candidate_add_infor <- function(year, 
                      uf = "all", 
                      br_archive = FALSE,
                      encoding = "latin1", 
                      temp = TRUE,
                      readme_pdf = FALSE
){
  
  # Test the input
  test_encoding(encoding)
  test_year_cand_add_infor(year)
  uf <- test_uf(uf)
  test_br(br_archive)
  
  
  filenames  <- paste0("/consulta_cand_complementar_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/consulta_cand_complementar%s"

  # Downloads the data
  download_unzip(url, dados, filenames, year)
  
  # remover temp file
  if(temp == FALSE){
    unlink(dados)
  }
  
  # data row bind
  setwd(as.character(year))
  banco <- juntaDados(uf, encoding, br_archive)
  setwd("..")
  if(readme_pdf){
    file.rename(paste0(year ,"/leiame.pdf"), paste0("readme_candidate_", year,".pdf"))
  }
  unlink(as.character(year), recursive = T)
  
  message("Done.\n")
  return(banco)
}

