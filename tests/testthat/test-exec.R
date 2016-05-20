context("exec")

test_that("exception handling on executing Python code works", {
  expect_error(py.exec("raise Exception('oh noes')", stopOnException = TRUE), "oh noes")
  expect_warning(py.exec("raise Exception('oh noes')", stopOnException = FALSE), "oh noes")
})
