#' Create a Cohort Table Using Year Level Event Data
#'
#' Creates a cohort table with year level event data with rows corresponding to cohort numbers and columns as dates.
#' @param df Dataframe
#' @param id_var ID variable
#' @param date Date
#'
#' @return Cohort table
#'
#' @export
#' @examples
#' cohort_table_week(gamelaunch, userid, eventDate)
#'
#'
cohort_table_year <- function(df, id_var, date) {

  id_col   <- deparse(substitute(id_var))
  date_col <- deparse(substitute(date))

  x <- data.table::data.table(
    id     = df[[id_col]],
    period = lubridate::year(df[[date_col]])
  )

  cohort_build(x, as.character)
}

utils::globalVariables(c("id","cohort","period","users"))
