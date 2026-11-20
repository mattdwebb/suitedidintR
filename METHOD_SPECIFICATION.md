# DID-INT suite adapter: method specification

`suite_didint()` uses absorbing cluster-level adoption and never-treated controls.
First-treatment dates are constant within cluster; zero means never treated.
For a cohort adopting at g, its baseline is the last observed calendar period
before g. A candidate state-time effect needs observations for the treated state
at both that baseline and the post-treatment period.

## Missing values and absent cells

Required values in supplied rows must be finite and nonmissing. A missing outcome
or covariate is not silently removed. This differs from an entirely absent
state-period cell: absent cells make their particular comparisons unavailable,
but do not automatically invalidate the whole dataset. The estimator continues
with identified comparisons and normalizes weights over the surviving effects.
It fails if no treated-state comparison remains identified.

## Adjusted changes

With covariates, fit state-period outcome intercepts and the selected slope
structure. `ccc = "int"` permits a slope per state-period cell; `"state"`,
`"time"` and `"hom"` share slopes within the corresponding blocks after removing
cell means. Without additional covariates, fitted means are cell outcome means.

For a treated state s at post period t, evaluate the relevant treated and control
cell models at that treated post-period cell's mean covariate vector. Use the same
target vector at both dates. Construct each state's fitted post-minus-baseline
change, then subtract a weighted average of eligible control changes. Linear
models permit standardization using covariate means. Supplied time-varying
covariates are not silently frozen at an earlier date.

Each requested prediction must be identified at the target covariate vector at
both dates. Redundant nuisance columns do not automatically invalidate an
identified prediction. A control without identified predictions is unavailable
for that comparison. No unidentified adjusted effect is replaced by an unadjusted
effect or a coding-dependent intercept-only contrast.

## Comparisons and aggregation

For treated state s at post period t, subtract the average change among eligible
never-treated states. A control c is eligible when it has the required two cells
and an identified change or standardized prediction. Its comparison weight is
N[c,t] + N[c,b], normalized over eligible controls. Retain ATT(s,t) only when
the treated change and at least one eligible control change exist.

The default final scalar averages surviving ATT(s,t) values with weights N[s,t],
normalized over those effects. The exposed adapter uses this treated post-period aggregation convention;
it does not expose an alternative aggregation-weight option.

## Deletion, reassignment and scope

Every deletion and reassignment rebuilds fits, comparisons and normalized weights.
A disappeared cohort is permitted when a supported aggregate remains estimable.
All scalar deletions still must exist to form the jackknife standard error;
unavailable deletions are not discarded. See [INFERENCE.md](INFERENCE.md).

Observation weights, not-yet-treated controls and alternatives to `weighting =
"both"` are unsupported in this adapter. Panel mode validates unit-period
uniqueness and cluster membership; the estimator remains cell-based and does not
construct individual fixed effects or fabricated individual differences.

For a fixed assignment, covariates and identified support, fits and contrasts
are linear in the outcomes and weights depend on counts and covariates. Deletion
or reassignment can change the relevant support and weights, which are recomputed.
