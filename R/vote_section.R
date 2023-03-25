#' Download data on candidate electoral results in federal elections in Brazil by electoral section
#'
#' \code{vote_section()} downloads and cleans data on the verification of federal elections in Brazil,
#' disaggregated by electoral section. Different from other electionsBR's functions, results are only extract for individual states, one at a time. The function returns a \code{data.frame} where each observation
#' corresponds to an electoral section in a given Brazilian state.
#'
#' @note For the elections prior to 2002, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years 1998, 2002, 2006, 2010, and 2014
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}). Defaults to \code{'AC'} (Acre).
#'
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#'
#' @details If export is set to \code{TRUE}, the data is saved as .dta and .sav
#'  files in the working directory.
#'
#' @return \code{vote_section()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @examples
#' \dontrun{
#' df <- vote_section(2002)
#' }

vote_section <- function(year, uf = "AC",
                             encoding = "latin1", 
                             temp = TRUE){
  
  
  # Test the inputs
  test_encoding(encoding)
  test_year(year)
  stopifnot(is.character(uf))
  if(tolower(uf) == "all") stop("'uf' is invalid. Please, check the documentation and try again.")
  uf <- test_uf(uf)
  
  filenames  <- paste0("/votacao_secao_", year, "_", uf, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/votacao_secao%s"
  
  # Downloads the data
  download_unzip(url, dados, filenames, year)
  
  # remover temp file
  if(temp == FALSE){
    unlink(dados)
  }
  
  # Clean the data
  setwd(as.character(year))
  banco <- juntaDados(uf, encoding, FALSE)
  setwd("..")
  unlink(as.character(year), recursive = T)
  
  # Change variable names
  if(year < 2010){
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO", "SIGLA_UF", "SIGLA_UE",
                      "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA", "NUMERO_SECAO", "CODIGO_CARGO", "DESCRICAO_CARGO",
                      "NUM_VOTAVEL", "QTDE_VOTOS")
  } else{
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO", "TIPO_ELEICAO", "NUM_TURNO",       
                      "COD_ELEICAO", "DESCRICAO_ELEICAO", "DATA_ELEICAO", "ABRANGENCIA", "SIGLA_UF", "SIGLA_UE", "NOME_UE",  
                      "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA", "NUMERO_SECAO", "CODIGO_CARGO", "DESCRICAO_CARGO",
                      "NUM_VOTAVEL", "NOME_VOTAVEL", "QTDE_VOTOS", "NUMERO_LOCAL_VOTACAO")
  }
  
  
  message("Done.\n")
  return(banco)
}
