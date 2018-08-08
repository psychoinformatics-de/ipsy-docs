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
can now be installed locally using the ``ìnstall.packages()`` function as in
this example:

.. code::

 install.packages("ggvis")

Upon first usage, R will ask

.. code::

 Would you like to use a personal library instead?  (y/n)
 Would you like to create a personal library
 ~/.R/library
 to install packages into?  (y/n)

Answer both questions with ``y``.
If you are asked to select a CRAN mirror when installing a packages, select the
CRAN mirror from Göttingen (number 38). This however shouldn't happen, so if it
*does* happen, please notify Alex.

**NOTE**: Some packages can be messy to install, for example due to many
dependencies. Furthermore, installing packages only locally can make script
sharing and collaboration difficult - your script works fine on your account,
but users lacking your locally installed packages will run into problems. If you
believe a package you are using is useful for more people than only yourself,
please run ``aptitude search thepackagename`` in the terminal. If the package is
available, ask Alex to install it globally.
