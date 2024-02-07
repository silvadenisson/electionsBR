This is a new minor version that introduces a new software API, with a single function (elections_tse), for handling the downloading and processing of data. This will make it easier to maintain the package in the future. We have also added support for retrieving electoral data from a different data source, cepespdata.io, which is a project maintained by the Center for Politics and Economics of the Public Sector (CEPESP) at the Getulio Vargas Foundation (FGV). Additionally, we have fixed a few bugs, improved the documentation, and enhanced the vignette.

## Test environments

* Fedora 38 (R 4.3.2), personal computer
* macOS 13.6.3 (R 4.3.2), personal computer
* Ubuntu 20.04 (release and devel), using GitHub Actions
* macOS-latest (release), using GitHub Actions
* Windows (release), using GitHub Actions
* Windows Server 2012 R2 x64 (4.3.2 Patched), using Appveyor
* Win-builder (release and devel)
* R-hub (Windows Server, Ubuntu, Fedora)

## R CMD check results

0 errors | 0 warnings | 0 note

* There is only one note on R-hub: `Found the following files/directories: NULL`, which we ignored following <https://github.com/r-hub/rhub/issues/560>.

## Reverse dependencies

There are no reverse dependencies for this package.
