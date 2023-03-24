#' Download data on the candidates' backgrounds in federal elections
#'
#' \code{candidate()} downloads and aggregates data on the candidates' background who ran in
#' federal elections in Brazil. The function returns a \code{data.frame} where each observation
#' corresponds to a candidate.
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014 and 2018 elections, more variables are available.
#'
#' @param year Election year (\code{integer}). For this function, only the years 1994, 1998, 2002, 2006, 2010, 2014, and 2018
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
#' 
#' @param br_archive In the TSE's data repository, some results can be obtained for the whole country by loading a single
#' within a single file by setting this argument to \code{TRUE} (may not work in for some elections and, in 
#' other, it recoverns only electoral data for presidential elections, absent in other files).
#' 
#'
#' @param encoding Data original encoding (defaults to 'latin1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' 
#' @param temp (\code{logical}). elections_rda
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'  
#'
#' @return \code{candidate} returns a \code{tbl, data.frame} with the following variables:
#'
#' 
#' @import utils
#' @importFrom magrittr "%>%"
#' 
#' @examples
#' \dontrun{
#' df <- candidate(2002)
#' }

candidate <- function(year, 
                      uf = "all", 
                      br_archive = FALSE,
                      encoding = "latin1", 
                          temp = TRUE){

  # Test the input
  test_encoding(encoding)
  test_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)


  filenames  <- paste0("/consulta_cand_", year, ".zip")
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
  banco <- juntaDados(uf, encoding, br_archive)
  setwd("..")
  unlink(as.character(year), recursive = T)

  # Change variable names
  if(year < 2022){
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO",             
                      "NOME_TIPO_ELEICAO", "NUM_TURNO",  "COD_ELEICAO", "DESCRICAO_ELEICAO",                   
                      "DATA_ELEICAO", "ABRANGENCIA", "SIGLA_UF", "SIGLA_UE", "DESCRICAO_UE",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "SQ_CANDIDATO", "NUMERO_CANDIDATO",
                      "NOME_CANDIDATO", "NOME_URNA_CANDIDATO", "NOME_SOCIAL_CANDIDATO",          
                      "CPF_CANDIDATO", "NOME_EMAIL", "COD_SITUACAO_CANDIDATURA",
                      "DES_SITUACAO_CANDIDATURA", "COD_DETALHE_SITUACAO_CAND",
                      "DES_DETALHE_SITUACAO_CAND", "TIPO_AGREMIACAO", "NUMERO_PARTIDO",                   
                      "SIGLA_PARTIDO", "NOME_PARTIDO", "SQ_COLIGACAO", "NOME_COLIGACAO",                 
                      "COMPOSICAO_COLIGACAO", "COD_NACIONALIDADE", "DES_NACIONALIDADE",
                      "SIGLA_UF_NASCIMENTO", "COD_MUNICIPIO_NASCIMENTO",
                      "NOME_MUNICIPIO_NASCIMENTO", "DATA_NASCIMENTO", "IDADE_DATA_POSSE",          
                      "NUM_TITULO_ELEITORAL_CANDIDATO", "CODIGO_SEXO", "DESCRICAO_SEXO",
                      "COD_GRAU_INSTRUCAO", "DESCRICAO_GRAU_INSTRUCAO", "CODIGO_ESTADO_CIVIL",              
                      "DESCRICAO_ESTADO_CIVIL", "CODIGO_COR_RACA", "DESCRICAO_COR_RACA",
                      "CODIGO_OCUPACAO", "DESCRICAO_OCUPACAO", "VALOR_DESPESA_MAX_CAMPANHA",     
                      "CODIGO_SIT_TOT_TURNO", "DESCRICAO__SIT_TOT_TURNO", "SIT_REELEICAO",
                      "SIT_DECLARAR_BENS", "NUM_PROTOCOLO_CANDIDATURA", "NUM_PROCESSO",                  
                      "CODIGO_SITUACAO_CANDIDATO_PLEITO",  "DS_SITUACAO_CANDIDATO_PLEITO", 
                      "CODIGO_SITUACAO_CANDIDATO_URNA", "DESCRICAO__SITUACAO_CANDIDATO_URNA",   
                      "SIT_CANDIDATO_INSERIDO_URNA" )
  } else{
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO",             
                      "NOME_TIPO_ELEICAO", "NUM_TURNO",  "COD_ELEICAO", "DESCRICAO_ELEICAO",                   
                      "DATA_ELEICAO", "ABRANGENCIA", "SIGLA_UF", "SIGLA_UE", "DESCRICAO_UE",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "SQ_CANDIDATO", "NUMERO_CANDIDATO",
                      "NOME_CANDIDATO", "NOME_URNA_CANDIDATO", "NOME_SOCIAL_CANDIDATO",          
                      "CPF_CANDIDATO", "NOME_EMAIL", "COD_SITUACAO_CANDIDATURA",
                      "DES_SITUACAO_CANDIDATURA", "COD_DETALHE_SITUACAO_CAND",
                      "DES_DETALHE_SITUACAO_CAND", "TIPO_AGREMIACAO", "NUMERO_PARTIDO",                   
                      "SIGLA_PARTIDO", "NOME_PARTIDO", "NUMERO_FEDERACAO", "NOME_FEDERACAO",
                      "SIGLA_FEDERACAO", "COMPOSICAO_FEDERACAO" , "SQ_COLIGACAO", "NOME_COLIGACAO",                 
                      "COMPOSICAO_COLIGACAO", "COD_NACIONALIDADE", "DES_NACIONALIDADE",
                      "SIGLA_UF_NASCIMENTO", "COD_MUNICIPIO_NASCIMENTO",
                      "NOME_MUNICIPIO_NASCIMENTO", "DATA_NASCIMENTO", "IDADE_DATA_POSSE",          
                      "NUM_TITULO_ELEITORAL_CANDIDATO", "CODIGO_SEXO", "DESCRICAO_SEXO",
                      "COD_GRAU_INSTRUCAO", "DESCRICAO_GRAU_INSTRUCAO", "CODIGO_ESTADO_CIVIL",              
                      "DESCRICAO_ESTADO_CIVIL", "CODIGO_COR_RACA", "DESCRICAO_COR_RACA",
                      "CODIGO_OCUPACAO", "DESCRICAO_OCUPACAO", "VALOR_DESPESA_MAX_CAMPANHA",     
                      "CODIGO_SIT_TOT_TURNO", "DESCRICAO__SIT_TOT_TURNO", "SIT_REELEICAO",
                      "SIT_DECLARAR_BENS", "NUM_PROTOCOLO_CANDIDATURA", "NUM_PROCESSO",                  
                      "CODIGO_SITUACAO_CANDIDATO_PLEITO",  "DS_SITUACAO_CANDIDATO_PLEITO", 
                      "CODIGO_SITUACAO_CANDIDATO_URNA", "DESCRICAO_SITUACAO_CANDIDATO_URNA",   
                      "SIT_CANDIDATO_INSERIDO_URNA", "NM_TIPO_DESTINACAO_VOTOS",
                      "CD_SITUACAO_CANDIDATO_TOT", "DES_SITUACAO_CANDIDATO_TOT",
                      "ST_PREST_CONTAS")
  }
  
  
  
  message("Done.\n")
  return(banco)
}

