R
**
:order: 630

The statistical software R is available on Medusa --- along with a wide variety
of packages that are readily available to load via the ``library()`` command.

However, the R ecosystem has over 12,000 packages, so naturally not all are
installed on Medusa.

If you need an R package installed on Medusa, I recommend you follow these
steps:

Debian Packages
===============
First, see if it's already packaged for Debian. Many of the most popular R
packages are already packaged for Debian. If you can find the package via
``aptitude`` on Medusa (for example ``aptitude search tidyr``), then let Alex
know and he can install the package for you.

This is the preferred method, as it saves time and potential headaches. But
also, packages installed using this method are widely tested and are installed
for all users on Medusa. This helps maintain a common environment where scripts
can be trivially shared among users with little divergence in analysis
environments.

User Private
============
If the package you want installed isn't already packaged for Debian, then you
can still install it, but it will only be available for your user. The
installation process can range from dull, to thrilling, to aggravating beyond
all belief. It will quickly become apparent which adventure you have chosen.

Before you can install R packages in your home folder, you must configure it to
do so.

First create a directory for the packages:

.. code::

  mkdir -p ~/.R/library

Then tell R you want to use this folder:

.. code::

  echo 'R_LIBS_USER="~/.R/library"' > ~/.Renviron

Any package that is available via `CRAN <https://cran.r-project.org/web/packages/>`_
can now be installed to ``~/.R/library`` using ``ìnstall.packages()``. For
example:

.. code::

  install.packages("ggvis")
