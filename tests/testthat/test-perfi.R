

boa1_path <- read_example("boa_example_data.csv")
boa2_path <- read_example("boa_example_data2.csv")
usb_path<- read_example("usbs_example_data.csv")


# test for read_example

test_that("return data file path in a character string", {
  expect_equal(typeof(read_example()), "character")
  expect_equal(typeof(boa1_path), "character")
  expect_equal(typeof(boa2_path), "character")
  expect_equal(typeof(usb_path), "character")
})

test_that("return error when the data file is not in the package", {
  expect_error(read_example("random_file.csv"))
})


# test for read_boa, read_USBank

boa1 <- read_boa(boa1_path)
boa2 <- read_boa(boa2_path)
usb <- read_USBank(usb_path)

test_that("transaction data output have the correct structure", {
  # transaction data should have 5 columns
  expect_length(boa1, 5)
  expect_length(usb, 5)
  # transaction data should be a dataframe
  expect_true(is.data.frame(boa1))
  expect_true(is.data.frame(usb))
})


# test for summary_stats

test_that("summary stats output have the correct structure", {
  # summary stats should have 2 columns
  expect_length(summary_stats(boa1), 2)
  # summary stats is a dataframe
  expect_true(is.data.frame(summary_stats(boa1)))
  expect_true(is.data.frame(summary_stats(usb)))
  # deposit is greater than 0
  expect_gte(summary_stats(boa1)[1,2], 0)
  # expenditure is less than 0
  expect_lte(summary_stats(boa1)[2,2], 0)
})


# test for budget_income

test_that("budget_income outputs appropriate structure", {
  # output is a list
  expect_equal(typeof(budget_income(2000)), "list")
  # output is a list of numbers
  expect_equal(typeof(unlist(budget_income(2000))), "double")
})
test_that("sum of the budget is equal to the income", {
  expect_equal(sum(unlist(budget_income(sum(boa1$Amount[boa1$Amount > 0] )))), sum(boa1$Amount[boa1$Amount > 0] ))
})

# test for avg_spend

plot <- avg_spend(boa1)
# store labels and title
plot_labels <- c(
  xlab = plot$labels$x,
  ylab = plot$labels$y,
  fill = plot$labels$fill,
  title = plot$labels$title
)
# define expected labels and titles
expected_labels <- c(
  xlab = "Week",
  ylab = "Spending",
  fill = "Week",
  title = "Weekly Spending"
)
# extract aesthetics mappings from the plot data
plot_mappings <- colnames(plot$data)
# define expected aesthetics mappings
expected_mappings <- list(
  x = "week",
  y = "wk_spend",
  fill = "week"
)

test_that("avg_spend plot has correct labels", {
  expect_equal(plot_labels, expected_labels)
  })

test_that("plot aesthetics are correctly mapped", {
  expect_equal(plot_mappings[1], expected_mappings$x)
  expect_equal(plot_mappings[2], expected_mappings$y)
  expect_equal(plot_mappings[1], expected_mappings$fill)

})

# test for generate_pie

pie <- generate_pie(boa1)



