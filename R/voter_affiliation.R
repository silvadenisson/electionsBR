#' Download data on voters' affiliation to political parties
#'
#' \code{voter_affiliation()} downloads and cleans data on voters' affiliation to Brazilian political parties by state.
#'  The function returns a \code{data.frame} where each observation corresponds to a voter.
#'
#' @note Data on party affiliation is uptadet on a daily basis, therefore it may vary depending on the day it is collected.
#' 
#' @param party \code{character} vector containing the acronym of the parties with an official record on TSE.
#' Spaces in the name of some parties (i.g. PC do B) must be preserved.
#' 
#' @param uf \code{character} vector containing the acronym of the states of the federation.
#' 
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#' 
#' @param encoding Data original encoding (defaults to 'windows-1252'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @return \code{voter_affiliation()} returns a \code{data.frame} with the following variables:
#'
#' \itemize{
#'   \item DATA_DA_EXTRACAO: Generation date of the file (when the data was compilled).
#'   \item HORA_DA_EXTRACAO: Generation date of the file (when the data was compilled), Brasilia time.
#'   \item NUMERO_DA_INSCRICAO: Voter's electoral ID.
#'   \item NOME_DO_FILIADO: Voter's name.
#'   \item SIGLA_DO_PARTIDO: Voter's party acronym.
#'   \item NOME_DO_PARTIDO: Voter's party name.
#'   \item UF: State of the federation.
#'   \item CODIGO_DO_MUNICIPIO: Municipality's Supreme Electoral Court code (number).
#'   \item NOME_DO_MUNICIPIO: Municipality's name.
#'   \item ZONA_ELEITORAL: Electoral zone number.
#'   \item SECAO_ELEITORAL: Electoral section number.
#'   \item DATA_DA_FILIACAO: Date when the voter registered her affiliation.
#'   \item SITUACAO_DO_REGISTRO: Voter's register situation.
#'   \item TIPO_DO_REGISTRO: Register type.
#'   \item DATA_DO_PROCESSAMENTO: Generation date of the register (when the register was compilled).
#'   \item DATA_DA_DESFILIACAO: Date of de-affiliation (when applicable).
#'   \item DATA_DO_CANCELAMENTO: Date when the register was cancelled (when applicable).
#'   \item DATA_DA_REGULARIZACAO: Date when the register was regularized (when applicable).
#'   \item MOTIVO_DO_CANCELAMENTO: Justification used to cancel the register (when applicable).
#' }
#' 
#' @importFrom magrittr "%>%"
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#' df <- voter_affiliation("PT", "DF")
#' 
#' df <- voter_affiliation(c("PT", "PC do B"), "DF")
#' 
#' df <- voter_affiliation(c("PT", "PC do B"), c("DF", "MG", "AL"))
#' }

voter_affiliation <- function(party, uf, ascii = FALSE, encoding = "windows-1252"){
  
  
  # Inputs
  if(!is.logical(ascii)) stop("'ascii' must be TRUE or FALSE.")
  test_encoding(encoding)
  party <- tolower(party)
  party <- gsub(" ", "_", party)
  uf <- tolower(uf)
  
  # Download data
  dados <- tempfile()
  local <- tempdir()
  
  links <- rep(party, each = length(uf)) %>%
    sprintf("http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_%s_%s.zip", ., uf)
  
  sapply(links, function(x){
    
    download.file(x, dados)
    unzip(dados, exdir = local)
  })
  
  # Join data
  message("Processing the data...")
  orig <- getwd()
  setwd(paste0(local, "/aplic/sead/lista_filiados/uf/"))
  
  banco <- Sys.glob("*.csv") %>%
    lapply(function(x) tryCatch(read.csv2(x, stringsAsFactors = F, fileEncoding =  "windows-1252"), error = function(e) NULL)) %>%
    do.call("rbind", .)
  
  names(banco) <- gsub("\\.", "_", names(banco))
  
  unlink(dados)
  unlink(local, recursive = T)
  setwd(orig)
  
  # Change to ascii
  if(ascii) banco <- to_ascii(banco, encoding)
  
  message("Done.\n")
  banco
}
