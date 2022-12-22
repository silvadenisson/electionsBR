## ---- echo=FALSE---------------------------------------------------------------------------
library(electionsBR)

## ---- eval=FALSE---------------------------------------------------------------------------
#  install.packages("electionsBR")

## ---- eval=FALSE---------------------------------------------------------------------------
#  if (!require("devtools")) install.packages("devtools")
#  devtools::install_github("silvadenisson/electionsBR")

## ---- eval=FALSE---------------------------------------------------------------------------
#  install.packages("electionsBR")
#  electionsBR::vote_mun_zone_fed(2010, export = TRUE)

## ---- eval=FALSE---------------------------------------------------------------------------
#  # Load the package
#  library(electionsBR)
#  
#  # Use vote_mun_zone_fed function to download 2014 election results
#  df <- vote_mun_zone_fed(2014)

## ---- eval=FALSE---------------------------------------------------------------------------
#  # Get results for the 2000 local elections
#  df <- vote_mun_zone_local(2000)

## ---- eval=FALSE---------------------------------------------------------------------------
#  # Get presidential electoral results by municipality in tidy format
#  pres_mun <- president_mun_vote(2010, prop = TRUE)
#  
#  # Get presidential electoral results by state in tidy format
#  pres_st <- president_state_vote(2010, prop = TRUE)

## ---- eval=FALSE---------------------------------------------------------------------------
#  # Get data on candidates running in local elections
#  df <- candidate_local(2016)
#  
#  # Get data on candidates running in federal elections
#  df <- candidate_fed(2016)

## ---- eval=FALSE---------------------------------------------------------------------------
#  # Get data on parties' electoral performances in the federal election of 2006
#  federal <- party_mun_zone_fed(2006)
#  
#  # Get data on parties' electoral performances in the local election of 2004
#  municipal <- party_mun_zone_local(2004)

## ---- eval=FALSE---------------------------------------------------------------------------
#  # Get data on voters' profile
#  voters02 <- voter_profile(2002)
#  voters04 <- voter_profile(2004)

## ---- eval=FALSE---------------------------------------------------------------------------
#  # PT (Brazilian Workers' Party) in Distrito Federal (DF)
#  df <- voter_affiliation("PT", "DF")
#  
#  # PSDB (Brazilian Social Democracy Party) in Sao Paulo (SP)
#  df <- voter_affiliation("PSDB", "SP")
#  
#  # PT and PC do B (Brazilian Communist Party) in DF, MG and AL
#  df <- voter_affiliation(c("PT", "PC do B"), c("DF", "MG", "AL"))

## ------------------------------------------------------------------------------------------
uf_br()

