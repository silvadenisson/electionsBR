#' Download data on candidate electoral results in local elections in Brazil
#'
#' \code{vote_mun_zone_local()} downloads and aggregates data on the verification from local elections in Brazil,
#' disaggregated by electoral zone. The function returns a \code{data.frame} where each observation
#' corresponds to a city/zone.
#'
#' @note For the elections prior to 2000, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years 1996, 2000, 2004, 2008, 2012, 2016 and 2020
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}).
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
#' @return \code{vote_mun_zone_local()} returns a \code{data.frame} with the following variables:
#'
#' \itemize{
#'   \item DATA_GERACAO: Generation date of the file (when the data was collected).
#'   \item HORA_GERACAO: Generation time of the file (when the data was collected), Brasilia Time.
#'   \item ANO_ELEICAO: Election year.
#'   \item NUM_TURNO: Round number.
#'   \item DESCRICAO_ELEICAO: Description of the election.
#'   \item SIGLA_UF: Units of the Federation's acronym in which occurred the election.
#'   \item SIGLA_UE: Units of the Federation's acronym (In case of major election is the FU's
#'   acronym in which the candidate runs for (text) and in case of municipal election is the
#'   municipal's Supreme Electoral Court code (number)). Assume the special values BR, ZZ and
#'   VT to designate, respectively, Brazil, Overseas and Absentee Ballot.
#'   \item CODIGO_MUNICIPIO: Supreme Electoral code from the city where occurred the election.
#'   \item NOME_MUNICIPIO: Name of the city where occurred the election.
#'   \item NUMERO_ZONA: Zone number.
#'   \item CODIGO_CARGO: Code of the position that the candidate runs for.
#'   \item NUMERO_CANDIDATO: Candidate's number in the ballot box.
#'   \item SQ_CANDIDATO: Candidate's sequence number generated internally by the electoral
#'   \item NOME_CANDIDATO: Candidate's complete name.
#'   \item NOME_URNA_CANDIDATO: Candidate's ballot box name.
#'   \item DESCRICAO_CARGO: Description of the position that the candidate runs for.
#'   \item COD_SIT_CAND_TOT: Candidate's totalization status code in that election round.
#'   \item NUMERO_PARTIDO: Party number.
#'   \item SIGLA_PARTIDO: Party's acronym.
#'   \item NOME_PARTIDO: Party name.
#'   \item SEQUENCIAL_LEGENDA: Coalition's sequential number, generated internally by the electoral justice.
#'   \item NOME_COLIGACAO: COalition name.
#'   \item COMPOSICAO_LEGENDA: Coalition's composition.
#'   \item TOTAL_VOTOS: Total of votes.
#'   \item TRANSITO: Electoral result outside the candidates' district? (N for no).
#'  }
#'
#' @seealso \code{\link{vote_mun_zone_fed}} for federal elections in Brazil.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- vote_mun_zone_local(2000)
#' }

vote_mun_zone_local <- function(year, uf = "all",  
                                ascii = FALSE, 
                                encoding = "latin1", 
                                export = FALSE, temp = TRUE){


  # Test the input
  test_encoding(encoding)
  test_local_year(year)
  uf <- test_uf(uf)
  

  filenames  <- paste0( year, ".zip")
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
  banco <- juntaDados(uf, encoding, FALSE)
  setwd("..")
  unlink(as.character(year), recursive = T)

  # Change variable names
  if(year <= 2012){
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "NUMERO_CAND", "SQ_CANDIDATO", "NOME_CANDIDATO", "NOME_URNA_CANDIDATO",
                      "DESCRICAO_CARGO", "COD_SIT_CAND_SUPERIOR", "DESC_SIT_CAND_SUPERIOR", "CODIGO_SIT_CANDIDATO",
                      "DESC_SIT_CANDIDATO", "CODIGO_SIT_CAND_TOT", "DESC_SIT_CAND_TOT", "NUMERO_PARTIDO",
                      "SIGLA_PARTIDO", "NOME_PARTIDO", "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                      "TOTAL_VOTOS")
  
  } else {
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO",         
                      "NOME_TIPO_ELEICAO", "NUM_TURNO", "COD_ELEICAO", "DESCRICAO_ELEICAO",              
                      "DATA_ELEICAO", "ABRANGENCIA", "SIGLA_UF", "SIGLA_UE", "NOME_UE",
                      "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA", "CODIGO_CARGO",
                      "DESCRICAO_CARGO", "SQ_CANDIDATO", "NUMERO_CAND", "NOME_CANDIDATO",
                      "NOME_URNA_CANDIDATO", "NOME_SOCIAL_CANDIDATO", "CODIGO_SIT_CANDIDATO", 
                      "DESC_SIT_CANDIDATO", "COD_SIT_CAND_SUPERIOR", "DESC_SIT_CAND_SUPERIOR",
                      "TIPO_AGREMIACAO", "NUMERO_PARTIDO", "SIGLA_PARTIDO", "NOME_PARTIDO",
                      "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                      "CODIGO_SIT_CAND_TOT", "DESC_SIT_CAND_TOT", "TRANSITO","TOTAL_VOTOS" )
}

  # Change to ascii
  if(ascii == T) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)

  message("Done.\n")
  return(banco)
}
