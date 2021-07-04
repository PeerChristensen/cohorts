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

  diagonal <- {{cohort_table}} %>%
    dplyr::select(-cohort) %>%
    as.matrix() %>%
    diag()

  cohort_table_pct <- round({{cohort_table}} / diagonal *100, {{decimals}})

  cohort_table_pct %>%
    dplyr::mutate(cohort = dplyr::row_number()) %>%
    tibble::as_tibble()
}

utils::globalVariables(c("cohort"))
