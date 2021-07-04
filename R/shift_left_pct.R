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

  cohort_df <- cohort_table %>% data.frame()

  n_cols <- ncol(cohort_df) #count number of columns in data set

  for (i in 1:nrow(cohort_df)) { #for loop for shifting each row
    df <- cohort_df[i,] #select row from data frame
    df <- df[ , !is.na(df[])] #remove columns with zeros
    partcols <- ncol(df) #count number of columns in row (w/o zeros)
    #fill columns after values by zeros
    if (partcols < n_cols) {
      df[, c((partcols+1):n_cols)] <- 0 }
    cohort_df[i,] <- df #replace initial row by new one
  }

  names(cohort_df) <- c("cohort",paste0("t",0:(ncol(cohort_df)-2)))

  cohort_df <- round(cohort_df / cohort_df$t0 * 100, decimals)

  cohort_df %>%
    dplyr::mutate(cohort = dplyr::row_number()) %>%
    tibble::as_tibble()
}

