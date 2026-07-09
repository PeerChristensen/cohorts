test_that("cohort_table_day returns the expected structure and values", {
  ct <- cohort_table_day(gamelaunch, userid, eventDate)

  expect_s3_class(ct, "tbl_df")
  expect_equal(dim(ct), c(31L, 32L))
  expect_equal(names(ct)[1], "cohort")
  expect_equal(ct$cohort, 1:31)

  # first cohort, first day
  expect_equal(ct[["2016-04-27"]][1], 96L)
  # values are integer counts
  expect_type(ct[["2016-04-27"]], "integer")
  # cells above the diagonal are empty (NA)
  expect_true(is.na(ct[["2016-04-27"]][2]))
})

test_that("cohort_table_week returns the expected structure and values", {
  ct <- cohort_table_week(gamelaunch, userid, eventDate)

  expect_s3_class(ct, "tbl_df")
  expect_equal(dim(ct), c(6L, 7L))
  expect_equal(names(ct), c("cohort", "17", "18", "19", "20", "21", "22"))
  expect_equal(ct$cohort, 1:6)

  expect_equal(ct[["17"]][1], 296L)
  expect_equal(ct[["18"]][2], 2288L)
  expect_true(is.na(ct[["17"]][2]))
})

test_that("cohort_table_month returns the expected structure and values", {
  ct <- cohort_table_month(online_cohorts, CustomerID, InvoiceDate)

  expect_s3_class(ct, "tbl_df")
  expect_equal(dim(ct), c(13L, 14L))
  expect_equal(names(ct)[1:3], c("cohort", "Dec 2010", "Jan 2011"))
  expect_equal(ct$cohort, 1:13)

  expect_equal(ct[["Dec 2010"]][1], 949L)
  expect_equal(ct[["Jan 2011"]][1], 363L)
  expect_equal(ct[["Jan 2011"]][2], 421L)
  # later cohorts have no activity before they start
  expect_true(is.na(ct[["Dec 2010"]][2]))
})

test_that("cohort_table_year returns the expected structure and values", {
  ct <- cohort_table_year(online_cohorts, CustomerID, InvoiceDate)

  expect_s3_class(ct, "tbl_df")
  expect_equal(dim(ct), c(2L, 3L))
  expect_equal(names(ct), c("cohort", "2010", "2011"))
  expect_equal(ct$cohort, 1:2)

  expect_equal(ct[["2010"]][1], 949L)
  expect_equal(ct[["2011"]][1], 821L)
  expect_true(is.na(ct[["2010"]][2]))
})
