#' Reads and rbinds multiple data.frames in the same directory
#'
#' @export
#' @import utils
#' @importFrom magrittr %>%
#' @param encoding Data original encoding (defaults to 'windows-1252'). This can be changed to avoid errors
juntaDados <- function(encoding){

  banco <- Sys.glob("*.txt") %>%
    lapply(function(x) tryCatch(read.table(x, header = F, sep = ";", stringsAsFactors = F, fill = T, fileEncoding = encoding), error = function(e) NULL))

  nCols <- sapply(banco, ncol)
  banco <- banco[nCols == Moda(nCols)] %>%
    do.call("rbind", .)

  banco
}

# Calculates the mode of a distribution
Moda <- function(x) names(sort(-table(unlist(x))))[1]


# Tests federal election year inputs
test_fed_year <- function(year){

  if(!is.numeric(year) | length(year) != 1 | !year %in% seq(1998, 2014, 4)) stop("Invalid input. Please, check the documentation and try again.")
}


# Tests federal election year inputs
test_local_year <- function(year){

  if(!is.numeric(year) | length(year) != 1 | !year %in% seq(1996, 2016, 4)) stop("Invalid input. Please, check the documentation and try again.")
}


# Converts electoral data from Latin-1 to ASCII
#' @import dplyr
to_ascii <- function(banco, encoding){
  
  dplyr::mutate_if(banco, is.character, dplyr::funs(iconv(., from = encoding, to = "ASCII//TRANSLIT")))
}


# Converts electoral data from Latin-1 to ASCII
test_encoding <- function(encoding){
  
  if(!encoding %in% tolower(iconvlist())) stop("Invalid encoding. Check iconvlist() to view a list with all valid encodings.")
}


# Avoid the R CMD check note about magrittr's dot
utils::globalVariables(".")

