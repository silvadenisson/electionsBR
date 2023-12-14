# Startup message
.onAttach <- 
  function(libname, pkgname) {
    packageStartupMessage("\nTo cite electionsBR in publications, use: citation('electionsBR')")
    packageStartupMessage("To learn more, visit: http://electionsbr.com\n")
  }


#' Returns a vector with the abbreviations of all Brazilian states
#'
#' @export 

uf_br <- function() {
  
  c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA", 
    "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", "RJ", "RN", 
    "RO", "RR", "RS", "SC", "SE", "SP", "TO")
}


#' Returns a vector with the abbreviations of all Brazilian parties
#'
#' The character vector includes only parties that ran in elections from 1994 to 2022.
#'
#' @param year Election year (\code{integer}). For this function, only from 1994 to 2022
#' are available.
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' parties_election2002 <- parties_br(2002)
#' }

parties_br <- function(year) {

  # Input test
  test_year(year)

  if (year == 1994) {
    result <- c("PPR", "PT", "PMDB", "PRONA", "PL", "PDT", "PTB", "PSTU", "PFL",
                "PP", "PSB", "PV", "PSDB", "PC DO B", "PPS", "PMN", "PSC", "PRN",
                "PSD", "PRP", "PT DO B", "PTRB")

  } else if (year == 1996) {
    result <- c("PPB", "PT", "PMDB", "PSDB", "PFL", "PC DO B", "PSL", "PDT", "PMN",
                "PT DO B", "PTB", "PL", "PSB", "PV", "PSD", "PRP", "PRN", "PSTU",
                "PST", "PSC", "PPS", "PRTB", "PRONA", "PSDC", "PAN", "PCO", "PGT",
                "PCB", "PSN", "PTN")

  } else if (year == 1998) {
    result <- c("PT", "PMDB", "PFL", "PRONA", "PPB", "PSDB", "PDT", "PSTU", "PL",
                "PMN", "PSB", "PC do B", "PT do B", "PTB", "PPS", "PV", "PSL",
                "PRN", "PSD", "PAN", "PTN", "PRTB", "PSN", "PSC", "PRP", "PST",
                "PSDC", "PCB", "PGT", "PCO")

  } else if (year == 2000) {
    result <- c("PFL", "PSDB", "PPB", "PT", "PPS", "PRTB", "PMN", "PSB", "PV",
                "PC do B", "PMDB", "PTB", "PDT", "PT do B", "PSTU", "PL", "PRONA",
                "PSL", "PST", "PTN", "PSDC", "PRP", "PGT", "PSD", "PSC", "PRN",
                "PHS", "PAN", "PCB", "PCO")

  } else if (year == 2002) {
    result <- c("PT", "PMDB", "PSL", "PPS", "PRTB", "PTB", "PSB", "PSDB", "PPB",
                "PDT", "PST", "PSC", "PL", "PFL", "PMN", "PV", "PC do B", "PSDC",
                "PT do B", "PSTU", "PTN", "PAN", "PGT", "PHS", "PTC", "PRP",
                "PRONA", "PSD", "PCB", "PCO")

  } else if (year == 2004) {
    result <- c("PTB", "PT", "PSDB", "PMDB", "PSB", "PFL", "PDT", "PPS", "PMN",
                "PV", "PC do B", "PP", "PL", "PSDC", "PT do B", "PSL", "PSC", "PTN",
                "PRTB", "PRP", "PRONA", "PAN", "PTC", "PHS", "PSTU", "PCB", "PCO")

  } else if (year == 2006) {
    result <- c("PT", "PAN", "PSDC", "PRONA", "PSOL", "PPS", "PSDB", "PP", "PDT",
                "PFL", "PMDB", "PTB", "PRP", "PL", "PV", "PSB", "PC do B", "PRTB",
                "PMN", "PTN", "PTC", "PHS", "PT do B", "PCB", "PSC", "PSTU", "PRB",
                "PCO", "PSL")

  } else if (year == 2008) {
    result <- c("PT", "PSDB", "PP", "PMDB", "PRP", "PR", "PSB", "PMN", "PV", "PC do B",
                "PRB", "PTN", "PSOL", "PTC", "PPS", "DEM", "PSDC", "PT do B", "PHS",
                "PSC", "PTB", "PDT", "PSL", "PRTB", "PCB", "PSTU", "PCO")

  } else if (year == 2010) {
    result <- c("PRTB", "PSDB", "PT", "PP", "PPS", "PSOL", "PC do B", "PMDB", "PMN",
                "PSC", "PR", "PTN", "PRP", "PSDC", "PTC", "PV", "PDT", "PSB", "DEM",
                "PTB", "PRB", "PHS", "PT do B", "PSL", "PCB", "PSTU", "PCO")

  } else if (year == 2012) {
    result <- c("DEM", "PMN", "PDT", "PP", "PMDB", "PSDC", "PC do B", "PT", "PSDB",
                "PTB", "PRP", "PPS", "PSD", "PSB", "PR", "PSL", "PRB", "PV", "PTN",
                "PSC", "PT do B", "PPL", "PRTB", "PHS", "PTC", "PSOL", "PSTU",
                "PCB", "SD", "PCO")

  } else if (year == 2014) {
    result <- c("PSB", "PSDB", "PT do B", "PC do B", "PSD", "PHS", "DEM", "PDT", "PP",
                "PT", "PRP", "PTN", "PRB", "PSDC", "PSOL", "PEN", "PV", "PPS", "SD",
                "PR", "PPL", "PMN", "PSC", "PTC", "PMDB", "PSL", "PTB", "PROS",
                "PRTB", "PCB", "PSTU", "REDE", "PCO")

  } else if (year == 2016) {
    result <- c("PTC", "PR", "REDE", "PSDC", "PTN", "PC do B", "PRB", "PSD", "DEM",
                "PHS", "PT", "PSB", "PROS", "PMDB", "PSL", "PSDB", "PDT", "PP", "PRP",
                "PMB", "PV", "PSC", "PTB", "PSOL", "PMN", "SD", "PPS", "PT do B",
                "PRTB", "PPL", "PSTU", "PCB", "PCO", "SOLIDARIEDADE", "NOVO")

  } else if (year == 2018) {
    result <- c("PTC", "DEM", "PT", "PR", "PSL", "PSDB", "PSB", "MDB", "PSOL", "PDT",
                "PTB", "REDE", "PRTB", "SOLIDARIEDADE", "PPS", "PMB", "PRB", "PROS", "PPL",
                "PP", "PRP", "PHS", "PMN", "PSD", "PSC", "PV", "PODE", "DC", "PATRIOTA",
                "AVANTE", "PC do B", "PCO", "PSTU", "NOVO", "PCB", "PL")

  } else if (year == 2020) {
    result <- c("MDB", "PL", "PSD", "PT", "PSDB", "PROS", "PP", "PDT", "PSB", "SOLIDARIEDADE",
                "PSL", "CIDADANIA", "PSC", "PTB", "PC do B", "REPUBLICANOS", "DEM",
                "PSOL", "PATRIOTA", "PCO", "AVANTE", "PODE", "DC", "PMB", "PV",
                "PMN", "PCB", "PRTB", "REDE", "PTC", "UP", "PSTU", "NOVO")

  }

  return(result)
}


# Reads and rbinds multiple data.frames in the same directory
#' @import dplyr
juntaDados <- function(uf, encoding, br_archive){

   archive <- Sys.glob("*")[grepl(".pdf", Sys.glob("*")) == FALSE] %>%
      .[grepl(uf, .)] %>%
      file.info() %>%
      .[.$size > 200, ] %>%
      row.names()
   
   if(!br_archive){
     
     archive <- archive[grepl("BR", archive) == FALSE]
     
   } else {
     
     archive <- archive[grepl("BR\\.|BRASIL", archive) == TRUE]
   }
   
   if(grepl(".csv", archive[1])){
     test_col_names <- TRUE
   }else{
     test_col_names <- FALSE
   }
   
   lapply(archive, function(x) tryCatch(
     suppressWarnings(readr::read_delim(x, col_names = test_col_names, 
                                        delim = ";",
                                        locale = readr::locale(encoding = encoding), 
                                        col_types = readr::cols(), progress = F,
                                        escape_double = F)), 
     error = function(e) NULL)) %>%
     data.table::rbindlist() %>%
     dplyr::as_tibble()

}


# Converts electoral data from Latin-1 to ASCII
#' @import dplyr
to_ascii <- function(banco, encoding){
  
  if(encoding == "Latin-1") encoding <- "latin1"
  dplyr::mutate_if(banco, is.character, dplyr::funs(iconv(., from = encoding, to = "ASCII//TRANSLIT")))
}


# Tests election year inputs
test_year <- function(year){

  if (!is.numeric(year) | length(year) != 1 | !year %in% seq(1998, 2022, 2)) stop("Invalid input. Please, check the documentation and try again.")
}


# Tests federal election year inputs
test_fed_year <- function(year){
  
  if(!is.numeric(year) | length(year) != 1 | !year %in% seq(1998, 2018, 4)) stop("Invalid input. Please, check the documentation and try again.")
}


# Tests federal election year inputs
test_local_year <- function(year){
  
  if(!is.numeric(year) | length(year) != 1 | !year %in% seq(2000, 2016, 4)) stop("Invalid input. Please, check the documentation and try again.")
}


test_type <- function(type){
  
  if(!is.character(type) | length(type) != 1 | !type %in% c("candidate",
                                                            "vote_mun_zone",
                                                            "details_mun_zone",
                                                            "legends",
                                                            "party_mun_zone",
                                                            "personal_finances",
                                                            "seats",
                                                            "vote_section",
                                                            "voter_profile_by_section",
                                                            "voter_profile",
                                                            "social_media")) stop("Invalid input. Please, check the documentation and try again.")
}



# Converts electoral data from Latin-1 to ASCII
test_encoding <- function(encoding){
  if(encoding == "Latin-1") encoding <- "latin1"
  
  if(!encoding %in% tolower(iconvlist())) stop("Invalid encoding. Check iconvlist() to view a list with all valid encodings.")
}


# Test br types
test_br <- function(br_archive){
  
  if(!is.logical(br_archive)) message("'br_archive' must be logical (TRUE or FALSE).")
}


# Tests state acronyms
test_uf <- function(uf) {
  
  uf <- gsub(" ", "", uf) %>%
    toupper()
  
  uf <- match.arg(uf, c("AC", "AL", "AM", "AP", "BA", "CE", "DF", "ES", "GO", "MA", 
                        "MG", "MS", "MT", "PA", "PB", "PE", "PI", "PR", "RJ", "RN", 
                        "RO", "RR", "RS", "SC", "SE", "SP", "TO", "ALL"), several.ok = T)
  
  if("ALL" %in% uf) return(".")
  else return(paste(uf, collapse = "|"))
}



# Function to export data to .dta and .sav
export_data <- function(df) {
  
  haven::write_dta(df, "electoral_data.dta")
  haven::write_sav(df, "electoral_data.sav")
  message(paste0("Electoral data files were saved on: ", getwd(), ".\n"))
}


# Data download
download_unzip <- function(url, dados, filenames, year){
  
  if(!file.exists(dados)){
    
    sprintf(url, filenames) %>%
      httr::GET(httr::write_disk(path = dados, overwrite = TRUE),
                httr::progress(),
                httr::user_agent(sorteia_user_agent()))
    
    message("Processing the data...")
    unzip(dados, exdir = paste0("./", year))
    
  } else{
    
    message("Processing the data...")
    unzip(dados, exdir = paste0("./", year))
  }
}


# Função para sortear diferentes user agents
sorteia_user_agent <- function(){
  
  usrs <- c("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36",
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.246",
            "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_2) AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Safari/601.3.9",
            "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1",
            "Mozilla/5.0 (X11; CrOS x86_64 8172.45.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.64 Safari/537.36")
  
  sample(usrs, 1)
}


# Avoid the R CMD check note about magrittr's dot
utils::globalVariables(".")

