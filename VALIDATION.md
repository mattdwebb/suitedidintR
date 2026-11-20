# Validation

Initial run: 110 assertion groups; max discrepancy 3.552713678800501e-15.
Repository-local R CMD INSTALL and exported-function smoke tests passed.
Two independent native R worker processes produced identical full-inference
results (with three generated assignments each).

These are scoped test results, not exhaustive certification. Paired native
Stata adapters also passed the pinned fixtures, including all deletions.
Official Julia DID-INT was not executed. The inherited Windows LANG/LC_ALL
C.UTF-8 setting is unavailable in this R installation; LC_ALL=C and LANG=C
remove startup warnings without changing system settings.

R CMD build and R CMD check completed with Status: OK (zero errors, warnings or notes), including installed smoke, process isolation and regression tests.
GitHub R regression workflow passed on Windows and Ubuntu for the
initial tested milestone. No cloud Stata runner was invoked.
