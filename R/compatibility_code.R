#' Function for downloading compatibility codes with data from various public institutions, such as TSE, IBGE and Central Bank., by backup salve in platform OSF.
#'
#' The \code{compatibility_code()} function is a wrapper compatibility codes with data from various public institutions, such as TSE, IBGE and Central Bank.
#'
#'
#' @return \code{compatibility_code()} returns a \code{data.frame}.
#'
#'
#' @import osfr
#' 
#' @export
#' @examples
#' \dontrun{
#' # Download data compatibility
#' code <- compatibility_code()
#' }

compatibility_code <- function(){
  
  projeto <- osfr::osf_retrieve_node("kshwc")
  arquivos <- osfr::osf_ls_files(projeto)
  
  down <- osfr::osf_download(arquivos, conflicts = T)
  
  banco <- read.csv(down$local_path)
  
  unlink(down$local_path,  recursive = T)
  
  names(banco)[c(3, 6, 9)] <- c("SG_UE", "NM_UE", "SG_UF")
  
  return(banco)
}
