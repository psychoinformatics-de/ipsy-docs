Python
######
:order: 550

Debian Packages
***************
If you're running Debian, it's often easiest to use the official Debian packages
(when present) to install python modules. Search for them via ``apt``. For
example:

.. code::

  apt search mvpa2

Once you've found the package, install it:

.. code::

  apt install python-mvpa2

If you can't find a Debian package for the module you want installed, then you
can to install it using ``pip`` — preferably in a virtual environment (see
below).

Virtual Environments
********************
Virtual environments (AKA "venvs") allow you to create isolated environments for
Python. These environments still have access to the full filesystem, but their
"Python World" is their own sandbox to play in, and is completely independent of
everything else.

The advantages of this isolation are numerous (tidiness, one project's
dependencies won't affect others, ease of troubleshooting, etc). Using venvs
should be your default mode of operation.

Virtual environments can be created anywhere on the filesystem, but I like to
keep them all together in a hidden folder called ``.venvs`` in my home
directory.

To create a venv for your new `hyperalignment project <https://youtu.be/7Twnmhe948A?t=11>`_,
run the following:

.. code::

  python3 -m venv ~/.venvs/hyperHyper

.. class:: note

  **NOTE:** Python 2.7 users will need to use the ``virtualenv`` command (e.g.
  ``virtualenv ~/.venvs/hyperHyper``)

To activate your new venv run:

.. code::

  source ~/.venvs/hyperHyper/bin/activate

Your shell's prompt will change to denote the venv you are in. Now you can
install whatever packages you need (using ``pip3 install``); they will all be
stored in ``~/.venvs/hyperHyper`` and will only be available when this venv is
activated.

When you're done, deactivating is as simple as running:

.. code::

  deactivate

IPython
*******
IPython is an interactive shell to compute Python code, similar to the Bash
shell or the Matlab prompt. IPython features tab-completion, command history
retrieval across sessions, dynamic object introspection, and `magic commands
<https://ipython.readthedocs.io/en/stable/interactive/magics.html>`_ that
provide some nice quality-of-life syntactical sugar. To begin an IPython
session, simply run:

.. code::

  ipython

Resources
*********
`Interactive Book: Foundations of Python Programming <https://runestone.academy/runestone/books/published/fopp/index.html>`_
  A "projects first" approach that focuses on building things using Python
  rather than focusing on the language itself.

`Book: Learn Python the Hard Way <https://learnpythonthehardway.org>`_
  Popular with good content. People either enjoy or strongly dislike the book's
  approach of typing out every exercise, embracing failure, and working through
  problems.

`Book: Python Crash Course <https://nostarch.com/pythoncrashcourse2e>`_
  A good go-to book for learning Python.

`Website: The Python Tutorial <https://docs.python.org/3/tutorial/>`_
  The official tutorial from the Python Project.
