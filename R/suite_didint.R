#' Native assignment-explicit DIDINT suite adapter
#' @export
suite_didint <- function(data, outcome, time, cluster, gvar = NULL,
                         treatment = NULL, covariates = character(), unit = NULL,
                         data_mode = "auto", inference = "point",
                         assignments = NULL, reps = 999L, seed = 0L, exact = FALSE,
                         null = 0, ccc = "int", weights = NULL,
                         control_group = "never", weighting = "both") {
  .suite_fit(data = data, outcome = outcome, time = time, cluster = cluster,
             gvar = gvar, treatment = treatment, covariates = covariates,
             unit = unit, data_mode = data_mode, inference = inference,
             assignments = assignments, reps = reps, seed = seed, exact = exact,
             null = null, kind = "didint", ccc = ccc,
             weights = weights, control_group = control_group, weighting = weighting)
}
