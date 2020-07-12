#' Download data on the number of seats under dispute in local elections 
#'
#' \code{seats_local()} downloads and aggregates data on the number of seats under dispute in
#' local elections in Brazil. The function returns a \code{tbl, data.frame} where each observation
#' corresponds to a municipality office dyad.
#' 
#' @note For the elections prior to 2000, some information can be incomplete.
#'
#' @param year Election year. For this function, onlye the years of 1996, 2000, 2004, 2008, 2012 and 2016
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
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'
#' @return \code{seats_local()} returns a \code{data.frame} with the following variables:
#'
#' \itemize{
#'   \item DATA_GERACAO: Generation date of the file (when the data was collected).
#'   \item HORA_GERACAO: Generation time of the file (when the data was collected), Brasilia Time.
#'   \item ANO_ELEICAO: Election year.
#'   \item DESCRICAO_ELEICAO: Description of the election.
#'   \item SIGLA_UF: Units of the Federation's acronym in which occurred the election.
#'   \item SIGLA_UE: Units of the Federation's acronym (In case of major election is the FU's
#'   acronym in which the candidate runs for (text) and in case of municipal election is the
#'   municipal's Supreme Electoral Court code (number)). Assume the special values BR, ZZ and
#'   VT to designate, respectively, Brazil, Overseas and Absentee Ballot.
#'   \item NOME_UE: Description of the Electoral Unit.
#'   \item CODIGO_CARGO: Code of the position that the candidate runs for.
#'   \item DESCRICAO_CARGO: Description of the position that the candidate runs for.
#'   \item QTDE_VAGAS: number of seats under dispute.
#' }
#' 
#' @seealso \code{\link{seats_fed}} for federal elections in Brazil.
#' 
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- seats_local(2000)
#' }

seats_local <- function(year, uf = "all", ascii = FALSE, encoding = "latin1", export = FALSE){
  
  # Input tests
  test_encoding(encoding)
  test_local_year(year)
  uf <- test_uf(uf)
  
  # Change variable names
  if (year < 2016) {
    data_names <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "DESCRICAO_ELEICAO",
                    "SIGLA_UF", "SIGLA_UE", "NOME_UE", "CODIGO_CARGO", "DESCRICAO_CARGO",
                    "QTDE_VAGAS")
  } else {
    data_names <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO", 
                      "NOME_TIPO_ELEICAO", "COD_ELEICAO", "DESCRICAO_ELEICAO", 
                      "DATA_ELEICAO", "DATA_POSSE", "SIGLA_UF", "SIGLA_UE", "NOME_UE",        
                      "CODIGO_CARGO", "DESCRICAO_CARGO", "QTDE_VAGAS" )
  }

  get_data('consulta_vagas', year, uf, FALSE, ascii, encoding, export, data_names)
}
