R
**
:order: 630

The statistical software R is available on Medusa. A wide variety of packages
have already been installed and are readily available to load via the
``library()`` command. However, users can install additional packages in their
own home directory.

To use privately installed R packages, first create a directory for them:

.. code::

 mkdir -p ~/.R/libs/

Afterwards, tell R you want to use this folder:

.. code::

 echo 'R_LIBS_USER="~/.R/library"' > ~/.Renviron

Any package that is available via `CRAN <https://cran.r-project.org/web/packages/>`_
can now be installed locally using the ``ìnstall.packages()`` function. Upon
first usage, R will ask

.. code::

 Would you like to use a personal library instead?  (y/n)
 Would you like to create a personal library
 ~/.R/library
 to install packages into?  (y/n)

Answer both questions with ``y``, select the CRAN mirror closest to you from
the list, and you're good to go.
