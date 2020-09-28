[![DOI](https://zenodo.org/badge/276816213.svg)](https://zenodo.org/badge/latestdoi/276816213)

EXPERIMENTAL

# Stock assessment as a Softare

Demonstrates how to implement stock assessment itself as reproducible software

This technique is effective not only for reproducibility, but also formalize our work, 

Sample report can be seen [here](https://rindrics.github.io/saaas/articles/report.html)

# How to update assessment

## Confirm build passing

Run `devtools::test()` to confirm the letest version (i.e. assessment conducted in the previous year) works as intended :white_check_mark:

## Update test to break build

Every work starts from issues.
Although the build success is a good news for scientist developed the latest version, but not for you---you have to break build to start your work.

If you are about to start stock assessment in 2021,
the test case in `tests/testthat/test-overall.R` does not match current status.

- Update the year of test from `2020` to `2021`
- Run `devtools::test()` again
- Build fails and your work starts :tada:

## Journey to fix build
What does the build error says?
