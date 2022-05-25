#' Download data on the polls by parties from federal elections in Brazil
#'
#' \code{party_mun_zone_fed()} downloads and aggregates the data on the polls by parties from the federal elections in Brazil,
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
#' @return \code{party_mun_zone_fed()} returns a \code{data.frame} with the following variables:
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
#'   \item TRANSITO: It informs whether the record relates or not to absentee ballot votes (only for 2014 election).
#' }
#' 
#' From 2018 on, some new variables are also available:
#' \itemize{
#'   \item COD_TIPO_ELEICAO: Election type code.
#'   \item NOME_TIPO_ELEICAO: Election type.
#'   \item COD_ELEICAO: Election code.
#'   \item DATA_ELEICAO: Election date.
#'   \item ABRANGENCIA: Election scope.
#'   \item NOME_UE: Electoral unit name.
#'}
#'
#' @seealso \code{\link{party_mun_zone_local}} for local elections in Brazil.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- party_mun_zone_fed(2002)
#' }

party_mun_zone_fed <- function(year, uf = "all",
                               br_archive = FALSE,
                               ascii = FALSE, 
                               encoding = "latin1", 
                               export = FALSE,
                               temp = TRUE){


  # Test the input
  test_encoding(encoding)
  test_fed_year(year)
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
  } else{
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO", "NOME_TIPO_ELEICAO",
                      "NUM_TURNO", "COD_ELEICAO", "DESCRICAO_ELEICAO", "DATA_ELEICAO", "ABRANGENCIA",
                      "SIGLA_UF", "SIGLA_UE", "NOME_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "TIPO_LEGENDA", "NUMERO_PARTIDO", "SIGLA_PARTIDO",
                      "NOME_PARTIDO", "SEQUENCIAL_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA", 
                      "TRANSITO", "QTDE_VOTOS_NOMINAIS", "QTDE_VOTOS_LEGENDA")
  }
  
  # Change to ascii
  if(ascii == T) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)

  message("Done.\n")
  return(banco)
}
