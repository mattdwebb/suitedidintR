\name{suite_didint}
\alias{suite_didint}
\title{Native assignment-explicit DIDINT suite adapter}
\description{Native estimator for identified state-period comparisons with explicit failure statuses.}
\usage{
suite_didint(data, outcome, time, cluster, gvar = NULL,
  treatment = NULL, covariates = character(), unit = NULL,
  data_mode = "auto", inference = "point", assignments = NULL,
  reps = 999L, seed = 0L, exact = FALSE, null = 0,
  ccc = "int", weights = NULL, control_group = "never",
  weighting = "both")
}
\arguments{
\item{data}{A data frame, without missing required values.}
\item{outcome, time, cluster}{Column names. Time and outcome must be finite numeric.}
\item{gvar}{Cluster-constant first-treatment column; zero means never treated.}
\item{treatment}{Optional absorbing binary treatment column, instead of or consistent with gvar.}
\item{covariates}{Numeric column names; no freezing of time-varying values.}
\item{unit}{Individual identifier required in panel mode.}
\item{data_mode}{One of auto, panel, rcs. Auto uses panel if unit is supplied.}
\item{inference}{point, standard, full, or a vector drawn from native, jackknife, ri_beta, ri_t_native, , .}
\item{assignments}{Numeric matrix of alternative assignments, rows are draws and columns are sorted clusters.}
\item{reps}{Positive count of unique draws when assignments are not supplied.}
\item{seed}{Seed for unique random draws. Caller RNG state is preserved.}
\item{exact}{Enumerate all alternative assignments, at most 100000 total.}
\item{null}{Null for jackknife; randomization supports zero only.}
\item{ccc}{Slope restriction: int, hom, state, or time; full-sample fits.}
\item{weights}{Unsupported unless NULL; no observation weights.}
\item{control_group}{Only never is supported.}
\item{weighting}{Only both is supported: control pair-size and target-cell-size weights.}
}
\value{List with estimate, att_st, normalized weights, assignment metadata,
and requested inference lists. Native methods are explicitly unsupported.
Every jackknife deletion is retained, including failed deletions as NA.
Input/point failures signal a suite_error with reason.}
\details{See METHOD_SPECIFICATION.md and INFERENCE.md for exact target and supported scope.
This adapter does not claim full package parity or universal causal validity of supplied covariates.}
