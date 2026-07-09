#' Build a wide cohort table from long event data
#'
#' Internal helper shared by the `cohort_table_*` functions. Given the id and a
#' period key for each event, it assigns every id to a cohort (its earliest
#' period), counts the distinct ids active in each subsequent period, and
#' reshapes the result into a wide cohort table. The heavy lifting is done with
#' `data.table` for speed.
#'
#' @param x A `data.table` with two columns: `id` and `period`. `period` must be
#'   sortable so that cohorts and columns are ordered chronologically.
#' @param label_fn A function mapping the sorted unique period values to the
#'   character column names used in the output table.
#'
#' @return A cohort table as a tibble.
#' @keywords internal
#' @noRd
cohort_build <- function(x, label_fn) {
  cohort <- period <- id <- NULL

  x[, cohort := min(period), by = id]
  agg <- x[, list(users = data.table::uniqueN(id)), by = list(cohort, period)]

  wide <- data.table::dcast(agg, cohort ~ period, value.var = "users")

  periods <- sort(unique(agg$period))
  data.table::setcolorder(wide, c("cohort", as.character(periods)))
  data.table::setnames(wide, c("cohort", label_fn(periods)))

  data.table::setorder(wide, cohort)
  wide[, cohort := seq_len(.N)]

  tibble::as_tibble(wide)
}

#' Left-shift a cohort table
#'
#' Internal helper shared by [shift_left()] and [shift_left_pct()]. For each
#' cohort it drops the empty (`NA`) cells and packs the remaining values to the
#' left, padding the tail with zeros so every row has the same width. Uses
#' `data.table` reshaping instead of a per-row loop.
#'
#' @param cohort_table A cohort table (the output of a `cohort_table_*`
#'   function).
#'
#' @return A `data.table` with a `cohort` column and left-shifted `t0`, `t1`,
#'   ... columns stored as doubles.
#' @keywords internal
#' @noRd
shift_left_build <- function(cohort_table) {
  cohort <- period <- value <- t <- NULL

  dt <- data.table::as.data.table(cohort_table)

  long <- data.table::melt(
    dt,
    id.vars = "cohort",
    variable.name = "period",
    value.name = "value",
    variable.factor = TRUE
  )
  data.table::setorder(long, cohort, period)

  long <- long[!is.na(value)]
  long[, t := seq_len(.N) - 1L, by = cohort]

  wide <- data.table::dcast(long, cohort ~ t, value.var = "value")

  tcols <- setdiff(names(wide), "cohort")
  for (j in tcols) {
    v <- as.numeric(wide[[j]])
    v[is.na(v)] <- 0
    data.table::set(wide, j = j, value = v)
  }

  data.table::setcolorder(wide, c("cohort", as.character(seq_along(tcols) - 1L)))
  data.table::setnames(wide, c("cohort", paste0("t", seq_along(tcols) - 1L)))

  wide
}

