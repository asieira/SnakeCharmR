
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/asieira/SnakeCharmR.svg?branch=master)](https://travis-ci.org/asieira/SnakeCharmR) [![codecov](https://codecov.io/gh/asieira/SnakeCharmR/branch/master/graph/badge.svg)](https://codecov.io/gh/asieira/SnakeCharmR)

<img src="tools/snaker.jpg" width="33%"/>

SnakeCharmR
-----------

Modern overhaul of `rPython`.

You need a compiler and also these caveats:

### LINUX AND UNIX-LIKE SYSTEMS

Package SnakeCharmR depends on Python (&gt;= 2.7).

It requires both Python and its headers and libraries. These can be found in python and python-dev packages in Debian-like Linux distributions.

In systems where several Python versions coexist, the user can choose the Python version to use at installation time. By default, the package will be installed using the Python version given by

    $ python --version

but it is possible to select a different one if the SNAKECHARMR\_PYTHON\_VERSION environment variable is appropriately set.

For instance, if it is defined as

    SNAKECHARMR_PYTHON_VERSION=3.2

it will try to use Python 3.2 (looking for python3.2 and python3.2-config in the path). If set to

    SNAKECHARMR_PYTHON_VERSION=3

it will install against the "canonical" Python version in the system within the 3.x branch.

### WINDOWS SYSTEMS

There wasn't much testing done on Windows systems at this point, any help in testing and maintaining that would be much appreciated.
