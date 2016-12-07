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



