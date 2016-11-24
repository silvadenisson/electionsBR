#' Download data on the filiados a partidos políticos
#'
#' \code{filiados()} downloads and aggregates data on the filiados a partidos por UF
#'  The function returns a \code{data.frame} where each observation
#' corresponds to a filiado.
#'
#' @note So coleta dados referente a partidos existente oficialmente no dia da coleta, em fundacao
#' e existintos nao estao disponiveis
#'
#' @param partido Partidos registrado no Tribunal Superior Eleitoral.
#' are available.
#' 
#' @param uf unidade da federacao (distritos) onde os partidos sao registrados
#'
#' @importFrom magrittr "%>%"
#' @export
#' @examples
#' \dontrun{
#' df <- filiados("PT", "DF")
#' 
#' df <- filiados(c("PT", ""PC do B"), "DF")
#' 
#' df <- filiados(c("PT", ""PC do B"), c("DF", "MG", "AL"))
#' }

filiados <- function(partido, uf){
  
  partido <- tolower(partido)
  partido <- gsub(" ", "_", partido)
  uf <- tolower(uf)

  dados <- tempfile()
  local <- tempdir()
  
  banco <- data.frame()
  for(i in 1:length(partido)){
    
    for(y in 1:length(uf)){
      
      sprintf("http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_%s_%s.zip", partido[i], uf[y]) %>%
        download.file(dados)
      unzip(dados, exdir = local)
      
      base <- read.csv2(paste0(local, "/aplic/sead/lista_filiados/uf/filiados_", partido[i], "_" , uf[y], ".csv"), 
                        stringsAsFactors = F, fileEncoding = "windows-1252")
      
      banco <- rbind(banco, base)
     
    }
  }
  
  unlink(dados)
  unlink(local)

  cat("Done.")
  
  return(banco)
  
}

