library(suitedidintR)
school_data <- read.csv(system.file("extdata", "school_policy.csv",
                                    package = "suitedidintR"))
fit <- suite_didint(school_data, "test_score", "year", "school",
                     gvar = "first_treat", covariates = "baseline_score",
                     data_mode = "rcs", inference = "jackknife")
example_result <- data.frame(estimate = fit$estimate,
                             jackknife_se = fit$jackknife$standard_error,
                             jackknife_p = fit$jackknife$p_value)
print(example_result, digits = 7, row.names = FALSE)
