.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

******************
Common Admin Tasks
******************

Add a User
==========

Lab Only (no Medusa)
--------------------
NIS is used for account management throughout the cluster.
B3 is setup to copy users (with 1000 <= UID <= 9999) from Medusa. Thus, lab only users
need a UID >= 10000 to prevent conflicts. Just login to b3 (``141.44.98.5``) and execute::

  root@b3:~# adduser --firstuid 10000 <username>

Then update NIS::

  root@b3:~# /usr/bin/make -C /var/yp

Medusa Only (no Lab)
--------------------
The steps are *identical* to the steps above, just login to medusa.ovgu.de instead of b3.

Medusa, Lab, and Kumo
---------------------
Kumo and B3 copy users (with 1000 <= UID <= 9999) from Medusa every 5 minutes.
To have a user have access to all lab resources, login to medusa.ovgu.de and execute::

  root@medusa:~# adduser --firstuid 1000 --lastuid 9999 <username>

Then update NIS::

  root@medusa:~# /usr/bin/make -C /var/yp

Groups
------
Users should be added to their lab's group (``exppsy``, ``neuropsy``, ``biopsy``, or
``cogneuro``). ``adduser`` is configured to automatically add new users to the ``users``
(Git access) and ``fuse`` (``sshfs``) groups.

New Account -- email
--------------------
New Medusa users should be sent this email, pointing them to documentation
and setting expectations.

    Bitte wirf einen Blick auf die Doku und verbessere sie bei Bedarf:

    http://kumo.ovgu.de/medusa/

    insbesondere:

    http://kumo.ovgu.de/medusa/userdoc/codeofconduct.html

Update Nodes
============
Most software and configurations are deployed through standard Debian tools. 
Nodes are meant to be as identical as possible, so be sure to update all of them
at once. There are two tools which make these easy: ``dsh`` (CLI only) and ``cssh``
(GUI only).

Both dsh and cssh are setup to be aware of all nodes. Netgroups are used by dsh to
target all machines (``allmedusa``; incl. the master node) and all compute nodes
(``snakes``).

.. code-block:: bash

   root@medusa:~# dsh -c -g @allmedusa -- aptitude update; aptitude safe-upgrade

Deploy Additional Software to Nodes
===================================
For software deployment we use ``meta packages.``

* Login to kumo.ovgu.de as ``root``.
* Edit the ``control`` file of choice (e.g. ``/root/packaging/meta/ipsy-science/DEBIAN/control``)
* Build the package:
 
.. code-block:: bash

   root@kumo:~# dpkg-deb -b packaging/meta/ipsy-science

* Deploy and sign (admin pw) the package:

.. code-block:: bash

   root@kumo:~# reprepro --basedir /var/reprepro/ includedeb wheezy /root/packaging/meta/ipsy-science.deb

* Then, update all of the nodes (as outlined above).

Deploy a New Compute Node
=========================
The process of deploying nodes is very automated -- hopefully without being brittle.

* Set node's IPMI ``ADMIN`` password to the cluster root password (``ipmiview`` is your friend)
* On Medusa, edit ``/etc/dnsmasq.d/medusa.dnsmasq.conf``

 - Add data MAC to to-PXE-boot
 - Add data and IPMI MACs to end of file
 - restart DNSmasq

.. code-block:: bash

   root@medusa:~# service dnsmasq restart

* Use ``ipmiview`` to start the node; then boot it from network (KVM console).
* The rest of the node's install is automatic.
* On Medusa, add the snake's hostname to ``/etc/clusters`` and ``/etc/netgroup``

.. todo:: add Quilt config
