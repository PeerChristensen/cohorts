#' Create a Cohort Table Using Week Level Event Data
#'
#' Creates a cohort table with week level event data with rows corresponding to cohort numbers and columns as dates.
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
cohort_table_week <- function(df, id_var, date) {

  dt <- dtplyr::lazy_dt(df)

  dt %>%
    dplyr::rename(id = {{id_var}}) %>%
    dplyr::group_by(id) %>%
    dplyr::mutate(week = lubridate::week({{date}})) %>%
    dplyr::mutate(cohort = min(week)) %>%
    dplyr::group_by(cohort, week) %>%
    dplyr::summarise(users = dplyr::n_distinct(id)) %>%
    tidyr::pivot_wider(names_from=week,values_from=users) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(cohort = 1:dplyr::n_distinct(cohort)) %>%
    tibble::as_tibble()
}

utils::globalVariables(c("id","cohort","users","week","%>%"))
