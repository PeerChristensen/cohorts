test_that("shift_left left-aligns each cohort and pads with zeros", {
  ct <- cohort_table_month(online_cohorts, CustomerID, InvoiceDate)
  sl <- shift_left(ct)

  expect_s3_class(sl, "tbl_df")
  expect_equal(dim(sl), dim(ct))
  expect_equal(names(sl), c("cohort", paste0("t", 0:12)))
  expect_equal(sl$cohort, 1:13)

  # t0 is each cohort's own start size (the diagonal of the original table)
  original <- as.matrix(ct[, setdiff(names(ct), "cohort")])
  expect_equal(sl$t0, as.numeric(diag(original)))

  # trailing cells are filled with zeros, not NA
  expect_false(anyNA(sl))
  expect_equal(sl$t12[2:13], rep(0, 12))
})

test_that("shift_left_pct left-aligns and rescales to percentages", {
  ct  <- cohort_table_month(online_cohorts, CustomerID, InvoiceDate)
  slp <- shift_left_pct(ct, decimals = 1)

  expect_s3_class(slp, "tbl_df")
  expect_equal(dim(slp), dim(ct))
  expect_equal(names(slp), c("cohort", paste0("t", 0:12)))
  expect_equal(slp$cohort, 1:13)

  # every cohort starts at 100%
  expect_equal(slp$t0, rep(100, nrow(slp)))
  expect_false(anyNA(slp))
})
