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

  dt <- dtplyr::lazy_dt(df)

  dt %>%
    dplyr::group_by({{id_var}}) %>%
    dplyr::mutate(month = zoo::as.yearmon({{date}})) %>%
    dplyr::mutate(cohort = min(month)) %>%
    dplyr::group_by(cohort, month) %>%
    dplyr::summarise(users = dplyr::n_distinct({id_var}})) %>%
    tidyr::pivot_wider(names_from=month,values_from=users) %>%
    dplyr::ungroup() %>%
    dplyr::mutate(cohort = 1:dplyr::n_distinct(cohort)) %>%
    tibble::as_tibble()
}

utils::globalVariables(c("cohort","users","month","%>%"))
