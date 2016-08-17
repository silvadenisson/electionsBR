#' Download data on the polls by parties from federal elections in Brazil
#'
#' \code{party_mun_zone_fed()} downloads and aggregates the data on the polls by parties from the federal elections in Brazil,
#' disaggregated by cities and electoral zones. The function returns a \code{data.frame} where each observation
#' corresponds to a city/zone.
#'
#' @note For the elections prior to 2002, some information can be incomplete. For the 2014 elections, one more variable is available.
#'
#' @param year Election year. For this function, only the years 1998, 2002, 2006, 2010, and 2014
#' are available.
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
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- party_mun_zone_fed(2002)
#' }

party_mun_zone_fed <- function(year){


  # Test the input
  test_fed_year(year)

  # Download the data
  dados <- tempfile()
  sprintf("http://agencia.tse.jus.br/estatistica/sead/odsele/votacao_partido_munzona/votacao_partido_munzona_%s.zip", year) %>%
    download.file(dados)
  unzip(dados, exdir = paste0("./", year))
  unlink(dados)

  cat("Processing the data...")


  # Cleans the data
  setwd(as.character(year))
  banco <- juntaDados()
  setwd("..")
  unlink(as.character(year), recursive = T)

  # Change variable names
  if(year < 2014){
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "TIPO_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                      "NUMERO_PARTIDO", "SIGLA_PARTIDO", "NOME_PARTIDO", "QTDE_VOTOS_NOMINAIS",
                      "QTDE_VOTOS_LEGENDA", "SEQUENCIAL_LEGENDA")

  } else {
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "TIPO_LEGENDA", "NOME_COLIGACAO", "COMPOSICAO_LEGENDA",
                      "NUMERO_PARTIDO", "SIGLA_PARTIDO", "NOME_PARTIDO", "QTDE_VOTOS_NOMINAIS",
                      "QTDE_VOTOS_LEGENDA", "TRANSITO", "SEQUENCIAL_LEGENDA")
  }

  cat("Done.")
  return(banco)
}
