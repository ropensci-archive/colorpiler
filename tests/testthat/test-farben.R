context("farben")

test_that("farben_palette basics", {
  p <- farben_palette("BottleRocket")
  expect_is(p, "farben_palette")
  expect_true(is.function(p))

  expect_error(p(100), "Too many colours")
  expect_equal(length(p(1)), 1L)
  expect_equal(length(p(5)), 5L)
})
