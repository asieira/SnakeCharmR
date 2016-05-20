context("call")

test_that("calling Python function works", {
  py.exec(
    paste0(
      "def test_func(a, b, c):",
      "    return [a, b, c]",
      collapse = "\n"
    )
  )

  expect_equal(
    py.call("test_func", 1, 2, 3, json.opt.args = list(auto_unbox = TRUE)),
    c(1L, 2L, 3L)
  )
  expect_equal(
    py.call("test_func", 1, c = 3, b = 2, json.opt.args = list(auto_unbox = TRUE)),
    c(1L, 2L, 3L)
  )
  expect_equal(
    py.call("test_func", 1, 2, 3,
            json.opt.args = list(auto_unbox = TRUE),
            json.opt.ret = list(simplifyVector = FALSE)),
    list(1L, 2L, 3L)
  )
  expect_equal(
    py.call("test_func", 1, c = 3, b = 2,
            json.opt.args = list(auto_unbox = TRUE),
            json.opt.ret = list(simplifyVector = FALSE)),
    list(1L, 2L, 3L)
  )
  expect_equal(
    py.call("repr", NULL),
    "None"
  )
})

test_that("exception handling on calling Python function works", {
  py.exec(
    paste0(
      "def raise_func():",
      "    raise Exception('oh noes')",
      collapse = "\n"
    )
  )
  
  expect_error(py.call("raise_func"), "oh noes")
})
