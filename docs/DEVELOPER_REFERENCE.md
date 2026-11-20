# Earlier development notes

These are the previous landing-page notes, preserved on 19 November 2026 for
provenance. They may describe superseded restrictions. Use the [current README](../README.md),
[inference guide](../INFERENCE.md), and [change history](../CHANGELOG.md) for current behavior.

# suitedidintR

Native base-R implementation. No Python, Julia or Stata runtime calls.
Independent equation/API implementation of the historical target-standardized fitted DID-INT variant.

Install with `R CMD INSTALL .`. Call `suitedidintR::suite_didint`.
Run `Rscript tests/suite_tests.R` from the package root. Frozen synthetic
oracle fixtures are included, so normal tests require only R.




Scope: complete cells; never-treated controls; target-cell size aggregation;
no observation weights. R DID-INT supports hom/state/time/int CCC; default
int matches the canonical inference adapter. Singular covariate designs are
explicit failures. See METHOD_SPECIFICATION.md and INFERENCE.md.

Status: tested supported development subset, NOT full feature parity or release
certification. No large Monte Carlo or production simulation is required.
