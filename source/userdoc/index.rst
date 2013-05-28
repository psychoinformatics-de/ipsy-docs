.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

.. _userdoc:

******************
User documentation
******************
Welcome to Medusa! The Medusa cluster is a Debian Linux based computational cluster 
with (as of June 2013) one head node (medusa) and nine compute nodes (snakes)
-- with more on the way.

It is important to read the documentation in order to familarize yourself with
user policies and the tools used on Medusa.

Before we jump in though, be aware that you are welcome (and encouraged) to correct,
update, and improve these documents. The website sources are written in ReStructuredText_ 
(reST) and stored in a Git repository::

  me@somewhere:~$ git clone me@kumo.ovgu.de:/home/git/medusa

If you do not know git and/or reST (and don't care to learn), simply email your contribution
to a Medusa admin.

.. _ReStructuredText: http://sphinx.pocoo.org/rest.html

.. toctree::
    :maxdepth: 1

    codeofconduct.rst
    accessing_medusa.rst
    setup_environment.rst
    data.rst
    condor.rst
    software.rst
