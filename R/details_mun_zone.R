#' Download data on the verification of federal elections in Brazil
#'
#' \code{details_mun_zone()} downloads and aggregates data on the verification of federal elections in Brazil,
#' disaggregated by town and electoral zone. The function returns a \code{data.frame} where each observation
#' corresponds to a town/zone.
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014 and 2018 elections, more variables are available.
#'
#' @param year Election year. For this function, only the years 1994, 1998, 2002, 2006, 2010, 2014 and 2018
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
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
#' @param temp (\code{logical}). elections_rda
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{details_mun_zone()} returns a \code{data.frame}.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @examples
#' \dontrun{
#' df <- details_mun_zone(2002)
#' }

details_mun_zone <- function(year, uf = "all", 
                                 br_archive = FALSE, 
                                 encoding = "latin1",
                                 temp = TRUE){
  
  
  # Input tests
  test_encoding(encoding)
  test_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)
  
  filenames  <- paste0("/detalhe_votacao_munzona_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/detalhe_votacao_munzona%s"
  
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
  
  # Changes variables names
  if(year < 2010){
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "QTD_APTOS", "QTD_SECOES", "QTD_SECOES_AGREGADAS",
                      "QTD_APTOS_TOT", "QTD_SECOES_TOT", "QTD_COMPARECIMENTO", "QTD_ABSTENCOES",
                      "QTD_VOTOS_NOMINAIS", "QTD_VOTOS_BRANCOS", "QTD_VOTOS_NULOS", "QTD_VOTOS_LEGENDA",
                      "QTD_VOTOS_ANULADOS_APU_SEP", "DATA_ULT_TOTALIZACAO", "HORA_ULT_TOTALIZACAO")
    
  } else if(year < 2018) {
    names(banco) <- c("DATA_GERACAO",	"HORA_GERACAO",	"ANO_ELEICAO",	"COD_TIPO_ELEICAO",
                      "NOME_TIPO_ELEICAO", "NUM_TURNO",	"COD_ELEICAO",	"DESCRICAO_ELEICAO",
                      "DATA_ELEICAO",	"ABRANGENCIA", "SIGLA_UF",	"SIGLA_UE",	"NOME_UE",
                      "CODIGO_MUNICIPIO",	"NOME_MUNICIPIO",	"NUMERO_ZONA",	"CODIGO_CARGO",
                      "DESCRICAO_CARGO",	"QTD_APTOS",	"QTD_SECOES",	"QTD_SECOES_AGREGADAS",
                      "QTD_APTOS_TOT",  "QTD_SECOES_TOT",	"QTD_COMPARECIMENTO",	"QTD_ABSTENCOES",
                      "SIT_VOTO_EM_TRANSITO", "QTD_VOTOS_NOMINAIS",	"QTD_VOTOS_BRANCOS",
                      "QTD_VOTOS_NULOS",	"QTD_VOTOS_LEGENDA", "QTD_VOTOS_PENDENTES",
                      "QTD_VOTOS_ANULADOS",	"HH_ULTIMA_TOTALIZACAO",	"DT_ULTIMA_TOTALIZACAO")
    
  } else {
    names(banco) <- c("DATA_GERACAO",	"HORA_GERACAO",	"ANO_ELEICAO",	"COD_TIPO_ELEICAO",
                      "NOME_TIPO_ELEICAO", "NUM_TURNO",	"COD_ELEICAO",	"DESCRICAO_ELEICAO",
                      "DATA_ELEICAO",	"ABRANGENCIA", "SIGLA_UF",	"SIGLA_UE",	"NOME_UE",
                      "CODIGO_MUNICIPIO",	"NOME_MUNICIPIO",	"NUMERO_ZONA",	"CODIGO_CARGO",
                      "DESCRICAO_CARGO",	"QTD_APTOS",	"QTD_SECOES",	"QTD_SECOES_AGREGADAS",
                      "QT_SECOES_NAO_INSTALADAS",
                      "QTD_TOTAL_SECOES",	
                      "QTD_COMPARECIMENTO",	
                      "QTD_ELEITORES_SECOES_NAO_INSTALADAS",
                      "QTD_ABSTENCOES",
                      "SIT_VOTO_EM_TRANSITO",
                      "QTD_VOTOS",
                      "QTD_VOTOS_CONCORRENTES",
                      "QTD_VOTOS_VALIDOS",
                      "QTD_VOTOS_NOMINAIS_VALIDOS",	
                      "QTD_TOTAL_VOTOS_LEGENDA_VALIDOS", 
                      "QTD_VOTOS_LEGENDA_VALIDOS",
                      "QTD_VOTOS_NOMINAIS_CONVR_LEG",
                      "QTD_TOTAL_VOTOS_ANULADOS",
                      "QTD_VOTOS_NOMINAIS_ANULADOS",
                      "QTD_VOTOS_LEGENDA_ANULADOS",
                      "QTD_TOTAL_VOTOS_ANUL_SUBJUD",
                      "QTD_VOTOS_NOMINAIS_ANUL_SUBJUD",
                      "QTD_VOTOS_LEGENDA_ANUL_SUBJUD",
                      "QTD_VOTOS_BRANCOS",
                      "QTD_TOTAL_VOTOS_NULOS",
                      "QTD_VOTOS_NULOS",
                      "QTD_VOTOS_NULO_TECNICO",
                      "QTD_VOTOS_ANULADOS_APU_SEP",
                      "HH_ULTIMA_TOTALIZACAO",
                      "DT_ULTIMA_TOTALIZACAO")
  }
  
  
  message("Done.\n")
  return(banco)
}
