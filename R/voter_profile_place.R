#' Download data on the voters' profile by section
#'
#' \code{voter_profile()} downloads and cleans data on the voters' profile aggregated by state, city and electoral zone.
#' The function returns a \code{data.frame} where each observation corresponds to a voter profile type.
#'
#' @param year Election year (\code{integer}). For this function, the following years are available: 1994, 1996, 1998,
#' 2000, 2002, 2004, 2006, 2008, 2010, 2012, 2014, 2016, 2018 and 2020.
#' 
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'windows-1252'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param export (\code{logical}). Should the downloaded data be saved in .dta and .sav in the current directory?
#' 
#' @param temp (\code{logical}). If \code{TRUE} keep temporary compressed file
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{voter_profile()} returns a \code{data.frame} with the following variables:
#'
#' \itemize{
#'   \item  DT_GERACAO
#'   \item  HH_GERACAO
#'   \item  AA_ELEICAO    
#'   \item  DT_ELEICAO            
#'   \item  DS_ELEICAO
#'   \item  SG_UF              
#'   \item  CD_MUNICIPIO      
#'   \item  NM_MUNICIPIO         
#'   \item  NR_ZONA        
#'   \item  NR_SECAO             
#'   \item  CD_TIPO_SECAO_AGREGADA
#'   \item  DS_TIPO_SECAO_AGREGADA
#'   \item  NR_LOCAL_VOTACAO 
#'   \item  NM_LOCAL_VOTACAO   
#'   \item  CD_TIPO_LOCAL    
#'   \item  DS_TIPO_LOCAL        
#'   \item  DS_ENDERECO    
#'   \item  NM_BAIRRO        
#'   \item  NR_CEP             
#'   \item  NR_TELEFONE_LOCAL   
#'   \item  NR_LATITUDE
#'   \item  NR_LONGITUDE          
#'   \item  CD_SITU_LOCAL_VOTACAO
#'   \item  DS_SITU_LOCAL_VOTACAO 
#'   \item  CD_SITU_ZONA        
#'   \item  DS_SITU_ZONA       
#'   \item  CD_SITU_SECAO    
#'   \item  DS_SITU_SECAO      
#'   \item  CD_SITU_LOCALIDADE
#'   \item  DS_SITU_LOCALIDADE   
#'   \item  QT_ELEITOR
#'   \item  QT_ELEITOR_ELEICAO"   
#'   
#' }
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- voter_profile_place(2016)
#' }

voter_profile_place <- function(year, ascii = FALSE, 
                                encoding = "windows-1252",
                                export = FALSE,
                                temp = TRUE){
  
  
  # Inputs
  if(!year %in% seq(2016, 2020, by = 2)) stop("Invalid 'year'. Please check the documentation and try again.")
  test_encoding(encoding)
  
  #if(year == 2020){
  #  urldir <- "http://agencia.tse.jus.br/estatistica/sead/odsele/perfil_eleitorado/perfil_eleitorado_ATUAL.zip"
  #} else{
  #   urldir <- sprintf("http://agencia.tse.jus.br/estatistica/sead/odsele/perfil_eleitorado/perfil_eleitorado_%s.zip", year) 
  #  }

  filenames  <- paste0("/eleitorado_local_votacao_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/eleitorado_locais_votacao%s"
  
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
  unlink(as.character(year), recursive = T)
  
  
  # Change to ascii
  if(ascii) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)
  
  message("Done.\n")
  banco
}

