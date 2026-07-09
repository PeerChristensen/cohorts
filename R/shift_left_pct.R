#' Left-shift a Cohort Table With Cohort Sizes as Percentages
#'
#' Left-shifts a cohort table with cohort sizes as percentages of start sizes.
#'
#' @param cohort_table Cohort table
#' @param decimals Integer
#'
#' @return Cohort table
#' @export
#' @examples
#' online_cohorts %>%
#' cohort_table_month(CustomerID, InvoiceDate) %>%
#' shift_left_pct()
#'
shift_left_pct <- function(cohort_table, decimals = 1) {

  wide <- shift_left_build(cohort_table)

  tcols <- setdiff(names(wide), "cohort")
  t0 <- wide[["t0"]]
  for (j in tcols) {
    data.table::set(wide, j = j, value = round(wide[[j]] / t0 * 100, decimals))
  }
  wide[, cohort := seq_len(.N)]

  tibble::as_tibble(wide)
}

utils::globalVariables("cohort")

