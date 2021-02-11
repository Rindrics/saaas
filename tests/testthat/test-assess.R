context("Assessment functions")

test_that("load_data() loads list data from CSVs", {
  expect_is(load_data(), "list")
})

test_that("calculate() executes VPA and returns list", {
  expect_is(calculate(load_data(),
                      method = "vpa"),
            "list")
})
