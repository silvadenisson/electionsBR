#' Download data on candidate electoral results in federal elections in Brazil by electoral section
#'
#' \code{vote_section_fed()} downloads and cleans data on the verification of federal elections in Brazil,
#' disaggregated by electoral section. Different from other electionsBR's functions, results are only extract for individual states, one at a time. The function returns a \code{data.frame} where each observation
#' corresponds to an electoral section in a given Brazilian state.
#'
#' @note For the elections prior to 2002, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years 1998, 2002, 2006, 2010, and 2014
#' are available.
#' 
#' @param uf Federation Unit acronym (\code{character vector}). Defaults to \code{'AC'} (Acre).
#'
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param export (\code{logical}). Should the downloaded data be saved in .dta and .sav in the current directory?
#'
#' @details If export is set to \code{TRUE}, the data is saved as .dta and .sav
#'  files in the working directory.
#'
#' @return \code{vote_section_fed()} returns a \code{data.frame} with the following variables:
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
#'   \item NUMERO_SECAO: Electoral section number.
#'   \item CODIGO_CARGO: Code of the position that the candidate runs for.
#'   \item DESCRICAO_CARGO: Description of the position that the candidate runs for.
#'   \item NUM_VOTAVEL: Candidate's number in the ballot box.
#'   \item QTDE_VOTOS: Number of votes.
#'  }
#'
#' @seealso \code{\link{vote_section_local}} for local elections in Brazil.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- vote_section_fed(2002)
#' }

vote_section_fed <- function(year, uf = "AC", ascii = FALSE, encoding = "latin1", export = FALSE){
  
  if(tolower(uf) == "all") {
    stop("'uf' is invalid. Please, check the documentation and try again.")
  }

  # Test the inputs
  test_encoding(encoding)
  test_fed_year(year)
  stopifnot(is.character(uf))
  uf <- test_uf(uf)

  # Variable names
  if(year < 2014){
    data_names <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO", "SIGLA_UF", "SIGLA_UE",
                      "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA", "NUMERO_SECAO", "CODIGO_CARGO", "DESCRICAO_CARGO",
                      "NUM_VOTAVEL", "QTDE_VOTOS")
  } else{
    data_names <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO", "NOME_TIPO_ELEICAO", "NUM_TURNO",       
                      "COD_ELEICAO", "DESCRICAO_ELEICAO", "DATA_ELEICAO", "ABRANGENCIA", "SIGLA_UF", "SIGLA_UE", "NOME_UE",  
                      "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA", "NUMERO_SECAO", "CODIGO_CARGO", "DESCRICAO_CARGO",
                      "NUM_VOTAVEL", "NOME_VOTAVEL", "QTDE_VOTOS")
  }

  get_data('votacao_secao', year, uf, FALSE, ascii, encoding, export, data_names)
}
