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
#' The character vector includes only parties that ran in elections in 2016.
#' 
#' @export

parties_br <- function() {
  
  c("PPS", "PSB", "PSOL", "PP", "PSL", "PR", "PSDB", "PDT", "PSDC", 
    "PHS", "PT", "PROS", "PTC", "PSC", "PC do B", "PRB", "PMDB", 
    "DEM", "PMB", "PTB", "PEN", "PTN", "SD", "PMN", "PT do B", "PSD", 
    "PV", "PRP", "REDE", "PPL", "PRTB", "PSTU", "PCB", "PCO", "NOVO")
}


# Reads and rbinds multiple data.frames in the same directory
#' @import dplyr
juntaDados <- function(str_file_path, uf, encoding, br_archive){
  str_file_path <- gsub(pattern = '(^.*?)(\\/$)',
                        replacement = '\\1',
                        x = str_file_path)
  archive <- Sys.glob(paste0(str_file_path, "/*"))[grepl(".pdf", Sys.glob(paste0(str_file_path, "/*"))) == FALSE] %>%
    .[grepl(uf, .)] %>%
    file.info() %>%
    .[.$size > 200,] %>%
    row.names()
   
   if(!br_archive){
     
     archive <- archive[grepl("BR", archive) == FALSE]
     
   } else {
     
     archive <- archive[grepl("BR", archive) == TRUE]
   }
   
   if(grepl(".csv", archive[1])){
     test_col_names <- TRUE
   }else{
     test_col_names <- FALSE
   }
   
  lapply(archive, function(x) tryCatch(suppressWarnings(readr::read_delim(x, col_names = test_col_names, delim = ";", locale = readr::locale(encoding = encoding), col_types = readr::cols(), progress = F)), 
                                error = function(e) NULL)) %>%
  data.table::rbindlist() %>%
  dplyr::as.tbl()

}


# Converts electoral data from Latin-1 to ASCII
#' @import dplyr
to_ascii <- function(banco, encoding){
  
  if(encoding == "Latin-1") encoding <- "latin1"
  dplyr::mutate_if(banco, is.character, dplyr::funs(iconv(., from = encoding, to = "ASCII//TRANSLIT")))
}


# Tests federal election year inputs
test_fed_year <- function(year){

  if(!is.numeric(year) | length(year) != 1 | !year %in% seq(1994, 2018, 4)) stop("Invalid input. Please, check the documentation and try again.")
}


# Tests federal election year inputs
test_local_year <- function(year){

  if(!is.numeric(year) | length(year) != 1 | !year %in% seq(1996, 2016, 4)) stop("Invalid input. Please, check the documentation and try again.")
}


# Test federal positions
#test_fed_position <- function(position){
#  position <- tolower(position)
#  if(!is.character(position) | length(position) != 1 | !position %in% c("presidente",
#                                                                        "governador",
#                                                                        "senador",
#                                                                        "deputado federal",
#                                                                        "deputado estadual",
#                                                                        "deputado distrital")) stop("Invalid input. Please, check the documentation and try again.")
#}


# Test federal positions
#test_local_position <- function(position){
#  position <- tolower(position)
#  if(!is.character(position) | length(position) != 1 | !position %in% c("prefeito",
#                                                                        "vereador")) stop("Invalid input. Please, check the documentation and try again.")
#}


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

# Replace position by cod position
# replace_position_cod <- function(position){
#  position <- tolower(position)
#  return(switch(position, "presidente" = 1,
#         "governador" = 3,
#         "senador" = 5,
#         "deputado federal" = 6,
#         "deputado estadual" = 7,
#         "deputado distrital" = 8,
#         "prefeito" = 11,
#         "vereador" = 13))
# }

# Function to export data to .dta and .sav
export_data <- function(df) {
  
  haven::write_dta(df, "electoral_data.dta")
  haven::write_sav(df, "electoral_data.sav")
  message(paste0("Electoral data files were saved on: ", getwd(), ".\n"))
}

get_file_remote_location <- function(str_file_name) {
  lst_file <- list(
    list("name" = "consulta_cand", "url" = "odsele/consulta_cand/consulta_cand_%year%.zip"),
    list("name" = "votacao_candidato_munzona", "url" = "odsele/votacao_candidato_munzona/votacao_candidato_munzona_%year%.zip"),
    list("name" = "consulta_vagas", "url" = "odsele/consulta_vagas/consulta_vagas_%year%.zip"),
    list("name" = "consulta_legendas", "url" = "odsele/consulta_legendas/consulta_legendas_%year%.zip"),
    list("name" = "consulta_coligacao", "url" = "odsele/consulta_coligacao/consulta_coligacao_%year%.zip"),
    list("name" = "votacao_partido_munzona", "url" = "odsele/votacao_partido_munzona/votacao_partido_munzona_%year%.zip"),
    list("name" = "detalhe_votacao_munzona", "url" = "odsele/detalhe_votacao_munzona/detalhe_votacao_munzona_%year%.zip"),
    list("name" = "votacao_secao", "url" = "odsele/votacao_secao/votacao_secao_%year%_%uf%.zip"),
    list("name" = "vsec_1t", "url" = "/eleicoes/eleicoes2012/votosecao/vsec_1t_%year%.zip"),
    list("name" = "vsec_2t", "url" = "eleicoes/eleicoes2012/votosecao/vsec_2t_%uf%_30102012194527.zip"),
    list("name" = "bem_candidato", "url" = "odsele/bem_candidato/bem_candidato_%year%.zip")
  )
  df_file <- do.call(rbind, lapply(lst_file, data.frame))
  df_file$url <- as.character(df_file$url)
  return(df_file[df_file$name == str_file_name, c('url')])
}

download_and_unzip_datafile <- function(str_endpoint, year) {
  str_base_url <- 'http://agencia.tse.jus.br/estatistica/sead/%s'

  tmp_data_file <- tempfile()
  download.file(sprintf(str_base_url, str_endpoint), tmp_data_file)
  unzip(tmp_data_file, exdir = paste0("./", year))
  unlink(tmp_data_file)
}

get_data <- function(str_data_name, year, uf, br_archive, ascii, encoding, export, data_names = NULL) {
  str_data_path <- getOption('electionsBR-data-path')

  str_remote_file_location <- get_file_remote_location(str_data_name)
  str_remote_file_location <- gsub(pattern = '%year%', replacement = year, x = str_remote_file_location)
  str_remote_file_location <- gsub(pattern = '%uf%', replacement = uf, x = str_remote_file_location)

  download_and_unzip_datafile(str_remote_file_location, year)

  str_tmp_dir <- tempdir()
  str_file_name <- basename(str_remote_file_location)
  
  if (is.null(str_data_path)) {
    message(
      paste(
        "Downloading data file to temporary path.",
        "To customize data file location set option electionsBR-data-path",
        "E.g. options('electionsBR-data-path' = 'my_data_path')",
        sep = " \n"
      )
    )
    str_file_name <- paste0(str_tmp_dir, "/", str_file_name)
    downlaod_file(str_remote_file_location, str_file_name)
  } else {
    str_file_name <- paste0(str_data_path, "/", str_file_name)
    if (!file.exists(str_file_name)) {
      downlaod_file(str_remote_file_location, str_file_name)
    }
  }
  
  br_archive <- (br_archive & (str_data_name %in% c("consulta_cand", "votacao_partido_munzona",
                                                    "bem_candidato", "consulta_vagas",
                                                    "detalhe_votacao_munzona", "consulta_legendas")))

  message("Processing the data...")
  tmp_sub_dir <- paste0(str_tmp_dir, "/", year)
  unzip(str_file_name, exdir = tmp_sub_dir)
  
  banco <- juntaDados(tmp_sub_dir, uf, encoding, br_archive)
  
  on.exit(unlink(str_tmp_dir, recursive = T))

  if (!is.null(data_names)) {
    names(banco) <- data_names
  }
  # Change to ascii
  if(ascii == T) banco <- to_ascii(banco, encoding)
  
  # Export
  if(export) export_data(banco)
  
  message("Done.\n")
  return(banco)
}

downlaod_file <- function(str_url_part, str_data_path) {
  str_url_base <- 'http://agencia.tse.jus.br/estatistica/sead/%s'
  message(sprintf("Downloading data to: %s", str_data_path))
  download.file(sprintf(str_url_base, str_url_part), str_data_path)
}

# Avoid the R CMD check note about magrittr's dot
utils::globalVariables(".")
