# License and provenance

DID-INT official R didintrjl and Stata didintjl are Julia wrappers, not usable native implementations. Julia ebjamieson97/DiDInt.jl at ff3d91714d48f6b97c6df4c28de52c07abe22647 is MIT; it was not copied or invoked.

The current package is distributed under its included MIT license. The suite adapter is an independent equation/API implementation; historical Python code was used as a numerical oracle, not copied into the R adapter. The current Python comparator repository also includes an MIT license. Frozen source hashes and comparator commits are recorded in `tests/fixtures/provenance.json`; that evidence is historical and does not assert validation against the latest upstream version. Original upstream authorship and license notices are retained.
