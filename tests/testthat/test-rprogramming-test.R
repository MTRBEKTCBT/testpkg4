test_that("データの型をチェック", {
  expect_equal(my_summarise_across(sleep) |> class(), c("tbl_df", "tbl", "data.frame"))
})
