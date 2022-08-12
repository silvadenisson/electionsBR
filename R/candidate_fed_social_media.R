#' Download data on the candidates' backgrounds in federal elections
#'
#' \code{candidate_fed_social_media()} downloads and aggregates data on the candidates' background who ran in
#' federal elections in Brazil. The function returns a \code{data.frame} where each observation
#' corresponds to a candidate.
#'
#'
#' @param year Election year (\code{integer}). For this function, only the years 2020
#' are available.
#' 
#' 
#' @param ascii (\code{logical}). Should the text be transformed from latin1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'latin1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @param export (\code{logical}). Should the downloaded data be saved in .dta and .sav in the current directory?
#' 
#' @param temp (\code{logical}). elections_rda
#'
#' @details If export is set to \code{TRUE}, the downloaded data is saved as .dta and .sav
#'  files in the current directory.
#'  
#'
#' @return \code{candidate_fed_social_media()} returns a \code{tbl, data.frame} with the following variables:
#'
#' \itemize{
#'   \item DATA_GERACAO: Generation date of the file (when the data was collected).
#'   \item HORA_GERACAO: Generation time of the file (when the data was collected), Brasilia Time.
#'   \item ANO_ELEICAO: Election year.
#'   \item CD_TIPO_ELEICAO:
#'   \item NM_TIPO_ELEICAO:
#'   \item CD_ELEICAO:
#'   \item DESCRICAO_ELEICAO: Description of the election.
#'   \item SEQUENCIAL_CANDIDATO: Candidate's sequence number generated internally by the electoral
#'   systems. It is not the candidate's campaign number.
#'   \item NR_ORDEM:
#'   \item DS_URL:
#' }
#' 
#' @seealso \code{\link{candidate_local}} for local elections in Brazil.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- candidate_fed_social_media(2022)
#' }

candidate_fed_social_media <- function(year,
                          ascii = FALSE, encoding = "latin1", 
                          export = FALSE, temp = TRUE){
  #provisorio
  uf = "all"
  br_archive = FALSE
  
  # Input tests
  test_encoding(encoding)
  test_fed_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)
  

  filenames  <- paste0("/rede_social_candidato_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/consulta_cand%s"
  
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

  
  # Change to ascii
  if(ascii) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)
  
  message("Done.\n")
  return(banco)
}
