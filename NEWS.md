# electionsBR 0.3.1

This is a minor update with bug fixes and two improvements.

* Fixed fill issues with data.table's fread when reading local data.
* Included a new argument in most functions, br_archive, that allows users to load electoral for the whole country by loading a single file. This makes it faster to clean the data.
* Updated documentation.

# electionsBR 0.3.0

We changed central aspects of the package, which affected all the functions in it (but without compromising backward compability). Beyond that, in this update we did our best to make the package more user friendly: we created a vignette, included more options to filter and customize functions' outputs, and added more specific functions (including one to easily export electoral data). With this new uptade, the package also gained a website. Overrall, this is what we did:

* Updated the package to (1) load and clean data faster (with data.tables' `fread()` and `rbindlist()`), (2) to make the package more robust to human errors (new internal functions to test inputs), and (3) to return a simples object (a dplyr `tbl`).
* Included two new functions to summarize presidential runnoff results by state (`president_state_vote()`) and by municipality (`president_mun_vote()`).
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
* Added a new function, `voter_affiliation`, to collect dato on voters' affiliation.
* Added a new function, `voter_profile`, to collect dato on voters' profile.
* Fixed an encoding issue when joinning collected data (avoid errors on Macs).
* Added a new internal function, `test_encoding`, to validate encodings passed to the functions' calls.
* Replaced `cat` with `message` in all functions. Users are now free to supress unwanted messages.
* Added a CITATION file to /inst.
