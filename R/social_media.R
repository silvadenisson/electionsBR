#' Download data on the candidates' social media links in federal elections
#'
#' \code{social_media()} is a function that allows you to download data on the social media handles of candidates participating in federal and municipal elections in Brazil. The function returns a \code{data.frame} where each observation corresponds to a candidate's social media handles (i.e., usernames).
#'
#'
#' @param year Election year (\code{integer}). For this function, only the years 2020 and 2022
#' are available.
#' 
#'
#' @param encoding Data original encoding (defaults to 'latin1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param temp (\code{logical}). Whether to keep the temporary data files for future use (recommended).
#'
#' @param readme_pdf should the original README file be saved as a PDF in the working directory? Defaults to FALSE.
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
                         temp = TRUE,
                         readme_pdf = FALSE){
  # Input tests
  test_encoding(encoding)
  test_year(year)
  
  if(year < 2020) stop("Not disponible. Please, only from 2020.\n")

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
  #provisorio
  
  banco <- juntaDados(uf = "all", encoding, br_archive = FALSE)
  setwd("..")
  if(readme_pdf){
    file.rename(paste0(year ,"/leiame.pdf"), paste0("readme_social_media_", year,".pdf"))
  }
  unlink(as.character(year), recursive = T)
  
  message("Done.\n")
  return(banco)
}
