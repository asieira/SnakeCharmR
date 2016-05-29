# context("Rcpp get of string/bytes and unicode types")
# 
# test_that("we can read string//bytes and unicode", {
#   py.exec("_test_var = 'blah'")
#   expect_equal(rcpp_Py_get_var("_test_var"), "blah")
# 
#   py.exec("_test_var = u'blah'")
#   expect_equal(rcpp_Py_get_var("_test_var"), "blah")
#   
#   py.exec("_test_var = u'áéíóú'")
#   expect_equal(rcpp_Py_get_var("_test_var"), "áéíóú")
#   
#   py.exec("_test_var = 1")
#   expect_error(rcpp_Py_get_var("_test_var"), "variable is not a string")
# })
