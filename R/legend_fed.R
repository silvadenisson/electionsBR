#' Download data on federal election coalitions in Brazil
#'
#' \code{legend_fed()} downloads and aggregates the data on the party denomination (coalitions or parties) from the federal elections in Brazil,
#' disaggregated bi cities. The function returns a \code{data.frame} where each observation
#' corresponds to a city.
#'
#' @note For elections prior to 2002, some information can be incomplete.
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
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param export (\code{logical}). Should the downloaded data be saved in .dta and .sav in the current directory?
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{legend_fed()} returns a \code{data.frame} with the following variables:
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
#'   \item NOME_UE: Electoral Unit name.
#'   \item CODIGO_CARGO: Code of the position that the candidate runs for.
#'   \item DESCRICAO_CARGO: Description of the position that the candidate runs for.
#'   \item TIPO_LEGENDA: It informs it the candidate runs for 'coalition' or 'isolated party'.
#'   \item NUM_PARTIDO: Party number.
#'   \item SIGLA_PARTIDO: Party acronym.
#'   \item NOME_PARTIDO: Party name.
#'   \item SIGLA_COLIGACAO: Coalition's acronym.
#'   \item CODIGO_COLIGACAO: Coalition's code.
#'   \item COMPOSICAO_COLIGACAO: Coalition's composition.
#'   \item SEQUENCIAL_COLIGACAO: Coalition's sequential number, generated internally by the electoral justice.
#'   \item SIGLA_COLIGACAO: Coalition's acronym.
#' }
#'
#' @seealso \code{\link{legend_local}} for local elections in Brazil.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- legend_fed(2002)
#' }

legend_fed <- function(year, uf = "all", br_archive = FALSE, ascii = FALSE, encoding = "latin1", export = FALSE){

  # Test the input
  test_encoding(encoding)
  test_fed_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)

  if(year < 2018) {
    data_name <- "consulta_legendas"
  } else{
    data_name <- "consulta_coligacao"
  }

  # Variable names
  if(year < 2018) {
    data_names <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "NOME_MUNICIPIO", "CODIGO_CARGO", "DESCRICAO_CARGO",
                      "TIPO_LEGENDA", "NUMERO_PARTIDO", "SIGLA_PARTIDO", "NOME_PARTIDO", "SIGLA_COLIGACAO",
                      "NOME_COLIGACAO", "COMPOSICAO_COLIGACAO", "SEQUENCIAL_COLIGACAO")
  } else{
    data_names <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO", "NM_TIPO_ELEICAO",
                      "NUM_TURNO", "COD_ELEICAO", "DESCRICAO_ELEICAO", "DATA_ELEICAO", "SIGLA_UF",
                      "SIGLA_UE", "NOME_MUNICIPIO", "CODIGO_CARGO", "DESCRICAO_CARGO", "TIPO_LEGENDA",
                      "NUMERO_PARTIDO", "SIGLA_PARTIDO", "NOME_PARTIDO", "SEQUENCIAL_COLIGACAO",
                      "NOME_COLIGACAO", "COMPOSICAO_COLIGACAO")
  }

  get_data(data_name, year, uf, br_archive, ascii, encoding, export, data_names)
}
