#' Download data on the polls by parties from local elections in Brazil
#'
#' \code{party_mun_zone_local()} downloads and aggregates data on the polls by parties from local elections in Brazil,
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
#' @param temp (\code{logical}). If \code{TRUE} keep temporary compressed file
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{party_mun_zone_local()} returns a \code{data.frame} with the following variables:
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
#'   \item DESCRICAO_CARGO: Description of the position that the candidate runs for.
#'   \item TIPO_LEGENDA: It informs it the candidate runs for 'coalition' or 'isolated party'.
#'   \item NOME_COLIGACAO: Coalition name.
#'   \item COMPOSICAO_LEGENDA: Coalition's composition.
#'   \item NUMERO_PARTIDO: Party number.
#'   \item SIGLA_PARTIDO: Party's acronym.
#'   \item NOME_PARTIDO: Party name.
#'   \item QTDE_VOTOS_NOMINAIS: Total number of nominal votes that a party received in that city and zone.
#'   \item QTDE_VOTOS_LEGENDA: Total number of votes that a coalitions received in that city and zone.
#'   \item SEQUENCIAL_LEGENDA: Coalition's sequential number, generated internally by the electoral justice.
#'   \item TRANSITO: Electoral result outside the candidates' district? (N for no).
#' }
#'
#' @seealso \code{\link{party_mun_zone_fed}} for local federal in Brazil.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- party_mun_zone_local(2000)
#' }


party_mun_zone_local <- function(year, uf = "all", ascii = FALSE, 
                                 encoding = "latin1", 
                                 export = FALSE,
                                 temp = TRUE){


  # Test the input
  test_encoding(encoding)
  test_local_year(year)
  uf <- test_uf(uf)
  
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
  banco <- juntaDados(uf, encoding, FALSE)
  setwd("..")
  unlink(as.character(year), recursive = T)

  # Change variable names
  if(year <= 2012){
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "TIPO_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                      "SIGLA_PARTIDO", "NUMERO_PARTIDO", "NOME_PARTIDO", "QTDE_VOTOS_NOMINAIS",
                      "QTDE_VOTOS_LEGENDA", "SEQUENCIAL_LEGENDA")
  } else {
    
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO", "NOME_TIPO_ELEICAO",
                      "NUM_TURNO", "COD_ELEICAO", "DESCRICAO_ELEICAO", "DATA_ELEICAO", "ABRANGENCIA", "SIGLA_UF",
                      "SIGLA_UE", "NOME_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA", "CODIGO_CARGO",
                      "DESCRICAO_CARGO", "TIPO_LEGENDA", "NUMERO_PARTIDO", "SIGLA_PARTIDO", "NOME_PARTIDO",     
                      "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA", "TRANSITO", "QTDE_VOTOS_NOMINAIS",
                      "QTDE_VOTOS_LEGENDA")
 }
    
  # Change to ascii
  if(ascii == T) banco <- to_ascii(banco, encoding)

  # Export
  if(export) export_data(banco)
  
  message("Done.\n")
  return(banco)
}
