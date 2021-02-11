context("Year functions")

test_that("backgenerate_years() generates given sequence of years", {
  expect_equal(backgenerate_years(from = 2010,
                                  length = 3),
               c(2008, 2009, 2010))
  expect_equal(backgenerate_years(from = 2010,
                                  length = 5),
               c(2006, 2007, 2008, 2009, 2010))
})
