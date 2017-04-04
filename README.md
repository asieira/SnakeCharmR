
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/asieira/SnakeCharmR.svg?branch=master)](https://travis-ci.org/asieira/SnakeCharmR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/asieira/SnakeCharmR?branch=master&svg=true)](https://ci.appveyor.com/project/asieira/SnakeCharmR) [![codecov](https://codecov.io/gh/asieira/SnakeCharmR/branch/master/graph/badge.svg)](https://codecov.io/gh/asieira/SnakeCharmR) [![](https://cranlogs.r-pkg.org/badges/grand-total/SnakeCharmR)](https://cran.rstudio.com/web/packages/SnakeCharmR/index.html)

<img src="tools/snaker.jpg" width="33%"/>

SnakeCharmR
-----------

Modern overhaul of `rPython`, read more on the motivation and benefits of using it in [this blog post](https://asieira.github.io/introducing-snakecharmr.html).

Many thanks to [Bob Rudis](https://github.com/hrbrmstr) for basically teaching me how to write a modern R package and getting this off the ground.

### LINUX AND UNIX-LIKE SYSTEMS

In order to compile SnakeCharmR, you'll need to have Python &gt;= 2.7 installed. Make sure you also have the development libraries and include files, the operating system package names will vary with your specific Linux distribution.

By default SnakeCharmR will look for `python-config` and `python` commands in the PATH. The former will be used to determine the location of the libraries and headers necessary to compile SnakeCharmR.

In systems where several Python versions coexist, you can force a different version to be used by setting an environment variable `SNAKECHARMR_PYTHON_VERSION` to either the major version or major and minor versions.

For example, if you set `SNAKECHARMR_PYTHON_VERSION=3.2` then Python 3.2 will be used. In this example, you will need to ensure:

-   that `python3.2` and `python3.2-config` exist and are in the PATH;

-   that a `libpython3.2.so` exists at the locations indicated by `python3.2-config --ldflags`.

### WINDOWS SYSTEMS

In order to compile this on Windows, make sure you meet the following requirements:

-   Install the latest version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/);

-   Ensure the `python` command from the desired Python version is the first one in your PATH.

If you want to use the (very outdated) Python bundled with Rtools on a 64-bit system, for example, you would need to add `c:\Rtools\mingw_64\opt\bin` to your PATH and possibly set `PYTHONHOME` to `c:\Rtools\mingw_64\opt`.

It is recommended, however, that you install and use the [official Python distribution for Windows](https://www.python.org/downloads/windows/).

Many thanks to [mattfidler](https://github.com/mattfidler) for the help in getting this to work properly on Windows.
