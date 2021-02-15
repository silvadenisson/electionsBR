#' Download data on candidate electoral results in local elections in Brazil by electoral section
#'
#' \code{vote_section_local()} downloads and cleans data on the verification of local elections in Brazil,
#' disaggregated by electoral section. Different from other electionsBR's functions, results are only extract for individual states, one at a time. The function returns a \code{data.frame} where each observation
#' corresponds to an electoral section in a given Brazilian state.
#'
#' @note For the elections prior to 2002, some information can be incomplete.
#'
#' @param year Election year. For this function, only the years 1996, 2000, 2004, 2008, 2012, 2016 and 2020
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
#' @param temp (\code{logical}). If \code{TRUE}, keep the temporary compressed file for future use (recommended)
#'
#' @details If export is set to \code{TRUE}, the data is saved as .dta and .sav
#'  files in the working directory.
#'
#' @return \code{vote_section_local()} returns a \code{data.frame} with the following variables:
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
#' @seealso \code{\link{vote_section_fed}} for federal elections in Brazil.
#'
#' @import utils
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- vote_section_local(2000)
#' }

vote_section_local <- function(year, uf = "AC", ascii = FALSE, 
                               encoding = "latin1",
                               export = FALSE,
                               temp = TRUE){
  
  
  # Test the inputs
  test_encoding(encoding)
  test_local_year(year)
  stopifnot(is.character(uf))
  if(tolower(uf) == "all") stop("'uf' is invalid. Please, check the documentation and try again.")
  uf <- test_uf(uf)
  
  if(year < 2012){
    
    filenames  <- paste0("/votacao_secao_", year, "_", uf, ".zip")
    dados <- paste0(file.path(tempdir()), filenames)
    url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/votacao_secao%s"
    
    # Downloads the data
    download_unzip(url, dados, filenames, year)
    
    message("Download the data One...")
    
    # remover temp file
    if(temp == FALSE){
      unlink(dados)
    }
    
    # Clean the data
    setwd(as.character(year))
    banco <- juntaDados(uf, encoding, FALSE)
    setwd("..")
    unlink(as.character(year), recursive = T)
    
  } 
  
  if(year == 2012) {
    message("Download the data One...")
    
    filenames  <- paste0("/vsec_1t_", uf, ".zip")
    dados <- paste0(file.path(tempdir()), filenames)
    url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/votosecao%s"
    
    # Downloads the data
    download_unzip(url, dados, filenames, year)
    
    # remover temp file
    if(temp == FALSE){
      unlink(dados)
    }
    
    # Clean the data
    setwd(as.character(year))
    banco1 <- juntaDados(uf, encoding, FALSE)
    setwd("..")
    unlink(as.character(year), recursive = T)
    
    
    if(!(uf %in% c("AL", "DF", "GO", "PE", "RR", "SE", "TO"))){
      
      message("Download the data two...")
      
      filenames  <- paste0("/vsec_2t_", uf, "_30102012194527.zip")
      dados2 <- paste0(file.path(tempdir()), filenames)
      url <- "https://cdn.tse.jus.br/estatistica/sead/odsele/votosecao%s"
      
      # Downloads the data
      download_unzip(url, dados2, filenames, year)
      
      # remover temp file
      if(temp == FALSE){
        unlink(dados2)
      }
      
      
      message("Processing the data two...")
      
      # Clean the data
      setwd(paste0("./", year, "2"))
      banco2 <- juntaDados(uf, encoding, FALSE)
      setwd("..")
      unlink(paste0("./", year, "2"), recursive = T)
      
    }else{
      banco2 <- NULL
    }
    
    banco <- rbind(banco1, banco2)
  }
  
  if(year == 2016) {
        message("Download the data One...")
        dados <- tempfile()
        sprintf("http://agencia.tse.jus.br/estatistica/sead/odsele/votacao_secao/votacao_secao_2016_%s.zip", 
                uf) %>% download.file(dados)
        unzip(dados, exdir = paste0("./", year))
        unlink(dados)
        message("Processing 2016 data...")
        setwd(as.character(year))
        banco <- juntaDados(uf, encoding, FALSE)
        setwd("..")
        unlink(as.character(year), recursive = T)
        
    }
  
  # Change variable names
  names(banco) <- c("DATA_GERACAO", "HORA_GERACAO", "ANO_ELEICAO", "NUM_TURNO", "DESCRICAO_ELEICAO", "SIGLA_UF",
                        "SIGLA_UE", "CODIGO_MUNICIPIO", "NOME_MUNICIPIO", "NUMERO_ZONA", "NUMERO_SECAO", "CODIGO_CARGO", 
                        "DESCRICAO_CARGO","NUM_VOTAVEL", "QTDE_VOTOS")

  
  # Change to ascii
  if(ascii == T) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)
  
  message("Done.\n")
  return(banco)
}
