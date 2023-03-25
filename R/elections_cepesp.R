#' function elections data from cepesp API
#' 
#' @param year From 1998 to 2018 for President, Governor, Senator, Federal Deputy, 
#' State Deputy or District Deputy , and  from 2000 to 2016 for Mayor or Councillor
#' 
#' @param type data type, candidate, vote
#' 
#' @param position President, Governor, Senator, Federal Deputy, State Deputy,
#' District Deputy, Mayor or Councillor
#' 
#' @param data_table return a data.table
#' 
#'  @return \code{elections_tse()} returns a \code{tibble}.
#' 
#' @import utils
#' @importFrom magrittr "%>%"
#' 
#' @export
#' @examples
#' \dontrun{
#' df <- elections_cepesp(2018, type = "candidate", "President")
#' }


elections_cepesp <- function(year, type, position, data_table = FALSE){
  
  if(!type %in% c("candidate", "vote")) stop("Not disponible. Please, only candidate, vote, filiates.\n")
    
  if(!year %in% c(seq(2000, 2016, 4), seq(1998, 2018, 4))) stop("Invalid input. Please, check the documentation and try again.")
  
  if(!year %in% seq(1998, 2018, 4)){
    
     nposition <- switch(position,
                         "President"= 1,
                         "Governor"= 3,
                         "Senator"= 5,
                         "Federal Deputy"= 6,
                         "State Deputy"= 7,
                         "District Deputy"= 8)
  } else{
     
    nposition <- switch("Mayor",
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
 
 endpoint <- paste0(base, 'api/consulta/athena/query')
 
 response <- httr::GET(endpoint, query = params) %>%
   httr::content(type = "application/json", encoding = "UTF-8")

 dados <- data.table::fread(paste0("https://cepesp.io/api/consulta/athena/result?id=",
                                   response$id ,"&ignore_version=true")) #%>%
   #dplyr::as_tibble()
  
 if(data_table) dados <- data.table::data.table(dados)
 
 message("Done.\n")
 return(dados)
  
}
