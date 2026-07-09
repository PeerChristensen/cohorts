#' Create a Cohort Table Using Day Level Event Data
#'
#' Creates a cohort table with day level event data with rows corresponding to cohort numbers and columns as dates.
#' @param df Dataframe
#' @param id_var ID variable
#' @param date Date
#'
#' @return Cohort table
#'
#' @export
#' @examples
#' cohort_table_day(gamelaunch, userid, eventDate)
#'
#'
cohort_table_day <- function(df, id_var, date) {

  id_col   <- deparse(substitute(id_var))
  date_col <- deparse(substitute(date))

  x <- data.table::data.table(
    id     = df[[id_col]],
    period = as.Date(df[[date_col]])
  )

  cohort_build(x, as.character)
}

utils::globalVariables(c("id","cohort","period","users"))
