.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

******************
Common Admin Tasks
******************

Add a User
==========
NIS is used for account management throughout the cluster.

Medusa, Lab, and Kumo
---------------------
Kumo and B3 copy users (with 1000 <= UID <= 9999) from Medusa every 5 minutes.
To have a user have access to all lab resources, login to medusa.ovgu.de and execute::

  root@medusa:~# adduser --firstuid 1000 --lastuid 9999 <username>

Then update NIS::

  root@medusa:~# /usr/bin/make -C /var/yp

Lab Only (no Medusa)
--------------------
B3 is setup to copy users (with 1000 <= UID <= 9999) from Medusa. Thus, lab only users
need a UID >= 10000 to prevent conflicts. Just login to b3 (``141.44.98.5``) and execute::

  root@b3:~# adduser --firstuid 10000 <username>

Then update NIS::

  root@b3:~# /usr/bin/make -C /var/yp

Medusa Only (no Lab)
--------------------
The steps are *identical* to the steps above, just login to medusa.ovgu.de instead of b3.

Groups
------
Users should be added to their lab's group (``exppsy``, ``neuropsy``, ``biopsy``, or
``cogneuro``). ``adduser`` is configured to automatically add new users to the ``users``
(Git access) and ``fuse`` (``sshfs``) groups.

New Account -- email
--------------------
New Medusa users should be sent this email (along with the "account application" pdf),
pointing them to documentation and setting expectations.

    Bitte wirf einen Blick auf die Doku und verbessere sie bei Bedarf:

    http://kumo.ovgu.de/medusa/

    insbesondere:

    http://kumo.ovgu.de/medusa/userdoc/codeofconduct.html

Lab - New Debian Computer
=========================
We offer many useful services to Debian-based computers in our labs.

NeuroDebian Repository
----------------------
The `NeuroDebian`_ website has a mirror-selection tool.

.. _NeuroDebian: http://neuro.debian.net/#repository-howto

Printing
--------
`cups-client` is very useful. Point it to `141.44.98.5`. 

NIS
---
If the computer is a desktop, NIS should be setup.

* The NIS domain is ``ipsy.local``.
* In ``/etc/yp.conf`` set ``ypserver`` to ``141.44.98.5``
* In ``/etc/nsswitch.conf`` set ``passwd``, ``group``, and ``shadow`` to ``files nis``.
* In ``/etc/pam.d/common-account`` add the following line:

.. code-block:: bash

   session    required   pam_mkhomedir.so skel=/etc/skel/ umask=0022

Cluster - Update Software
=========================
Most software and configurations are deployed through standard Debian tools. 
Nodes are meant to be as identical as possible, so be sure to update all of them
at once. There are two tools which make these easy: ``dsh`` (CLI only) and ``cssh``
(GUI only).

Both dsh and cssh are setup to be aware of all nodes. Netgroups are used by dsh to
target all machines (``allmedusa``; incl. the master node) and all compute nodes
(``snakes``).

.. code-block:: bash

   root@medusa:~# dsh -c -g @allmedusa -- aptitude update; aptitude safe-upgrade

Cluster - Deploy New Software
=============================
This assumes that the software to be deployed is already packaged. We use ``meta packages``
to deploy software.

* Login to kumo.ovgu.de as ``root`` and navigate to ``~/packaging/meta/``.
* Edit the ``control`` file of choice (e.g. ``ipsy-compute/DEBIAN/control``)
* Build the package:
 
.. code-block:: bash

   root@kumo:~/packaging/meta# dpkg-deb -b ipsy-compute

* Deploy and sign (admin pw) the package:

.. code-block:: bash

   root@kumo:~# reprepro --basedir /var/reprepro/ includedeb wheezy /root/packaging/meta/ipsy-compute.deb

* Then, update all of the nodes (as outlined above).

Cluster - Deploy Configuration
==============================
We use `config-package-dev`_ to deploy config files to all nodes. ``config-package-dev`` uses
``dpkg-divert`` underneath everything, so the system is notified of config file moves -- thus 
making them easier to track.

To install (rather than divert) a config file, just add it to the proper location within 
``/root/packaging/config/ipsy-compute-config/files/``.

Condor configs are deployed using a custom ``postinst`` script.

The build is just like any other Debian package.

.. code-block:: bash

   root@kumo:~/packaging/config/ipsy-compute-config# dpkg-buildpackage 
   root@kumo:~# reprepro --basedir /var/reprepro/ includedeb wheezy /root/packaging/config/ipsy-compute-config_0.4+nmu3_all.deb

.. _config-package-dev: http://debathena.mit.edu/config-package-dev/

Cluster - Add New Node
======================
The process of deploying nodes is very automated -- hopefully without being brittle.

* Set node's IPMI ``ADMIN`` password to the cluster root password (``ipmiview`` is your friend)
* On Medusa, edit ``/etc/dnsmasq.d/medusa.dnsmasq.conf``

 - Add data MAC to to-PXE-boot
 - Add data and IPMI MACs to end of file
 - restart DNSmasq

* Determine condor config and add to ``ipsy-compute-config`` package.
* Use ``ipmiview`` to start the node; then boot it from network (KVM console).
* The rest of the node's install is automatic.
* On Medusa, add the snake's hostname to ``/etc/clusters`` and ``/etc/netgroup``

