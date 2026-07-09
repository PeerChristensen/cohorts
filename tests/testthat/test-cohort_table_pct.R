test_that("cohort_table_pct expresses cohorts as percentages of their start size", {
  ct  <- cohort_table_month(online_cohorts, CustomerID, InvoiceDate)
  pct <- cohort_table_pct(ct, decimals = 1)

  expect_s3_class(pct, "tbl_df")
  expect_equal(dim(pct), dim(ct))
  expect_equal(names(pct), names(ct))
  expect_equal(pct$cohort, 1:13)

  # each cohort starts at 100%
  m <- as.matrix(pct[, setdiff(names(pct), "cohort")])
  expect_equal(unname(diag(m)), rep(100, nrow(pct)))

  # empty cells stay empty
  expect_true(is.na(pct[["Dec 2010"]][2]))

  # a known retention value: Jan 2011 for the first cohort
  expect_equal(pct[["Jan 2011"]][1], round(363 / 949 * 100, 1))
})

test_that("cohort_table_pct honours the decimals argument", {
  ct   <- cohort_table_month(online_cohorts, CustomerID, InvoiceDate)
  pct0 <- cohort_table_pct(ct, decimals = 0)

  expect_equal(pct0[["Jan 2011"]][1], round(363 / 949 * 100, 0))
})
