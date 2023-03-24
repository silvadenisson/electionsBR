#' Download data on the voters' profile by vote section
#'
#' \code{voter_profile_by_section()} downloads and cleans data on the voters' profile aggregated by voting section (i.e., voting stations).
#' The function returns a \code{data.frame} where each observation corresponds to a voter profile type.
#'
#' @param year Election year (\code{integer}). For this function, the following years are available: 1994, 1996, 1998,
#' 2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018 and 2020.
#' 
#' @param uf Federation Unit acronym (\code{character vector}). Defaults to \code{'AC'} (Acre).
#' 
#'
#' @param encoding Data original encoding (defaults to 'windows-1252'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{voter_profile()} returns a \code{data.frame} with the following variables:
#'
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @examples
#' \dontrun{
#' df <- voter_profile_by_section(2016)
#' }

voter_profile_by_section <- function(year, 
                                     uf = "AC",
                                     encoding = "windows-1252",
                                     temp = TRUE){
  
  
  # Inputs
  if(!year %in% seq(2008, 2020, by = 2)) stop("Invalid 'year'. Please check the documentation and try again.")
  test_encoding(encoding)
  if(tolower(uf) == "all") stop("'uf' is invalid. Please, check the documentation and try again.")
  uf <- test_uf(uf)
  

  filenames  <- paste0(year, "_", uf,".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/perfil_eleitor_secao/perfil_eleitor_secao_%s"

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
                             col_types = readr::cols(), progress = F, escape_double = F) %>%
    dplyr::as_tibble()
  
  setwd("..")
  unlink(as.character(year), recursive = T)
  
  message("Done.\n")
  banco
}

