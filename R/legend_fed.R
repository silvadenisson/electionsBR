#' Download data on federal election coalitions in Brazil
#'
#' \code{legend_fed()} downloads and aggregates the data on the party denomination (coalitions or parties) from the federal elections in Brazil,
#' disaggregated bi cities. The function returns a \code{data.frame} where each observation
#' corresponds to a city.
#'
#' @note For elections prior to 2002, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years 1998, 2002, 2006, 2010, and 2014
#' are available.
#'
#'@param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
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
#' }
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @importFrom stringi stri_trans_general
#' @export
#' @examples
#' \dontrun{
#' df <- legend_fed(2002)
#' }

legend_fed <- function(year, ascii = FALSE){


  # Test the input
  test_fed_year(year)

  # Download the data
  dados <- tempfile()
  sprintf("http://agencia.tse.jus.br/estatistica/sead/odsele/consulta_legendas/consulta_legendas_%s.zip", year) %>%
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
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SIGLA_UE", "NOME_MUNICIPIO", "CODIGO_CARGO", "DESCRICAO_CARGO",
                      "TIPO_LEGENDA", "NUMERO_PARTIDO", "SIGLA_PARTIDO", "NOME_PARTIDO", "SIGLA_COLIGACAO",
                      "NOME_COLIGACAO", "COMPOSICAO_COLIGACAO", "SEQUENCIAL_COLIGACAO")
    
    # transform to ASCII
    if(ascii == TRUE){
      cat("transforming to ascii...")
      for(i in seq_along(colnames(banco))){
        banco[, i] <- stringi::stri_trans_general(banco[, i], "Latin-ASCII")
      }
    }

  cat("Done.")
  return(banco)
}
