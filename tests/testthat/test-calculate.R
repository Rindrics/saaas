context("behavior of calculate()")

test_that("still dummy multiplying df by given value", {
  catch     <- read.csv(system.file("extdata", "catch.csv", package = "saaas"))
  abundance <- calculate(catch, coef = 2)

  expect_is(abundance, "data.frame")
  expect_setequal(colnames(abundance), c("Year", "Abundance"))
  expect_equal(abundance$Abundance, catch$Catch * 2)
})
