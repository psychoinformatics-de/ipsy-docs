.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

******************
Common Admin Tasks
******************

Add a User
==========
The head node runs a script every 5 minutes to copy passwd, shadow, and group
files to all compute nodes and the data node.

.. note::

  All this will be scripted out soon

Medusa, Lab, and Kumo
---------------------
Kumo copies users (with 1000 <= UID <= 9999) from flatbed every 5 minutes.
To have a user have access to all lab resources, login to flatbed.ovgu.de and execute::

  root@medusa:~# IPSY_USER='<username>'
  root@medusa:~# zfs create jackknife/home/${IPSY_USER}
  root@medusa:~# adduser --firstuid 1000 --lastuid 9999 --no-create-home ${IPSY_USER}
  root@medusa:~# cp -vR /etc/skel/.[bp]* /home/${IPSY_USER}/
  root@medusa:~# chown -Rv ${IPSY_USER}:${IPSY_USER} /home/${IPSY_USER}/

Cluster Only (no Kumo)
----------------------
The steps are similar to above, except we'll create an UID >= 10000 to avoid
being copied. Login to flatbed.ovgu.de and execute::

  root@medusa:~# IPSY_USER='<username>'
  root@medusa:~# zfs create jackknife/home/${IPSY_USER}
  root@medusa:~# adduser --firstuid 10000 --lastuid 19999 --no-create-home ${IPSY_USER}
  root@medusa:~# cp -vR /etc/skel/.[bp]* /home/${IPSY_USER}/
  root@medusa:~# chown -Rv ${IPSY_USER}:${IPSY_USER} /home/${IPSY_USER}/

Medusa Only -- Jailed
---------------------
Sometimes we need very restricted accounts, like students for a class, or a
weekend conference. `Firejail`_ is very useful for this. On Medusa, run::

  root@medusa:~# FJ_USER=""; adduser --firstuid 20000 --shell /usr/bin/firejail --home /chroots/2015_firejail/${FJ_USER} "$FJ_USER"

Then, note the UID, and run::

  root@medusa:~# groupmod -g <UID> $FJ_USER

Then edit ``/etc/firejail/login.users`` if you need additional lockdown.
``username: --blacklist=/home/`` is a good starting point.

.. _Firejail: https://l3net.wordpress.com/projects/firejail/

Kumo Only (no Cluster)
----------------------
Kumo copies users (with 1000 <= UID <= 9999) from Flatbed. Thus, lab-only users
need a UID >= 10000 to prevent conflicts. Just login to ``kumo.ovgu.de`` and
execute::

  root@kumo:~# adduser --firstuid 10000 <username>

Groups
------
Users should be added to their lab's group (``exppsy``, ``neuropsy``,
``biopsy``, or ``cogneuro``). ``adduser`` is configured to automatically add new
users to the ``users`` (Git access) and ``fuse`` (``sshfs``) groups.

New Account -- email
--------------------
New Medusa users should be sent this email (along with the "account application"
pdf), pointing them to documentation and setting expectations.

    Bitte wirf einen Blick auf die Doku und verbessere sie bei Bedarf:

    http://kumo.ovgu.de/medusa/

    insbesondere:

    http://kumo.ovgu.de/medusa/userdoc/codeofconduct.html

Play With IPMI
==============

``ipmitool`` is a powerful tool. I wrote ``ipmitw`` as a simple wrapper around
it -- to reduce verbosity. ``ipmiview`` is also useful, but is proprietary,
uses Java, and requires a GUI.

Connect to SoL::

  me@medusa:~$ ipmitw snake1-ipmi sol activate

.. note:: To exit out of the terminal session over SSH, type ~~.

Force all snakes to boot to PXE on next boot::

  me@medusa:~$ ipmitw snake{1..10}-ipmi chassis bootdev pxe

Force snake to boot to BIOS on next boot::

  me@medusa:~$ ipmitw snake2-ipmi chassis bootdev bios

Soft shutdown, and then power on

.. code-block:: bash

  me@medusa:~$ ipmitw snake{1..10}-ipmi chassis power soft
  me@medusa:~$ ipmitw snake{1..10}-ipmi chassis power on

Hard powercycle (reboot)::

  me@medusa:~$ ipmitw snake{1..10}-ipmi chassis power cycle

Hard shutdown::

  me@medusa:~$ ipmitw snake{1..10}-ipmi chassis power off

Get the power state (on/off, etc) of all snakes::

  me@medusa:~$ ipmitw snake{1..10}-ipmi chassis status

Flush Attributes Cache
======================

Sometimes (frequently) I forget to add a user to a group, and they attempt to
access a folder and they are denied. Because of caching, simply adding them to
the group and pushing is insufficient; it will take ~60 minutes for the group
cache to expire. To invalidate the ``nscd`` cache on medusa, run::

  root@medusa:~# nscd -i group

Lab - New Debian Computer
=========================
We offer many useful services to Debian-based computers in our labs.

NeuroDebian Repository
----------------------
The `NeuroDebian`_ website has a mirror-selection tool.

.. _NeuroDebian: http://neuro.debian.net/#repository-howto

Cluster - Update Software
=========================
Most software and configurations are deployed through standard Debian tools.
Nodes are meant to be as identical as possible, so be sure to update all of them
at once. There are two tools which make these easy: ``dsh`` (CLI only) and
``cssh`` (GUI only).

Both dsh and cssh are setup to be aware of all nodes. Netgroups are used by dsh
to target all machines (``allmedusa``; incl. the master node) and all compute
nodes (``snakes``).

.. code-block:: bash

   root@medusa:~# dsh -c -g @allmedusa -- aptitude update; aptitude safe-upgrade

As Ansible gets deployed, `ad hoc Ansible Love`_ is probably the better way to
go.

.. _ad hox Ansible Love: http://docs.ansible.com/ansible/intro_adhoc.html

Cluster - Deploy New Software
=============================
This assumes that the software to be deployed is already packaged. We use ``meta
packages`` to deploy software.

* Login to kumo.ovgu.de as ``root`` and navigate to ``~/packaging/meta/``.
* Edit the ``control`` file of choice (e.g. ``ipsy-common/DEBIAN/control``)
* Build the package:

.. code-block:: bash

   root@kumo:~/packaging/meta# dpkg-deb -b ipsy-common

* Deploy and sign (admin pw) the package:

.. code-block:: bash

   root@kumo:~# reprepro --basedir /var/reprepro/ includedeb stretch /root/packaging/meta/ipsy-common.deb

* Then, update all of the nodes (as outlined above).

Cluster - Deploy Configuration
==============================
We use `config-package-dev`_ to deploy config files to all nodes.
``config-package-dev`` uses ``dpkg-divert`` underneath everything, so the system
is notified of config file moves -- thus making them easier to track.

To install (rather than divert) a config file, just add it to the proper
location in the appropriate package. For example:
``/root/packaging/config/ipsy-config-apt/files/``.

Condor configs are deployed using a custom ``postinst`` script.

Diverted files should be placed the same as above, but also need a corresponding
entry in ``debian/<packagename>.displace``.

The build is just like any other Debian package.

.. code-block:: bash

   root@kumo:~/packaging/config/ipsy-config-apt# dpkg-buildpackage -b
   root@kumo:~# reprepro --basedir /var/reprepro/ includedeb stretch /root/packaging/config/ipsy-config-apt_0.1_all.deb

.. _config-package-dev: http://debathena.mit.edu/config-package-dev/

Cluster - Add New Node
======================
The process of deploying nodes is very automated -- hopefully without being brittle.

* If bonding (likely) set network ports on switch to use Aggregation
* Note power outlets; add to PDU web interface
* Update Rack Diagram and Compute Nodes pages
* Set node's IPMI ``ADMIN`` password to the cluster root password (``ipmiview`` is your friend)
* On Medusa, add the snake's hostname to ``/etc/clusters`` and ``/etc/netgroup``
* On Medusa, edit ``/etc/dnsmasq.d/medusa.dnsmasq.conf``

 - Add data MAC to to-PXE-boot
 - Add data and IPMI MACs to end of file
 - restart DNSmasq

* Determine condor config and add to the ``ipsy-compute-config`` package.
* Determine SoL COM port and add to the ``ipsy-config-grub`` package.
* Use ``ipmiview`` to start the node; then boot it from network (KVM console).
* The rest of the node's install is automatic.
