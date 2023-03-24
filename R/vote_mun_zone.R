#' Download data on candidate electoral results in federal elections in Brazil
#'
#' \code{vote_mun_zone()} downloads and aggregates data on the verification of federal elections in Brazil,
#' disaggregated by cities and electoral zone. The function returns a \code{data.frame} where each observation
#' corresponds to a city/zone.
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014 and 2018 elections, more variable are available.
#'
#' @param year Election year. For this function, only the years 1998, 2002, 2006, 2010, 2014, and 2018
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recoverns only electoral data for presidential elections, absent in other files).
#'
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param export (\code{logical}). Should the downloaded data be saved in .dta and .sav in the current directory?
#' 
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{vote_mun_zone()} returns a \code{data.frame} with the following variables:
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' 
#' @examples
#' \dontrun{
#' df <- vote_mun_zone(2002)
#' }

vote_mun_zone <- function(year, uf = "all",  br_archive = FALSE, 
                              ascii = FALSE, encoding = "latin1", 
                              export = FALSE, temp = TRUE){
  
  # Test the input
  test_encoding(encoding)
  test_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)
  
  filenames  <- paste0(year, ".zip")
  dados <- paste0(file.path(tempdir()), "/", filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/votacao_candidato_munzona/votacao_candidato_munzona_%s"
  
  # Downloads the data
  download_unzip(url, dados, filenames, year)
  
  # remover temp file
  if(temp == FALSE){
    unlink(dados)
  }

  # Clean the data
  setwd(as.character(year))
  banco <- juntaDados(uf, encoding, br_archive)
  setwd("..")
  unlink(as.character(year), recursive = T)

  # Change variable names
  if(year < 2010){
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "NUMERO_CANDIDATO", "SQ_CANDIDATO", "NOME_CANDIDATO", "NOME_URNA_CANDIDATO",
                      "DESCRICAO_CARGO", "COD_SIT_CAND_SUPERIOR", "DESC_SIT_CAND_SUPERIOR", "CODIGO_SIT_CANDIDATO",
                      "DESC_SIT_CANDIDATO", "CODIGO_SIT_CAND_TOT", "DESC_SIT_CAND_TOT", "NUMERO_PARTIDO",
                      "SIGLA_PARTIDO", "NOME_PARTIDO", "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                      "TOTAL_VOTOS")

  }else if(year < 2018) { 
      names(banco) <- c("DATA_GERACAO",	"HORA_GERACAO",	"ANO_ELEICAO",	"COD_TIPO_ELEICAO",	"NOME_TIPO_ELEICAO",
                        "NUM_TURNO", "COD_ELEICAO",	"DESCRICAO_ELEICAO",	"DATA_ELEICAO",	"ABRANGENCIA", "SIGLA_UF",
                        "SIGLA_UE",	"NOME_UE", "CODIGO_MUNICIPIO",	"NOME_MUNICIPIO",	"NUMERO_ZONA", "CODIGO_CARGO",
                        "DESCRICAO_CARGO",	"SQ_CANDIDATO",	"NUMERO_CANDIDATO",	"NOME_CANDIDATO",	"NOME_URNA_CANDIDATO",
                        "NOME_SOCIAL_CANDIDATO",	"CODIGO_SIT_CANDIDATO",	"DESC_SIT_CANDIDATO",	"COD_SIT_CAND_SUPERIOR",
                        "DESC_SIT_CAND_SUPERIOR",	"TIPO_AGREMIACAO",	"NUMERO_PARTIDO",	"SIGLA_PARTIDO",	"NOME_PARTIDO",	
                        "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO",	"COMPOSICAO_LEGENDA",	"CODIGO_SIT_CAND_TOT", 
                        "DESC_SIT_CAND_TOT",	"VOTO_EM_TRANSITO",	"TOTAL_VOTOS")
      
  } else{
    names(banco) <- c("DATA_GERACAO",	"HORA_GERACAO",	"ANO_ELEICAO",	"COD_TIPO_ELEICAO",	"NOME_TIPO_ELEICAO",
                      "NUM_TURNO", "COD_ELEICAO",	"DESCRICAO_ELEICAO",	"DATA_ELEICAO",	"ABRANGENCIA", "SIGLA_UF",
                      "SIGLA_UE",	"NOME_UE", "CODIGO_MUNICIPIO",	"NOME_MUNICIPIO",	"NUMERO_ZONA", "CODIGO_CARGO",
                      "DESCRICAO_CARGO",	"SQ_CANDIDATO",	"NUMERO_CANDIDATO",	"NOME_CANDIDATO",	"NOME_URNA_CANDIDATO",
                      "NOME_SOCIAL_CANDIDATO",	"CODIGO_SIT_CANDIDATO",	"DESC_SIT_CANDIDATO",	"COD_SIT_CAND_SUPERIOR",
                      "DESC_SIT_CAND_SUPERIOR",	"TIPO_AGREMIACAO",	"NUMERO_PARTIDO",	"SIGLA_PARTIDO",	"NOME_PARTIDO",	
                      "NUMERO_FEDERACAO", "NOME_FEDERACAO", "SIGLA_FEDERACAO", "COMPOSICAO_FEDERACAO",
                      "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO",	"COMPOSICAO_LEGENDA", "SITUACAO_VOTO_EM_TRANSITO",
                      "TOTAL_VOTOS_NOMINAIS", "NOME_TIPO_DESTINACAO_VOTO", "TOTAL_VOTOS",
                      "CODIGO_SIT_CAND_TOT",  "DESC_SIT_CAND_TOT")
  } 
  
  # Change to ascii
  if(ascii == T) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)

  message("Done.\n")
  return(banco)
}
