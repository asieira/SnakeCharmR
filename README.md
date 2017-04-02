
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Travis-CI Build Status](https://travis-ci.org/asieira/SnakeCharmR.svg?branch=master)](https://travis-ci.org/asieira/SnakeCharmR) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/asieira/SnakeCharmR?branch=master&svg=true)](https://ci.appveyor.com/project/asieira/SnakeCharmR) [![codecov](https://codecov.io/gh/asieira/SnakeCharmR/branch/master/graph/badge.svg)](https://codecov.io/gh/asieira/SnakeCharmR) [![](https://cranlogs.r-pkg.org/badges/grand-total/SnakeCharmR)](https://cran.rstudio.com/web/packages/SnakeCharmR/index.html)

<img src="tools/snaker.jpg" width="33%"/>

SnakeCharmR
-----------

Modern overhaul of `rPython`, read more on the motivation and benefits of using it in [this blog post](https://asieira.github.io/introducing-snakecharmr.html).

### LINUX AND UNIX-LIKE SYSTEMS

In order to compile SnakeCharmR, you'll need to have Python &gt;= 2.7 installed. Make sure you also have the development libraries and include files, the operating system package names will vary with your specific Linux distribution.

Make sure the desired Python interpreter is on the PATH, as well as its equivalent `python-config` command. The latter will be used to determine the location of the libraries and headers necessary to compile SnakeCharmR.

In systems where several Python versions coexist, by the default the version obtained by running `python --version` will be used. However, you can force a different version to be used by setting an environment variable `SNAKECHARMR_PYTHON_VERSION`.

For example, if you set `SNAKECHARMR_PYTHON_VERSION=3.2` then Python 3.2 will be used. In this example, you will need to ensure:

-   that `python3.2` and `python3.2-config` exist and are in the PATH;

-   that a `libpython3.2.so` exists at the locations indicated by `python3.2-config --ldflags`.

### WINDOWS SYSTEMS

In order to compile this on Windows, make sure you meet the following requirements:

-   Install the latest version of [Rtools](https://cran.r-project.org/bin/windows/Rtools/);

-   Ensure the desired Python interpreter is the first one in your PATH;

-   If you have more than one Python version installed and on your PATH, set the SNAKECHARMR\_PYTHON\_VERSION environment variable to the desired version. Ensure there's a loadable `libpython<version>.dll` in your system that matches this configured version. If you don't set this variable, an attempt will be made to determine this automatically with the Python interpreter major and minor versions;

-   You might need to set the PYTHONHOME environment variable . If you are using the 64-bit Python interpreter and libraries bundled with Rtools, for example, set it to `c:\Rtools\mingw_64\opt`.

Many thanks to [mattfidler](https://github.com/mattfidler) for the help in getting this to work properly.
