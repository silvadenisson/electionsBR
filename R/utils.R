#' Reads and rbinds multiple data.frames in the same directory
#'
#' @export
#' @import utils
#' @importFrom magrittr %>%
juntaDados <- function(){

  banco <- Sys.glob("*.txt") %>%
    lapply(function(x) tryCatch(read.table(x, header = F, sep = ";", stringsAsFactors = F, fill = T, fileEncoding = "windows-1252"), error = function(e) NULL))

  nCols <- sapply(banco, ncol)
  banco <- banco[nCols == Moda(nCols)] %>%
    do.call("rbind", .)

  banco
}

#' Calculates the mode of a distribution
#'
#' @param x A \code{numeric} vector
#'
#' @export
Moda <- function(x) names(sort(-table(unlist(x))))[1]


#' Tests federal election year inputs
#'
#' @param year A \code{numeric} vector of length == 1
#'
#' @export
test_fed_year <- function(year){

  if(!is.numeric(year) | length(year) != 1 | !year %in% seq(1998, 2014, 4)) stop("Invalid input. Please, check the documentation and try again.")
}


#' Tests federal election year inputs
#'
#' @param year A \code{numeric} vector of length == 1
#'
#' @export
test_local_year <- function(year){

  if(!is.numeric(year) | length(year) != 1 | !year %in% seq(1996, 2012, 4)) stop("Invalid input. Please, check the documentation and try again.")
}


# Avoid the R CMD check note about magrittr's dot
utils::globalVariables(".")

