#' Create a Cohort Table Using Month Level Event Data
#'
#' Creates a cohort table with month level event data with rows corresponding to cohort numbers and columns as months.
#' @param df Dataframe
#' @param id_var ID variable
#' @param date Date
#'
#' @return Cohort table
#'
#' @export
#'
#' @examples
#' cohort_table_month(online_cohorts, CustomerID, InvoiceDate)
#'
cohort_table_month <- function(df, id_var, date) {

  id_col   <- deparse(substitute(id_var))
  date_col <- deparse(substitute(date))

  x <- data.table::data.table(
    id     = df[[id_col]],
    period = as.Date(cut(as.Date(df[[date_col]]), "month"))
  )

  month_label <- function(d) {
    paste(month.abb[data.table::month(d)], data.table::year(d))
  }

  cohort_build(x, month_label)
}

utils::globalVariables(c("id","cohort","period","users"))
