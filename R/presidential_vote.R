#' Download, clean, and transform data on presidential electoral runoff results by municipality
#'
#' \code{president_mun_vote()} downloads, cleans, and transforms data on presidential elections results
#' in the second round (runnoff elections) by municipality. The electoral results are, by default, reported as proportion.
#' 
#' @param year Election year (\code{integer}). For this function, only the years 1998, 2002, 2006, 2010, and 2014
#' are available.
#' 
#' @param prop Shoud the votes be reported as proportion? (Defaults to \code{TRUE}).
#' 
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#' 
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @details This functions includes results to BR and ZZ state acronyms: the first one considers the entire
#' country as a district; the second one considers voters living abroad as a district. For 2014 elections,
#' results are only available for these two state acronyms.
#'
#' @return \code{president_mun_vote()} returns a \code{tbl, data.frame} with the following variables:
#' 
#' \itemize{
#'   \item ANO_ELEICAO: Election year.
#'   \item SIGLA_UF: Unit of the Federation's acronym in which occurred the election.
#'   \item CODIGO_MUNICIPIO: Supreme Electoral code from the city where occurred the election.
#'   \item NOME_MUNICIPIO: Name of the city where occurred the election.
#'   \item SIGLA_PARTIDO: Party acronym.
#'   \item NOME_PARTIDO: Party name.
#'   \item NUMERO_PARTIDO: Party number.
#'   \item NOME_COLIGACAO: Coalition shortname.
#'   \item COMPOSICAO_LEGENDA: Party's shortname composition.
#'   \item TOTAL_VOTOS: Party total votes by state.
#' }
#' 
#' @seealso \code{\link{president_state_vote}} for presidential elections results by state;
#' \code{\link{legislative_mun_vote}} for legislative elections results by municipality;
#' and \code{\link{legislative_state_vote}} for legislative elections results by state.
#' 
#' @import dplyr
#' @importFrom magrittr "%>%"
#' @importFrom stats setNames
#' @export
#' @examples
#' \dontrun{
#' df <- president_mun_vote(2002)
#' }

president_mun_vote <- function(year, prop = TRUE, ascii = FALSE, encoding = "Latin-1"){
  
  # Input test
  if(!is.logical(prop)) stop("Invalid input. Please, check the documentation and try again.")
  test_fed_year(year)
  if(year == 1998) stop("There were no presidential runoff in 1998 election.")
  
  # Download and clean the data
  res <- suppressMessages(party_mun_zone_fed(year = year, ascii = ascii, encoding = encoding)) %>%
    dplyr::filter_(~NUM_TURNO == 2, ~DESCRICAO_CARGO %in% c("PRESIDENTE", "Presidente")) %>%
    dplyr::group_by_(~ANO_ELEICAO, ~SIGLA_UF, ~CODIGO_MUNICIPIO, ~NOME_MUNICIPIO, ~SIGLA_PARTIDO,
              ~NOME_PARTIDO, ~NUMERO_PARTIDO, ~NOME_COLIGACAO, ~COMPOSICAO_LEGENDA) %>%
    dplyr::summarise_(.dots = stats::setNames(list(~sum(QTDE_VOTOS_NOMINAIS %>% as.numeric, na.rm = T)), "TOTAL_VOTOS")) %>%
    dplyr::ungroup()
  
  # Conversion to porportion
  if(prop){
    
    res <- res %>%
      dplyr::group_by_(~SIGLA_UF, ~CODIGO_MUNICIPIO) %>%
      dplyr::mutate_(.dots = stats::setNames(list(~TOTAL_VOTOS / sum(TOTAL_VOTOS, na.rm = T)), "TOTAL_VOTOS")) %>%
      dplyr::ungroup()
  }
  
  class(res) <- class(res) %>%
    c("vote_mun")
  
  # Return
  message("Done.\n")
  return(res)
}


#' Download, clean, and transform data on presidential electoral runoff results by state
#'
#' \code{president_state_vote()} downloads, cleans, and transforms data on presidential elections results
#' in the second round (runnoff elections) by state. The electoral results are, by default, reported as proportion
#' 
#' @param year Election year (\code{integer}). For this function, only the years 2002, 2006, 2010, and 2014
#' are available.
#' 
#' @param prop Shoud the votes be reported as porportion? (Defaults to \code{TRUE}).
#' 
#' @param ascii (\code{logical}). Should the text be transformed from Latin-1 to ASCII format?
#'
#' @param encoding Data original encoding (defaults to 'Latin-1'). This can be changed to avoid errors
#' when \code{ascii = TRUE}.
#' 
#' @details This functions includes results to BR and ZZ state acronyms: the first one considers the entire
#' country as a district; the second one considers voters living abroad as a district. For 2014 elections,
#' results are only available for these two state acronyms.
#'
#' @return \code{president_state_vote()} returns a \code{tbl, data.frame} with the following variables:
#' 
#' \itemize{
#'   \item ANO_ELEICAO: Election year.
#'   \item SIGLA_UF: Unit of the Federation's acronym in which occurred the election.
#'   \item SIGLA_PARTIDO: Party acronym.
#'   \item NOME_PARTIDO: Party name.
#'   \item NUMERO_PARTIDO: Party number.
#'   \item NOME_COLIGACAO: Coalition shortname.
#'   \item COMPOSICAO_LEGENDA: Party's shortname composition.
#'   \item TOTAL_VOTOS: Party votos (or porportion) votes by state.
#' }
#' 
#' @seealso \code{\link{president_mun_vote}} for presidential elections results by municipality;
#' \code{\link{legislative_mun_vote}} for legislative elections results by municipality;
#' and \code{\link{legislative_state_vote}} for legislative elections results by state.
#' 
#' @import dplyr
#' @importFrom magrittr "%>%"
#' @importFrom stats setNames
#' @export
#' @examples
#' \dontrun{
#' df <- president_state_vote(2002)
#' }

president_state_vote <- function(year, prop = TRUE, ascii = FALSE, encoding = "Latin-1"){
  
  # Input test
  if(!is.logical(prop)) stop("Invalid input. Please, check the documentation and try again.")
  test_fed_year(year)
  if(year == 1998) stop("There were no presidential runoff in 1998 election.")
  
  # Download and clean the data
    res <- suppressMessages(party_mun_zone_fed(year = year, ascii = ascii, encoding = encoding)) %>%
      dplyr::filter_(~NUM_TURNO == 2, ~DESCRICAO_CARGO %in% c("PRESIDENTE", "Presidente")) %>%
      dplyr::group_by_(~ANO_ELEICAO, ~SIGLA_UF, ~SIGLA_PARTIDO, ~NOME_PARTIDO, ~NUMERO_PARTIDO,
                       ~NOME_COLIGACAO, ~COMPOSICAO_LEGENDA) %>%
      dplyr::summarise_(.dots = stats::setNames(list(~sum(QTDE_VOTOS_NOMINAIS %>% as.numeric, na.rm = T)), "TOTAL_VOTOS")) %>%
      dplyr::ungroup()
    
  
  # Conversion to proportion
  if(prop){
    
    res <- res %>%
      dplyr::group_by_(~SIGLA_UF) %>%
      dplyr::mutate_(.dots = stats::setNames(list(~TOTAL_VOTOS / sum(TOTAL_VOTOS, na.rm = T)), "TOTAL_VOTOS")) %>%
      dplyr::ungroup()
  }
  
  class(res) <- class(res) %>%
    c("vote_state")
  
  # Return
  message("Done.\n")
  return(res)
}
