## Update

This is a minor update (version 1.3.0).

In this version I have:

* Rewritten the core `cohort_table_*` functions, as well as `cohort_table_pct()`,
  `shift_left()`, and `shift_left_pct()`, using `data.table` for substantially
  faster performance on large event data. Function output is unchanged.
* Dropped the `dtplyr`, `tidyr`, `zoo`, and `dplyr` dependencies.
* Added a `testthat` test suite.

## Test platforms

- macOS, R 4.5.2, x86_64, local check with `--as-cran`
- Windows Server 2022, R-devel, 64 bit
- Ubuntu Linux 20.04.1 LTS, R-release, GCC
- Fedora Linux, R-devel, clang, gfortran

## R CMD check results

0 errors | 0 warnings | 0 notes

## revdepcheck results

We checked 0 reverse dependencies, comparing R CMD check results across CRAN and
dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages
