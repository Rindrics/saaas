load_data <- function() {
  read_ <- function(fname) {
    utils::read.csv(system.file("extdata", fname, package = "saaas"), row.names = 1)
  }
  frasyr::data.handler(caa = read_("catch_at_age.csv"),
                       waa = read_("weight_at_age.csv"),
                       maa = read_("maturity_at_age.csv"),
                       M   = 0.4)
}

calculate <- function(dat, method) {
  if (method == "vpa") {
    frasyr::vpa(dat,
                fc.year = fcurrent_years(),
                tf.year = terminal_f_years(),
                term.F  = "max",
                stat.tf = "mean",
                Pope    = TRUE,
                tune    = FALSE,
                p.init  = 0.5)
  }
}

diagnose <- function(result) {
  test_effect_of <- function(var) {
    frasyr::do_sensitivity_vpa(result, what_replace = var, value = c(0.5, 1.5, 2))$graph
  }
  test_effect_of("M")
  test_effect_of("waa")
  frasyr::do_retrospective_vpa(result)$graph

  class(result) <- c("assess", class(result))

  force(result)
}

visualize <- function(x, compare_with = NULL) {
  result <- x %>%
    frasyr::convert_vpa_tibble() %>%
    dplyr::filter(!is.na(age), stat == "fish_number")
  utils::write.csv(result, file = "result.csv", row.names = FALSE)

  do_comparison <- !is.null(compare_with)
  if (do_comparison) {
    result %>%
      dplyr::mutate(Name = "this_version") %>%
      dplyr::bind_rows(purrr::map_df(compare_with, load_branch_file, filename = "result.csv")) %>%
      dplyr::filter(stat == "fish_number") %>%
      ggplot2::ggplot(ggplot2::aes(year, value,
                                   group = Name,
                                   color = factor(Name))) +
      ggplot2::geom_line() +
      ggplot2::facet_wrap(~ age)
  } else {
    ggplot2::ggplot(result,
                    ggplot2::aes(year, value,
                                 group = age,
                                 shape = factor(age),
                                 color = factor(age))) +
    ggplot2::geom_line() +
    ggplot2::geom_point() 
  }

}

load_branch_file <- function(branch, filename) {
  url_head <- "https://stock-assessment-as-a-software.s3-ap-northeast-1.amazonaws.com/"
  read.csv(paste0(url_head, branch, "/", filename)) %>%
  dplyr::mutate(Name = branch)
}
