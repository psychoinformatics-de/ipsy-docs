.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*************************************
Technical information and maintenance
*************************************

Users
=====

The cluster uses NIS, hence all user management is done on the master node
only.  Users should be placed into the group of their respective lab
(``exppsy``, ``neuropsy``, or ``biopsy``).


Managing nodes
==============

All nodes are bootstrapped and kept up-to-date via FAI_. Any modification of
the node setup should be achieved by modifying the FAI configuration at
``/srv/fai/config`` and **not** by manual package installation or configuration
changes on the nodes directly.

.. _FAI: http://fai-project.org

Distributed shell
-----------------

One can use dsh_ to execute command on multiple nodes simulataneously. Netgroups
are set up to target all machines (``allmedusa``; incl. the master node) and all
compute nodes (``snakes``).

.. _dsh: http://packages.debian.org/sid/dsh

.. code-block:: sh

   $ dsh -c -g @allmedusa -- uname -a
   Linux medusa 2.6.32-5-amd64 #1 SMP Thu Nov 3 03:41:26 UTC 2011 x86_64 GNU/Linux
   Linux snake1 2.6.32-5-amd64 #1 SMP Thu Nov 3 03:41:26 UTC 2011 x86_64 GNU/Linux
   Linux snake2 2.6.32-5-amd64 #1 SMP Mon Oct 3 03:59:20 UTC 2011 x86_64 GNU/Linux
   Linux snake6 2.6.32-5-amd64 #1 SMP Mon Oct 3 03:59:20 UTC 2011 x86_64 GNU/Linux
   Linux snake5 2.6.32-5-amd64 #1 SMP Mon Oct 3 03:59:20 UTC 2011 x86_64 GNU/Linux
   Linux snake3 2.6.32-5-amd64 #1 SMP Mon Oct 3 03:59:20 UTC 2011 x86_64 GNU/Linux
   Linux snake4 2.6.32-5-amd64 #1 SMP Mon Oct 3 03:59:20 UTC 2011 x86_64 GNU/Linux


Updating all nodes simultaneously
---------------------------------

.. code-block:: sh

   dsh -c -g @snakes -- fai -v -cCOMPUTE,NEURODEBIAN -s nfs://medusa/srv/fai/config  softupdate


Non-Debian modification/installations
-------------------------------------

The cluster came with some binary blobs -- TODO: figure out what they are, where they are

TigerVNC has been installed via 3rd-party Debian packages from http://winswitch.org/dists


