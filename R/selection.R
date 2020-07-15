filter_method <- function(df) {
  assertthat::assert_that(
    assertthat::has_name(df, c("Abundance", "Variable", "Method"))
  )
  threshold <- 40
  method_selected <- df %>%
    dplyr::filter(Year == 2029,
                  Variable == "SSB",
                  Abundance > threshold) %>%
    dplyr::arrange(Abundance) %>%
    dplyr::select(Method) %>%
    unlist() %>%
    unique()
  dplyr::filter(df, Method == method_selected[1])
}
