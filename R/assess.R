load_data <- function() {
  read_ <- function(fname) {
    utils::read.csv(system.file("extdata", fname, package = "saaas"), row.names = 1)
  }
  frasyr::data.handler(caa = read_("catch_at_age.csv"),
                       waa = read_("weight_at_age.csv"),
                       maa = read_("maturity_at_age.csv"),
                       M   = 0.4)
}

assess <- function(method) {
  result <- load_data() %>%
    calculate(method) %>%
    diagnose()

  class(result) <- c("assess")

  force(result)
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
  force(result)
}

plot.assess <- function(x) {
  x %>%
    frasyr::convert_vpa_tibble() %>%
    dplyr::filter(!is.na(age), stat == "fish_number") %>%
    ggplot2::ggplot(ggplot2::aes(year, value, group = age, shape = factor(age))) +
    ggplot2::geom_line() +
    ggplot2::geom_point() 
}
