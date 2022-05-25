#' Download data on local election coalitions in Brazil
#'
#' \code{legend_local()} downloads and aggregates the party denomonations (coalitions or parties) from the local elections in Brazil,
#' disaggregated by cities. The function returns a \code{data.frame} where each observation
#' corresponds to a city.
#'
#'
#' @param year Election year. For this function, only the years  2008, 2012 and 2016
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
#' @return \code{legend_local()} returns a \code{data.frame} with the following variables:
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
#' @seealso \code{\link{legend_fed}} for federal elections in Brazil.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- legend_local(2000)
#' }

legend_local <- function(year, uf = "all", 
                         ascii = FALSE, 
                         encoding = "latin1", 
                         export = FALSE,
                         temp = TRUE){


  # Test the input
  test_encoding(encoding)
  test_local_year(year)
  uf <- test_uf(uf)
  
    
    filenames  <- paste0("/consulta_coligacao_", year, ".zip")
    dados <- paste0(file.path(tempdir()), filenames)
    url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/consulta_coligacao%s"
    
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
    names(banco) <- c("DATA_GERACAO",	"HORA_GERACAO",	"ANO_ELEICAO",	"COD_TIPO_ELEICAO",
                      "NOME_TIPO_ELEICAO",	"NUM_TURNO",	"COD_ELEICAO",	"DESCRICAO_ELEICAO",
                      "DATA_ELEICAO",	"SIGLA_UF",	"SIGLA_UE",	"NOME_MUNICIPIO",	"CODIGO_CARGO",
                      "DESCRICAO_CARGO",	"AGREMIACAO",	"NUMERO_PARTIDO",	"SIGLA_PARTIDO",
                      "NOME_PARTIDO",	"SEQUENCIAL_COLIGACAO",	"NOME_COLIGACAO",
                      "COMPOSICAO_COLIGACAO",	"COD_SITUACAO_LEGENDA",	"DES_SITUACAO")
    
    # Change to ascii
    if(ascii == T) banco <- to_ascii(banco, encoding)
    
    # Export
    if(export) export_data(banco)
    
    message("Done.\n")
    return(banco)
  

 
}
