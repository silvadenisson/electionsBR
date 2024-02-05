# electionsBR

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/electionsBR)](https://cran.r-project.org/package=electionsBR)
[![R-CMD-check](https://github.com/silvadenisson/electionsBR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/silvadenisson/electionsBR/actions/workflows/R-CMD-check.yaml)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/silvadenisson/electionsBR?branch=master&svg=true)](https://ci.appveyor.com/project/silvadenisson/electionsBR)
[![downloads](http://cranlogs.r-pkg.org/badges/grand-total/electionsBR?color=green)](https://r-pkg.org/pkg/electionsBR)

> 6 years in and over 40,000+ downloads! 🎉

`electionsBR` provides a comprehensive set of functions for effortlessly retrieving and cleaning Brazilian electoral data from the Brazilian Superior Electoral Court (TSE) [website](https://dadosabertos.tse.jus.br/). The package allows you to access several datasets on local and federal elections for various positions, including city councilors, mayors, state deputies, federal deputies, governors, and presidents, as well as data on voters' profiles, candidates' social media, and personal financial disclosures. The package also provides an alternative API to download data from the [CEPESP Data](https://cepespdata.io/) project. 


## Installation

`electionsBR` is on CRAN and can be installed with:

``` {.r}
install.packages("electionsBR")
```

`electionsBR` is also available on [GitHub](https://github.com/). You can install pre-release versions via:

``` {.r}
if (!require("devtools")) install.packages("devtools")
devtools::install_github("silvadenisson/electionsBR")
```

## How does it work?

To download data from a specific election, simply provide the `year` and `type` arguments in the function call. For instance, to retrieve data on candidates from the 2002 election, use the following code:

``` {.r}
library(electionsBR)
df <- elections_tse(year = 2002, type = "candidate")
```

For some data types in presidential elections, TSE provides results in a single file. To download these data, use the `br_archive` argument as follows:


``` {.r}
df <- elections_tse(year = 2022, type = "vote_mun_zone", br_archive = TRUE)
```

Export Brazilian electoral data to [Stata](https://www.stata.com/) and [SPSS](https://www.ibm.com/spss) formats by setting the `export` optional argument to `TRUE` (the data will be saved in your working directory):


``` {.r}
df <- elections_tse(year = 2002, type = "candidate", export = TRUE)
```

To subset results by Brazilian states, use the `uf` argument. For example, to get data on votes for municipal elections in Rio Grande do Sul (RS) in 2000:

``` {.r}
df <- elections_tse(year = 2000, type = "vote_mun_zone", uf = "RS")
```

For detailed information on the package's functionality and a complete list of functions, see the package vignette.


## Available data

The `elections_tse` function allows you to download the following data (by setting the `type` argument to the corresponding value in the table below, e.g., `type = "candidate"`):


| `type`                  | Description                                                                                          |
|---------------------------|------------------------------------------------------------------------------------------------------|
| `candidate`               | Downloads data on the candidates. Each observation corresponds to a candidate.                      |
| `vote_mun_zone`           | Downloads data on the verification, disaggregated by cities and electoral zones.                     |
| `details_mun_zone`        | Downloads data on the details, disaggregated by town and electoral zone.                             |
| `legends`                 | Downloads data on the party denomination (coalitions or parties), disaggregated by cities.           |
| `party_mun_zone`          | Downloads data on the polls by parties, disaggregated by cities and electoral zones.                 |
| `personal_finances`       | Downloads data on personal financial disclosures. Each observation corresponds to a candidate's property. |
| `seats`                   | Downloads data on the number of seats under dispute in elections.                                     |
| `vote_section`            | Downloads data on candidate electoral results in elections in Brazil by electoral section.           |
| `voter_profile_by_section`| Downloads data on the voters' profile by vote section.                                               |
| `voter_profile`           | Downloads data on the voters' profile.                                                               |
| `social_media`            | Downloads data on the candidates' links to social media in federal elections.                        |


## CEPESP Data Integration

The package also provides an alternative API for downloading data from the [CEPESP Data](https://cepespdata.io/) project, including information on candidates, electoral results, and voters' profiles. To download data on candidates in the 2018 presidential election, simply use the following code:

``` {.r}
library(electionsBR)
df <- elections_cepesp(year = 2018, type = "candidate", position = "President")
```

Valid `type` and `position` arguments are:

| `type`                  | `position` |
|---------------------------|------------------------------------------------------------------------------------------------------|
| `candidate`, `vote`               | `President`, `Governor`, `Senator`, `Federal Deputy`, `State Deputy`                      |


## Citation

If you have found `electionsBR` helpful for your work and would like to acknowledge it in a resulting publication, please consider citing it using:

``` {.r}
citation("electionsBR")
```

## Authors

[Denisson Silva](https://denissonsilva.com/), [Fernando Meireles](https://fmeireles.com/), and Beatriz Costa.

## Contributors

[Willber Nascimento](https://github.com/willbernascimento), [Ian Araujo](https://github.com/ianaraujo), [Guilherme Duarte Jardim](https://github.com/duarteguilherme), [Robert Myles McDonnel](https://github.com/RobertMyles), [Lucas Gelape](https://github.com/lgelape).
