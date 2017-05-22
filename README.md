electionsBR
=====

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/electionsBR)](https://cran.r-project.org/package=electionsBR)
[![Travis-CI Build Status](https://travis-ci.org/silvadenisson/electionsBR.svg?branch=master)](https://travis-ci.org/silvadenisson/electionsBR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/silvadenisson/electionsBR?branch=master&svg=true)](https://ci.appveyor.com/project/silvadenisson/electionsBR) [![Package-License](https://img.shields.io/badge/license-GPL%20%28%3E=%202%29-brightgreen.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)

`electionsBR` offers a set of functions to easily pull and clean Brazilian electoral data from the Brazilian Superior Electoral Court (TSE) [website](http://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais). Among others, the package retrieves data on local and federal elections for all positions (city councilor, mayor, state deputy, federal deputy, governor, and president) aggregated by state, city, and electoral zones.

### Installation

`electionsBR` is on CRAN and can be installed with:

``` {.r}
install.packages("electionsBR")
```

`electionsBR` is also available on [GitHub](https://github.com/). You can install pre-release versions via:

``` {.r}
if (!require("devtools")) install.packages("devtools")
devtools::install_github("silvadenisson/electionsBR")
```

### How does it work?

To download data from a given election, only the `year` argument must be passed to the function call:

``` {.r}
library(electionsBR)
df <- candidate_fed(year = 2002)
```

You may also export Brazilian electoral data to Stata and SPSS by setting the `export` optional argument to `TRUE`:

``` {.r}
df <- candidate_fed(2002, export = TRUE)
```

As well as subset your results by state using the `uf` argument:

``` {.r}
df <- vote_mun_zone_fed(2002, uf = "RS")
```

For more information on how the package works and for a complete list of functions, see the vignette `vignette("introduction", package = "electionsBR")`.

### Citation

To cite `electionsBR` in publications, please use:

``` {.r}
citation("electionsBR")
```

### Authors

[Denisson Silva](http://denissonsilva.com), [Fernando Meireles](http://fmeireles.com), and Beatriz Costa.
