
test_that("transaction data have the correct structure", {
  # transaction data should have 6 columns
  expect_equal(read_boa("boa_data.csv"), 6)
  # transaction data should be a dataframe
  expect_true(is.data.frame(data))
})
