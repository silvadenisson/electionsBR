#' Download data on federal candidates' personal financial disclosures
#'
#' \code{personal_finances_local()} downloads and aggregates the data on federal candidates' personal financial disclosures. The function returns a \code{data.frame} where each observation corresponds to a candidate's property.
#'
#' @note For the elections prior to 2000, some information may be incomplete.
#'
#' @param year Election year. For this function, only the years 2006, 2010, 2014 and 2018 are available.
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
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
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
#' From 2018 on, some new variables are also available:
#' \itemize{
#'   \item COD_TIPO_ELEICAO: Election type code.
#'   \item NOME_TIPO_ELEICAO: Election type.
#'   \item COD_ELEICAO: Election code.
#'   \item DATA_ELEICAO: Election date.
#'   \item ABRANGENCIA: Election scope.
#'   \item NOME_UE: Electoral unit name.
#'   \item NUMERO_ORDEM_CANDIDATO: Candidate's ordinal number.
#'   \item DT_ULTIMA_ATUALIZACAO: Date when last updated.
#'   \item HH_ULTIMA_ATUALIZACAO: Hour when last updated.
#'}
#'
#' @seealso \code{\link{personal_finances_local}} for personal financial disclosures of running candidates in local elections.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- personal_finances_fed(2006)
#' }

personal_finances_fed <- function(year, uf = "all",
                                  br_archive = FALSE, 
                                  ascii = FALSE, 
                                  encoding = "latin1", 
                                  export = FALSE,
                                  temp = TRUE){
  
  # Input tests
  test_encoding(encoding)
  test_fed_year(year)
  uf <- test_uf(uf)
  test_br(br_archive)
  
  if(year < 2006) stop("Not disponible. Please, check the documentation and try again.\n")
    
  filenames  <- paste0("/bem_candidato_", year, ".zip")
  dados <- paste0(file.path(tempdir()), filenames)
  url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/bem_candidato%s"
  
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
    
    # Changes variables names
    if(year < 2014){
      names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "DESCRICAO_ELEICAO",
                        "SIGLA_UF", "SQ_CANDIDATO", "CD_TIPO_BEM_CANDIDATO", "DS_TIPO_BEM_CANDIDATO",
                        "DETALHE_BEM", "VALOR_BEM", "DATA_ULT_TOTALIZACAO", "HORA_ULT_TOTALIZACAO")
    } else{
      names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "COD_TIPO_ELEICAO", "NOME_TIPO_ELEICAO",      
                         "COD_ELEICAO", "DESCRICAO_ELEICAO", "DATA_ELEICAO", "SIGLA_UF", "SIGLA_UE",               
                         "NOME_UE", "SQ_CANDIDATO", "NUMERO_ORDEM_CANDIDATO", "CD_TIPO_BEM_CANDIDATO",
                         "DS_TIPO_BEM_CANDIDATO", "DETALHE_BEM", "VALOR_BEM", "DT_ULTIMA_ATUALIZACAO",
                         "HH_ULTIMA_ATUALIZACAO")
    }
    
    
    # Change to ascii
    if(ascii == T) banco <- to_ascii(banco, encoding)
    
    # Export
    if(export) export_data(banco)
    
    message("Done.\n")
    return(banco)
} 

  