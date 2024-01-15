#' Retrieve electoral data from the cepesp API.
#' 
#' @param year The election year. Valid options are between 1998 to 2018 for positions such as President, Governor, Senator, Federal Deputy, State Deputy, and District Deputy. For Mayor or Councillor positions, valid options range from 2000 to 2016.
#' 
#' @param type The type of data to retrieve. Valid options are "candidate" or "vote".
#' 
#' @param position The position for which the data is requested. Valid options are President, Governor, Senator, Federal Deputy, State Deputy, District Deputy, Mayor, or Councillor.
#' 
#' @param data_table If set to TRUE, the function will return the data as a data.table object. Default is FALSE.
#' 
#' @return The function returns a tibble containing the requested elections data.
#' 
#' @note The function is a wrapper for the cepesp API. To learn more about the API, please visit cepespdata.io.
#' 
#' @import utils
#' @importFrom magrittr "%>%"
#' 
#' @export
#' @examples
#' \dontrun{
#' df <- elections_cepesp(2018, type = "candidate", position = "President")
#' }

elections_cepesp <- function(year, type, position, data_table = FALSE){
  
  if(!type %in% c("candidate", "vote")) stop("Not disponible. Please, only candidate, vote, filiates.\n")
    
  if(!year %in% c(seq(2000, 2016, 4), seq(1998, 2018, 4))) stop("Invalid input. Please, check the documentation and try again.")
  
  if(year %in% seq(1998, 2018, 4)){
    
     nposition <- switch(position,
                         "President"= 1,
                         "Governor"= 3,
                         "Senator"= 5,
                         "Federal Deputy"= 6,
                         "State Deputy"= 7,
                         "District Deputy"= 8)
  } else{
     
    nposition <- switch(position,
                         "Mayor"= 11,
                         "Councillor"=13)
  }
  
  
 tab <- switch(type,
               "candidate" = "candidatos",
               "vote" = "votos")
  
  
 base <- "https://cepesp.io/"
  
 params <- list(table=tab,
                cargo=nposition,
                anos=year)
 
 endpoint <- paste0(base, 'api/consulta/athena/query?table=', tab, '&anos=', year, '&cargo=', nposition,
                    '&c[]=ANO_ELEICAO&c[]=SIGLA_UE&c[]=NOME_UF&c[]=NUM_TURNO&c[]=DESCRICAO_UE&c[]=DESCRICAO_CARGO&c[]=SIGLA_PARTIDO&c[]=NUMERO_CANDIDATO&c[]=CPF_CANDIDATO&c[]=NOME_URNA_CANDIDATO&c[]=DESCRICAO_SEXO&c[]=DESC_SIT_TOT_TURNO&c[]=QTDE_VOTOS')
 
 
 response <- httr::GET(endpoint) #, query = params) 
 
 result <-  httr::content(response, type = "application/json", encoding = "UTF-8") 
 
 tmp <- tempfile()
 url <- httr::modify_url("https://cepesp.io/api/consulta/athena/result",
              query = list(id = result$id,  r_ver="1.0.2" ))
 
 req <- curl::curl_download(url, tmp, quiet=FALSE)
                            
 dados <- data.table::fread(tmp, sep = ",",
                            header = T,
                            keepLeadingZeros=TRUE) %>%
   dplyr::as_tibble()
 
 if(data_table) dados <- data.table::data.table(dados)
 
 message("Done.\n")
 return(dados)
  
}
