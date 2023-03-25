#' Download data on the voters' profile
#'
#' \code{voter_profile()} downloads and cleans data on the voters' profile aggregated by state, city and electoral zone.
#' The function returns a \code{data.frame} where each observation corresponds to a voter profile type.
#'
#' @param year Election year (\code{integer}). For this function, the following years are available: 1998,
#' 2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018, 2020 and 2022.
#' 
#' @param encoding Data original encoding (defaults to 'windows-1252'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' #' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#'
#' @param readme_pdf original readme
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{voter_profile()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @examples
#' \dontrun{
#' df <- voter_profile(2002)
#' }

voter_profile <- function(year,
                          encoding = "windows-1252",
                          temp = TRUE,
                          readme_pdf = FALSE){
  
  
  # Inputs
    test_year(year)
    test_encoding(encoding)
  
  
  filenames  <- paste0("/perfil_eleitorado_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/perfil_eleitorado%s"
  
  # Downloads the data
  download_unzip(url, dados, filenames, year)
  
  # remover temp file
  if(temp == FALSE){
    unlink(dados)
  }
  
  setwd(as.character(year))
  
  archive <- Sys.glob("*")[grepl(".pdf", Sys.glob("*")) == FALSE] %>%
    file.info() %>%
    .[.$size > 200, ] %>%
    row.names()
  
  if(grepl(".csv", archive[1])){
    test_col_names <- TRUE
  }else{
    test_col_names <- FALSE
  }
  
  banco <- readr::read_delim(archive, col_names = test_col_names, delim = ";",
                             locale = readr::locale(encoding = encoding), 
                             col_types = readr::cols(), progress = F) %>%
    dplyr::as_tibble()
  
  setwd("..")
  if(readme_pdf){
    file.rename(paste0(year ,"/leiame.pdf"), paste0("readme_voter_profile_", year,".pdf"))
  }
  unlink(as.character(year), recursive = T)

  message("Done.\n")
  banco
}

