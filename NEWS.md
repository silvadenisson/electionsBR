# electionsBR 0.4.0

In this new minor release, we unified the functions to download and clean electoral data using a few improved internal functions. In addition to that, we also added support to get data from CepespData's API (cepespdata.io), which allows users to download electoral data from 1998 to 2018. With this update, we hope the package will be more robust and easier to maintain.

## Major changes

* Implemented httr's GET to download files, avoiding TSE's server instability.
* Wrapped all functions to download and clean electoral data in a single function, `elections_tse()`, that calls appropriate internal functions; original functions now return deprecation warnings.
* Added support to download data from CepespData's API using the `elections_cepesp()` function.
* Added functionality to download candidates' personal financial data and social media information using the `elections_tse()` function.

## Fixes and improvements

* Fixed the functions vote_section_local and vote_mun_zone_fed.
* Fixed the `br_archive` argument to handle different file naming conventions.
* Added httr as a backend to download files and track progress.
* Updated README and documentation.
* Updated citation file.

# electionsBR 0.3.2

This is a minor update fixing the functions to download and clean electoral data by voting sections in municipal elections. We also added support to continuous integrations tests with GitHub Actions. 


# electionsBR 0.3.2

This is a long due minor update that (1) fixes a few bugs and improve a couple of functions, and (2) adds new functions and document others better.

* Added the voter_profile_by_section function to extract and clean voters' profile information aggregated by voting sections.
* Added support to download more recent Brazilian electoral data, including the most recent one held in 2020.
* Improved all functions to better deal with errors when loading local data.
* Exported pipe to make it more convenient to use the package in analysis.
* Updated documentation.


# electionsBR 0.3.1

This is a minor update with bug fixes and some improvements.

* Fixed fill issues with data.table's fread when reading local data.
* Included a new argument in most functions that allows users to load 
electoral data for different elections and levels.
* Included new functions to download data in Rdata format directly from a private web server.
* Replaced data.table's fread to read data (as the Brazilian Electoral Court started using
other file formats). From this version on, all functions internally use tidyverse's read_delim to read electoral data.
* Updated documentation.

# electionsBR 0.3.0

We changed central aspects of the package, which affected all the functions in it (but without compromising backward compatibility). Beyond that, in this update we did our best to make the package more user friendly: we created a vignette, included more options to filter and customize functions' outputs, and added more specific functions (including one to easily export electoral data). With this new update, the package also gained a website. Overall, this is what we did:

* Updated the package to (1) load and clean data faster (with data.tables' `fread()` and `rbindlist()`), (2) to make the package more robust to human errors (new internal functions to test inputs), and (3) to return a simples object (a dplyr `tbl`).
* Included two new functions to summarize presidential runoff results by state (`president_state_vote()`) and by municipality (`president_mun_vote()`).
* Included two new functions to summarize legislative election results by state (`legislative_state_vote()`) and by municipality (`legislative_mun_vote()`).
* Included one new function to get data on the number of seats being disputed in each election (`available_seats()`).
* Included an optional argument in most functions to export electoral data to Stata or SPSS.
* Included an optional argument in most functions to filter results by state (`UF`).
* Created one vignette.
* Updated the README.

# electionsBR 0.2.0

* Added a `NEWS.md` file to track changes to the package.
* Included `year = 2016` option for local elections.
* Updated `candidate_local` documentation.
* Included an option to convert electoral data from Latin-1 encoding to ASCII.
* Removed the exportation of some internal functions.
* Added a new function, `voter_affiliation`, to collect data on voters' affiliation.
* Added a new function, `voter_profile`, to collect data on voters' profile.
* Fixed an encoding issue when joining collected data (avoid errors on Macs).
* Added a new internal function, `test_encoding`, to validate encodings passed to the functions' calls.
* Replaced `cat` with `message` in all functions. Users are now free to suppress unwanted messages.
* Added a CITATION file to /inst.
