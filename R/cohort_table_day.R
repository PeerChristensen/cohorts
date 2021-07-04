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

  dt <- dtplyr::lazy_dt(df)

  dt %>%
    dplyr::group_by({{id_var}}) %>%
    dplyr::mutate(cohort = min({{date}})) %>%
    dplyr::group_by(cohort, {{date}}) %>%
    dplyr::summarise(users = dplyr::n()) %>%
    tidyr::pivot_wider(names_from={{date}},values_from=users) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(cohort = 1:dplyr::n_distinct(cohort)) %>%
    tibble::as_tibble()
}

utils::globalVariables(c("cohort","users"))
