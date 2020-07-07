# Stock assessment as a Softare

Demonstrates how to implement stock assessment as reproducible software

Still under developing

Sample report can be seen [here](https://rindrics.github.io/saaas/articles/report.html)

# How to update assessment

## Confirm build passing

Run `devtools::test()` to confirm the assessment of the previous year is correctly working :white_check_mark:

## Update test to consistent with current status

If you are about to start stock assessment in 2021,
the test case in `tests/testthat/test-overall.R` does not match current status.

- Update the year of test from `2020` to `2021`

## Break build to start project

- Run `devtools::test()` again
- Build fails and your work starts :tada:
