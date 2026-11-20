# Run from the package root, or through R CMD check after installation.
package <- "suitedidintR"
kind <- "didint"
if (dir.exists("R")) {
  env <- new.env(parent = globalenv())
  for (file in list.files("R", pattern = "\\.[rR]$", full.names = TRUE))
    sys.source(file, envir = env)
} else env <- asNamespace(package)
fit <- get(paste0("suite_", kind), envir = env)

# A reference sampler that stores full strings as values, never as symbols.
# Matching its draws verifies deduplication, observed-assignment exclusion,
# and seeded sampling compatibility independently of the hash implementation.
reference_draws <- function(a, reps, seed) {
  set.seed(seed)
  key <- function(x) paste(format(x, digits = 17, scientific = TRUE), collapse = "|")
  seen <- key(a)
  ans <- matrix(NA_real_, reps, length(a))
  i <- 0L
  while (i < reps) {
    draw <- a[sample.int(length(a))]
    candidate <- key(draw)
    if (!candidate %in% seen) {
      i <- i + 1L
      ans[i, ] <- draw
      seen <- c(seen, candidate)
    }
  }
  ans
}

G <- 2000L
a <- c(2, 2, rep(0, G - 2L))
key <- paste(format(a, digits = 17, scientific = TRUE), collapse = "|")
stopifnot(nchar(key, type = "bytes") > 10000L)
expected <- reference_draws(a, 3L, 19L)
set.seed(291)
before <- .Random.seed
actual <- env$.suite_assignments(a, NULL, 3L, 19L, FALSE)$matrix
stopifnot(identical(before, .Random.seed), identical(actual, expected),
          !anyDuplicated(as.data.frame(actual)))

d <- expand.grid(s = seq_len(G), t = 1:3, j = 1:2)
d$g <- a[d$s]
d$y <- d$s / 100 + d$t + 2 * (d$g > 0 & d$t >= d$g) + d$j / 10
point <- fit(d, "y", "t", "s", gvar = "g", inference = "point")
generated <- fit(d, "y", "t", "s", gvar = "g",
                 inference = "ri_beta", reps = 3L, seed = 19L)
supplied <- fit(d, "y", "t", "s", gvar = "g",
                inference = "ri_beta", assignments = expected)
stopifnot(abs(point$estimate - 2) < 1e-10,
          identical(generated$estimate, point$estimate),
          identical(generated$assignments, expected),
          identical(generated$ri_beta, supplied$ri_beta),
          generated$ri_beta$status == "PASS",
          is.finite(generated$ri_beta$p_value))

# A smaller design also checks generated versus supplied assignments.
small <- d[d$s <= 6L, ]
small$y <- small$y + sin(small$s * small$t) / 10
small_draws <- reference_draws(c(2, 2, 0, 0, 0, 0), 4L, 18L)
generated <- fit(small, "y", "t", "s", gvar = "g",
                 inference = c("ri_beta"), reps = 4L, seed = 18L)
supplied <- fit(small, "y", "t", "s", gvar = "g",
                inference = c("ri_beta"), assignments = small_draws)
stopifnot(identical(generated$ri_beta, supplied$ri_beta))

# Exercise an actual hash collision: these distinct keys have the same
# length and both weighted checksums, but must remain distinct set members.
seen <- new.env(parent = emptyenv())
stopifnot(identical(env$.ri_key_bucket("abc"), env$.ri_key_bucket("b`d")))
env$.ri_key_add(seen, "abc")
stopifnot(env$.ri_key_has(seen, "abc"), !env$.ri_key_has(seen, "b`d"))
env$.ri_key_add(seen, "b`d")
env$.ri_key_add(seen, "abc")
stopifnot(env$.ri_key_has(seen, "abc"), env$.ri_key_has(seen, "b`d"),
          length(seen[[env$.ri_key_bucket("abc")]]) == 2L)
for (value in c("", key, paste0(key, "|extra"), "\u00e9\u4e2d")) {
  env$.ri_key_add(seen, value)
  stopifnot(env$.ri_key_has(seen, value))
}
stopifnot(!env$.ri_key_has(seen, paste0(key, "|missing")),
          all(nchar(ls(seen), type = "bytes") < 10000L))
