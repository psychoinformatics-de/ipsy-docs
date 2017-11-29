Services Provided
*****************
:order: 690

In addition to `Medusa <{filename}medusa.rst>`_ and the `Experimental Labs
<{filename}labs.rst>`_, the following services are provided:

JupyterHub (alpha)
------------------
A `JupyterHub`_ installation is available and in alpha status. Both R and Python
notebooks are currently supported. If you would like an account for yourself or
to teach a class, contact Alex.

Note, this service is currently in Alpha and *will* move to new hardware
sometime in 2018.

.. _JupyterHub: https://jupyter.org

Mailing Lists
-------------
``exppsy@ovgu.de``
  `Subscribe to exppsy <https://listserv.ovgu.de/mailman/listinfo/exppsy>`_

``neuropsy-list@ovgu.de``
  `Subscribe to neuropsy <https://listserv.ovgu.de/mailman/listinfo/neuropsy-list>`_

``biopsy-l@ovgu.de``
  `Subscribe to biopsy <https://listserv.ovgu.de/mailman/listinfo/biopsy-l>`_

``brazi-l@ovgu``
  An IPSY-wide mailing list that emails directly to the above three lists,
  plus members of other IPSY labs which don't have a mailing list.
  `Subscribe to brazi-l <https://listserv.ovgu.de/mailman/listinfo/brazi-l>`_

Webspace
--------
Web servers are available for:

Lab/Project Websites
  such as `psychoinformatics.de <http://psychoinformatics.de>`_,
  `studyforrest.org <http://studyforrest.org/>`_,
  `howdoyouscience.net <http://howdoyouscience.net>`_, etc

Data Distribution
  such as `psydata.ovgu.de <http://psydata.ovgu.de>`_

Personal Websites
  More info at `Transferring Data <{filename}transferring_data.rst>`_

Debian Repository
-----------------
IPSY-specific packages (scripts, configuration) and license restricted software
(Freesurfer, Matlab, etc) is available. To add the repo to your Debian machine,
run the following:

.. code::

  sudo printf "deb http://kumo.ovgu.de/debian stretch main" > /etc/apt/sources.list.d/ipsy.list
  sudo apt-get update
  sudo aptitude search ipsy-

Due to the restrictive licensing, this repository is *only* available to
machines with a wired connection in the IPSY offices.

OwnCloud (EOL)
--------------
The OwnCloud deployment is now deprecated and no new users are permitted.
Existing users are being migrated to other solutions.

Seafile (coming in 2018)
------------------------
An alternative to DropBox that will be hosted on IPSY infra.
