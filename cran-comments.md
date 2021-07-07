## Test environments

*   macOS 10.16 with R version 4.0.5
*   win-builder (devel and release)
*   Windows Server 2008 R2 SP1, R-devel, 32/64 bit
*   Ubuntu Linux 20.04.1 LTS, R-release, GCC
*   Fedora Linux, R-devel, clang, gfortran

## R CMD check results

There were no WARNINGs

There was 1 ERROR:

*   Error : Bioconductor does not yet build and check packages for R version 4.2; see
    https://bioconductor.org/install
    
The same error message was reported by other package developers here: https://github.com/r-hub/rhub/issues/471

The error only occurred for Windows Server 2008 R2 SP1, R-devel, 32/64 bit

There was 1 NOTE:

*   checking CRAN incoming feasibility ... NOTE
    Maintainer: 'Peer Christensen [hr.pchristensen@gmail.com]

    New submission
