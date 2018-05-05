#' Download data on local candidates' personal financial disclosures
#'
#' \code{personal_finances_local()} downloads and aggregates the data on local candidates' personal financial disclosures. The function returns a \code{data.frame} where each observation corresponds to a candidate's property.
#'
#' @note For the elections prior to 2000, some information may be incomplete.
#'
#' @param year Election year. For this function, only the years 1996, 2000, 2004, 2008, 2012 and 2016
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
#' @return \code{assets_candidate_local()} returns a \code{data.frame} with the following variables:
#'
#' \itemize{
#'   \item DATA_GERACAO: Generation date of the file (when the data was collected).
#'   \item HORA_GERACAO: Generation time of the file (when the data was collected), Brasilia Time.
#'   \item ANO_ELEICAO: Election year.
#'   \item DESCRICAO_ELEICAO: Description of the election.
#'   \item SIGLA_UF: Units of the Federation's acronym in which occurred the election.
#'   \item SQ_CANDIDATO: Candidate's ID ID attributed by TSE.
#'   \item CD_TIPO_BEM_CANDIDATO: Code of the property.
#'   \item DS_TIPO_BEM_CANDIDATO: Description of the property.
#'   \item DETALHE_BEM: Addional details of the property.
#'   \item VALOR_BEM: Value, in current Brazilian reais, of the property.
#'   \item DATA_ULT_TOTALIZACAO: Date of the last totalization in that city and zone.
#'   \item HORA_ULT_TOTALIZACAO: Time of the last totalization in that city and zone.
#' }
#'
#' @seealso \code{\link{personal_finances_fed}} for personal financial disclosures of running candidates in federal elections.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- personal_finances_local(2000)
#' }

personal_finances_local <- function(year, uf = "all", ascii = FALSE, encoding = "Latin-1", export = FALSE){
  
  
  # Input tests
  test_encoding(encoding)
  test_local_year(year)
  uf <- test_uf(uf)
  
  # Downloads the data
  dados <- tempfile()
  sprintf("http://agencia.tse.jus.br/estatistica/sead/odsele/bem_candidato/bem_candidato_%s.zip", year) %>%
    download.file(dados)
  unzip(dados, exdir = paste0("./", year))
  unlink(dados)
  
  message("Processing the data...")
  
  # Cleans the data
  setwd(as.character(year))
  banco <- juntaDados(uf, encoding)
  setwd("..")
  unlink(as.character(year), recursive = T)
  
  # Changes variables names
    names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "DESCRICAO_ELEICAO",
                      "SIGLA_UF", "SQ_CANDIDATO", "CD_TIPO_BEM_CANDIDATO", "DS_TIPO_BEM_CANDIDATO",
                      "DETALHE_BEM", "VALOR_BEM", "DATA_ULT_TOTALIZACAO", "HORA_ULT_TOTALIZACAO")
 
  
  # Change to ascii
  if(ascii == T) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)
  
  message("Done.\n")
  return(banco)
}