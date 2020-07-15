context("Behavior of calculate()")

test_that("still dummy multiplying df by given value", {
  catch     <- read.csv(system.file("extdata", "catch.csv", package = "saaas"))
  abundance <- assess(catch, coef = 2, variable = "Biomass")

  expect_is(abundance, "data.frame")
  expect_setequal(colnames(abundance), c("Year", "Variable", "Abundance", "Type"))
  expect_equal(abundance$Abundance, catch$Catch * 2)
})
