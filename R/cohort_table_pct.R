#' Convert Values of a Cohort Table to Percentages
#'
#' Converts values of a cohort table to percentages of initial cohort sizes.
#'
#' @param cohort_table Cohort table
#' @param decimals Integer
#'
#' @return Cohort table
#'
#' @export
#' @examples
#' online_cohorts %>%
#' cohort_table_month(CustomerID, InvoiceDate) %>%
#' cohort_table_pct(decimals = 1)
#'
cohort_table_pct <- function(cohort_table, decimals = 1) {

  cohort <- NULL

  dt <- data.table::as.data.table(cohort_table)

  vcols <- setdiff(names(dt), "cohort")
  diagonal <- diag(as.matrix(dt[, vcols, with = FALSE]))

  for (j in vcols) {
    data.table::set(dt, j = j, value = round(dt[[j]] / diagonal * 100, decimals))
  }

  dt[, cohort := seq_len(.N)]

  tibble::as_tibble(dt)
}

utils::globalVariables(c("cohort"))
