context("assign and get")

test_that("strings are preserved", {
  assign_and_get <- function(x) {
    py.assign("_test_var", x)
    py.get("_test_var")
  }

  expect_equal(assign_and_get("'"), "'")
  expect_equal(assign_and_get("\\"), "\\")
  expect_equal(assign_and_get("áéíóú"), "áéíóú")
  expect_equal(assign_and_get("'áéíóú\\'"), "'áéíóú\\'")
})
