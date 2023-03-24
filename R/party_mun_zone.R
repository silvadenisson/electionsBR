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
#' other, it recoverns only electoral data for presidential elections, absent in other files).
#'
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
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
                               temp = TRUE){
  
  
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
  unlink(as.character(year), recursive = T)
  
  # Change variable names
  if(year < 2010){
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "TIPO_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                      "SIGLA_PARTIDO", "NUMERO_PARTIDO", "NOME_PARTIDO", "QTDE_VOTOS_NOMINAIS",
                      "QTDE_VOTOS_LEGENDA", "SEQUENCIAL_LEGENDA")
  } else if(year < 2018) {
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO", "NOME_TIPO_ELEICAO",
                      "NUM_TURNO", "COD_ELEICAO", "DESCRICAO_ELEICAO", "DATA_ELEICAO", "ABRANGENCIA",
                      "SIGLA_UF", "SIGLA_UE", "NOME_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "TIPO_LEGENDA", "NUMERO_PARTIDO", "SIGLA_PARTIDO",
                      "NOME_PARTIDO", "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA", 
                      "TRANSITO", "QTDE_VOTOS_NOMINAIS", "QTDE_VOTOS_LEGENDA")
  } else {
    names(banco) <- c("DATA_GERACAO","HORA_GERACAO","ANO_ELEICAO","COD_TIPO_ELEICAO",
                      "NOME_TIPO_ELEICAO","NUM_TURNO","COD_ELEICAO","DESCRICAO_ELEICAO",
                      "DATA_ELEICAO","ABRANGENCIA","SIGLA_UF","SIGLA_UE","NOME_UE",
                      "CODIGO_MUNICIPIO","NOME_MUNICIPIO","NUMERO_ZONA","CODIGO_CARGO",
                      "DESCRICAO_CARGO","TIPO_LEGENDA","NUMERO_PARTIDO","SIGLA_PARTIDO","NOME_PARTIDO",
                      "NUMERO_FEDERACAO", "NOME_FEDERACAO","SIGLA_FEDERACAO","DES_COMPOSICAO_FEDERACAO",
                      "SEQUENCIAL_LEGENDA","NOME_COLIGACAO","COMPOSICAO_LEGENDA",
                      "TRANSITO","QTDE_VOTOS_LEGENDA_VALIDOS","QTDE_VOTOS_NOMINAIS_CONVR_LEG",
                      "QTDE_TOTAL_VOTOS_LEG_VALIDOS","QTDE_VOTOS_NOMINAIS_VALIDOS",
                      "QTDE_VOTOS_LEGENDA_ANUL_SUBJUD","QTDE_VOTOS_NOMINAIS_ANUL_SUBJUD"
    )
  }
  
  message("Done.\n")
  return(banco)
}
