#' Left-shift a Cohort Table
#'
#' Left-shifts a cohort table
#'
#' @param cohort_table Cohort table
#'
#' @return Cohort table
#' @export
#' @examples
#' online_cohorts %>%
#' cohort_table_month(CustomerID, InvoiceDate) %>%
#' shift_left()
#'
shift_left <- function(cohort_table) {

  wide <- shift_left_build(cohort_table)

  tibble::as_tibble(wide)
}
