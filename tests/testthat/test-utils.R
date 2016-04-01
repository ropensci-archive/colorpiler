context("utils")

test_that("sequence", {
  expect_error(subsample(10, 5),
               "Too many colours selected")
  expect_identical(subsample(10, 10), seq_len(10))
  expect_identical(subsample(3, 10), c(1L, 5L, 10L))
  expect_identical(subsample(4, 10), c(1L, 4L, 7L, 10L))

  f <- function(n, max) {
    x <- subsample(n, max)
    length(x) == n &&
      x[[1]] == 1L &&
      (n == 1 || x[[length(x)]] == max) &&
      !any(duplicated(x))
  }

  g <- function(max) {
    all(vapply(1:50, function(.) f(sample(max, 1L), max), logical(1)))
  }

  expect_true(all(vapply(1:50, function(.) g(sample(20, 1L)), logical(1))))
})
