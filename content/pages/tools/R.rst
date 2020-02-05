R
##
:order: 560

Debian Packages
***************
If you're running Debian, it's easiest to use the official Debian packages (when
present) to install R packages. Search for them via ``apt``. For example:

.. code::

  apt search tidyr

Once you've found the package, install it:

.. code::

  apt install r-cran-tidyr

If you can't find a Debian package for the R module you want installed, then you
can install it directly from CRAN (see below).

CRAN
****
`CRAN <https://cran.r-project.org/web/packages/>`_ is the main
repository for community projects.

Installing packages from CRAN can range from dull, to thrilling, to aggravating
beyond all belief. It will quickly become apparent which adventure you have
chosen.

It is best to install packages to your home folder; this avoids the need for
admin privileges.

First create a directory for the packages:

.. code::

  mkdir -p ~/.R/library

Then tell R you want to use this folder:

.. code::

  echo 'R_LIBS_USER="~/.R/library"' > ~/.Renviron

Packages from CRAN can now be installed using `ìnstall.packages()`` and will be
installed into ``~/.R/library``. For example, to install packrat, start ``R``
and then run:

.. code::

  > install.packages("packrat")

Packrat
*******
Packrat allows you to create isolated environments for R projects, similar to
Python's "virtualenv". It is not installed by default, so you will need to
follow the above instructions to install it.

To use packrat for your new stats project called "probably", we first need to
create the project folder:

.. code::

  mkdir -p ~/.renvs/probably

Now, start ``R`` and initialize the folder as a packrat project:

.. code::

  > packrat::init("~/.renvs/probably")

Now you can install whatever packages you need (using ``install.packages()``);
they will all be stored in ``~/.renvs/probably`` and will only be available when
this packrat instance is activated.

When you're done, deactivate it:

.. code::

  > packrat::off()

If you start R from the project's packrat folder (``~/.renvs/probably`` in this
case), packrat will start the environment automatically.

Resources
*********
`Book: Statistical Rethinking <https://xcelab.net/rm/statistical-rethinking/>`_
  Bayesian statistics and general intellectual superiority. (english)

`Book: Discovering Statistics Using R <https://uk.sagepub.com/en-gb/eur/discovering-statistics-using-r/book236067>`_
  A good, standard book with a narrative. (english)

`Book: Grundlagen der Datenanalyse mit R <http://www.dwoll.de/r/gddmr.php>`_
  Encyclopedia style, covering all standard statistics. (german)
