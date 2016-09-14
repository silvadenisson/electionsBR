#' Download data on the verification of local elections in Brazil
#'
#' \code{details_mun_zone_local()} downloads and aggregates the data on the verification of local elections in Brazil,
#' disaggregated by electoral zone. The function returns a \code{data.frame} where each observation
#' corresponds to a town/zone.
#'
#' @note For the elections prior to 2000, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years 1996, 2000, 2004, 2008, and 2012
#' are available.
#'
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @return \code{details_mun_zone_local()} returns a \code{data.frame} with the following variables:
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
#'   \item CODIGO_CARGO: Code of the position that the candidate runs for.
#'   \item DESCRICAO_CARGO: Description of the position that the candidate runs for.
#'   \item QTD_APTOS: Number of eligible voters to vote in that city and zone.
#'   \item QTD_SECOES: Number of existing polling stations in that city and zone. It only considers main sections.
#'   \item QTD_SECOES_AGREGADAS: Number of polling stations that have been aggregated for the voting the same ballot box in that city and area. To add sections means to unite polling stations in a single receiving table votes, in order to meet the Electoral Code, which establishes, as a rule, a minimum of 50 voters in a section election, and to optimize the use of resources for the polls electronic and poll workers.
#'   \item QTD_APTOS_TOT: Number of eligible voters in the total sections.
#'   \item QTD_SECOES_TOT: Total number of polling stations in that city and area.
#'   \item QTD_COMPARECIMENTO: Number of voters who attended the elections in city and district in that position.
#'   \item QTD_ABSTENCOES: Number of voters who did not attend the elections in city and area.
#'   \item QTD_VOTOS_NOMINAIS: Total number of nominal votes in that city and zone.
#'   \item QTD_VOTOS_BRANCOS: Total number of blank votes in that city and zone.
#'   \item QTD_VOTOS_NULOS: Total number of spoilt votes in that city and zone.
#'   \item QTD_VOTOS_LEGENDA: Total number of votes in coalitions in that city and zone.
#'   \item QTD_VOTOS_ANULADOS_APU_SEP: Amount of canceled votes and votes counted separately in that city and zone. This number reflects the votes coming from some ballot box that is sub-judice. They are not yet valid votes or null until the decision of the electoral court.
#'   \item DATA_ULT_TOTALIZACAO: Date of the last totalization in that city and zone.
#'   \item HORA_ULT_TOTALIZACAO: Time of the last totalization in that city and zone.
#' }
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- details_mun_zone_local(2000)
#' }

details_mun_zone_local <- function(year, ascii = FALSE){


  # Input tests
  test_local_year(year)

  # Downloads the data
  dados <- tempfile()
  sprintf("http://agencia.tse.jus.br/estatistica/sead/odsele/detalhe_votacao_munzona/detalhe_votacao_munzona_%s.zip", year) %>%
    download.file(dados)
  unzip(dados, exdir = paste0("./", year))
  unlink(dados)

  cat("Processing the data...")

  # Cleans the data
  setwd(as.character(year))
  banco <- juntaDados()
  setwd("..")
  unlink(as.character(year), recursive = T)

  # Changes variables names
     names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                       "SIGLA_UF", "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA",
                       "CODIGO_CARGO", "DESCRICAO_CARGO", "QTD_APTOS", "QTD_SECOES", "QTD_SECOES_AGREGADAS",
                       "QTD_APTOS_TOT", "QTD_SECOES_TOT", "QTD_COMPARECIMENTO", "QTD_ABSTENCOES",
                       "QTD_VOTOS_NOMINAIS", "QTD_VOTOS_BRANCOS", "QTD_VOTOS_NULOS", "QTD_VOTOS_LEGENDA",
                       "QTD_VOTOS_ANULADOS_APU_SEP", "DATA_ULT_TOTALIZACAO", "HORA_ULT_TOTALIZACAO")

  # Change to ascii
  if(ascii == T) banco <- to_ascii(banco)

  cat("Done.")
  return(banco)
}
