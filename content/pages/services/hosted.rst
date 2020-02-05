Hosted
######
:order: 630

Webspace
********
Web servers are available for:

Lab/Project Websites
  such as `studyforrest.org <http://studyforrest.org/>`_,
  `howdoyouscience.net <http://howdoyouscience.net>`_, etc

Data Distribution
  such as `psydata.ovgu.de <http://psydata.ovgu.de>`_

Personal Websites
  Every IPSY user has a ``public_html/`` folder in their home directory on
  ``kumo.ovgu.de``. Any files placed in that folder will be made available at
  ``http://kumo.ovgu.de/~<username>/``.

DNS
***
Some projects have their own domain names, but the majority of systems will
live under the following namespaces.

``ipsymd.de``
  For convenience and brevity. As this name is new, only a few services use it,
  but in the end, most internal services will migrate to it.

``ovgu.de``
  For official, outward facing services that should display the full OvGU
  branding (website, major projects, etc).

Debian Repository
*****************
IPSY-specific packages (scripts, configuration) and license restricted software
(Freesurfer, Matlab, etc) is available. To add the repo to your Debian machine,
run the following:

.. code::

  printf "deb http://kumo.ovgu.de/debian stretch main\n" | sudo tee /etc/apt/sources.list.d/ipsy.sources.list
  wget -O- http://kumo.ovgu.de/debian/ipsy_apt.gpg.key | sudo apt-key add -
  sudo apt update
  sudo apt search ipsy-

Due to the restrictive licensing, this repository is *only* available to
machines with a wired connection in the IPSY offices or via VPN.

Dotfiles
********
An IPSY dotfiles repository is provided (``ssh://medusa.ovgu.de:/home/git/dotfiles.git``),
containing a collection of config files with sane defaults to enable a
baseline, reasonably featured command line experience.

The ``README`` file in the repository contains instructions on how to use
dotfiles.

JupyterHub (retired)
********************
The IPSY `JupyterHub`_ instance is now retired. The URZ, as a result of our
successful trial, will host a JupyterHub instance and make it available for
university use sometime in 2020.

.. class:: todo

  **TODO:** Add link/contact info here for the URZ instance.

.. _JupyterHub: https://jupyter.org

OwnCloud (EOL)
**************
The OwnCloud deployment is now deprecated and no new users are permitted.
Existing users are being migrated to other solutions.
