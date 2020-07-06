context("behavior of calculate()")

test_that("still dummy multiplying df by two", {
  catch <- read.csv(system.file("extdata", "catch.csv", package = "saaas"))
  expect_is(calculate(catch), "data.frame")
  expect_equal(calculate(catch), catch * 2)
})
