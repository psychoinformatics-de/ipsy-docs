Python
######
:order: 630

Python is widely used on Medusa --- along with a wide variety of packages that
are readily available to ``import``.

However, the Python ecosystem has well over 150,000 packages, so naturally not
all are installed on Medusa.

If you need a Python package installed on Medusa, I recommend you follow these
steps:

Debian Packages
***************
First, see if it's already packaged for Debian. Many of the most popular Python
packages are already packaged for Debian. If you can find the package via
``aptitude`` on Medusa (for example ``aptitude search python-mvpa2``), then let
Alex know and he can install the package for you.

This is the preferred method, as it saves time and potential headaches. But
also, packages installed using this method are widely tested and are installed
for all users on Medusa. This helps maintain a common environment where scripts
can be trivially shared among users with little divergence in analysis
environments.

User Private
************
If the package you want installed isn't already packaged for Debian, then you
can still install it, but it will only be available for your user.

Any package that is available via on `pypi <https://pypi.org/>`_ can now be
installed to your home directory using ``pip`` (or ``pip3`` for Python3).
For example:

.. code::

  pip3 install --user pelican

Virtual Environments
********************

.. class:: todo

  **TODO:** discuss virtualenv

IPython
*******

.. class:: todo

  **TODO:** discuss IPython
