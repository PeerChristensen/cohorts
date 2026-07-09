
# cohorts 1.3.0

* Rewrote the core `cohort_table_*` functions, as well as `cohort_table_pct()`,
  `shift_left()`, and `shift_left_pct()`, using `data.table` for substantially
  faster performance on large event data.
* Dropped the `dtplyr`, `tidyr`, `zoo`, and `dplyr` dependencies.


# cohorts 1.2.0

* Added functions for exploring cohorts on week and year levels


# cohorts 1.1.0

* Corrected small error in main functions


# cohorts 1.0.0

* Added core functions to the package.

