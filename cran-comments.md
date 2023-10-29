## Test platforms

- MacOS Ventura 13.4, R version 4.3.1, x86_64, darwin20
- Windows Server 2022, R-devel, 64 bit
- Ubuntu Linux 20.04.1 LTS, R-release, GCC
- Fedora Linux, R-devel, clang, gfortran

## R CMD check results

0 errors | 0 warnings

* This is a new release.

There were three NOTES:

* checking for non-standard things in the check directory ... NOTE
Found the following files/directories:
  ''NULL''
* checking for detritus in the temp directory ... NOTE
Found the following files/directories:
  'lastMiKTeXException'

The above were found on Windows Server 2022, R-devel, 64 bit

* checking HTML version of manual ... NOTE
Skipping checking HTML validation: no command 'tidy' found 

This note was found on Ubuntu Linux 20.04.1 LTS, R-release, GCC and Fedora Linux, R-devel, clang, gfortran.

I believe these NOTES can likely be ignored.


## revdepcheck results

We checked 0 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
