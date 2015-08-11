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
To have a user have access to all lab resources, login to flatbed.ovgu.de and execute::

  root@flatbed:~# zfs create jackknife/home/<username>

Then, on medusa, run::

  root@medusa:~# adduser --firstuid 1000 --lastuid 9999 --no-create-home <username>
  root@medusa:~# cp -vR /etc/skel/.[bp]* /home/<username>/
  root@medusa:~# chown -R username:username /home/<username>/

Then update NIS::

  root@medusa:~# /usr/bin/make -C /var/yp

Medusa Only (no Lab)
--------------------
The steps are similar to above, except we'll create an UID >= 10000 to avoid being copied.
Login to flatbed.ovgu.de and execute::

  root@flatbed:~# zfs create jackknife/home/<username>

Then, on medusa, run::

  root@medusa:~# adduser --firstuid 10000 --no-create-home <username>
  root@medusa:~# cp -vR /etc/skel/.[bp]* /home/<username>/
  root@medusa:~# chown -R username:username /home/<username>/

Then update NIS::

  root@medusa:~# /usr/bin/make -C /var/yp

Medusa Only -- Jailed
---------------------
Sometimes we need very restricted accounts, like students for a class, or a
weekend conference. `Firejail`_ is very useful for this. On Medusa, run::

  root@medusa:~# FJ_USER=""; adduser --firstuid 10000 --shell /usr/bin/firejail --home /chroots/2015_firejail/${FJ_USER} "$FJ_USER"

Then edit ``/etc/firejail/login.users`` if you need additional lockdown.
``username: --blacklist=/home/`` is a good starting point.

.. _Firejail: https://l3net.wordpress.com/projects/firejail/

Lab Only (no Medusa)
--------------------
B3 is setup to copy users (with 1000 <= UID <= 9999) from Medusa. Thus, lab only users
need a UID >= 10000 to prevent conflicts. Just login to b3 (``141.44.98.5``) and execute::

  root@b3:~# adduser --firstuid 10000 <username>

Then update NIS::

  root@b3:~# /usr/bin/make -C /var/yp

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

Flush Attributes Cache
======================
Sometimes (frequently) I forget to add a user to a group, and they attempt to
access a folder and they are denied. Because of caching, simply adding them to
the group and updating NIS is insufficient; it will take ~60 minutes for the
caches to expire. To invalidate the ``nscd`` cache on flatbed, run::

  root@flatbed:~# nscd -i group

And NFS clients have their own attribute caching layer. This took me awhile, so
I am not certain if what I did cleared the cache, or if time expired it::

  root@medusa:~# sync

If that doesn't work, look at this `Stack Overflow discussion`_.

.. _Stack Overflow discussion: https://stackoverflow.com/questions/13946852/how-to-flush-nfs-attribute-cache

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

   root@kumo:~# reprepro --basedir /var/reprepro/ includedeb jessie /root/packaging/meta/ipsy-compute.deb

* Then, update all of the nodes (as outlined above).

Cluster - Deploy Configuration
==============================
We use `config-package-dev`_ to deploy config files to all nodes. ``config-package-dev`` uses
``dpkg-divert`` underneath everything, so the system is notified of config file moves -- thus
making them easier to track.

To install (rather than divert) a config file, just add it to the proper
location in the appropriate package. For example:
``/root/packaging/config/ipsy-config-apt/files/``.

Condor configs are deployed using a custom ``postinst`` script.

Diverted files should be placed the same as above, but also need a corresponding
entry in ``debian/<packagename>.displace``.

The build is just like any other Debian package.

.. code-block:: bash

   root@kumo:~/packaging/config/ipsy-config-apt# dpkg-buildpackage -b
   root@kumo:~# reprepro --basedir /var/reprepro/ includedeb jessie /root/packaging/config/ipsy-config-apt_0.1_all.deb

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

