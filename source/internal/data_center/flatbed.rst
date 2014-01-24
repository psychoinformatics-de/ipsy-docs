.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******
Flatbed
*******
Flatbed is the data node for the cluster. It was purchased 2011.12.

.. note:: Flatbed is a single point of failure and is meant to failover to mudflap (not automatically).

Services
========

 * NFS (via ZFS) - ``/home`` is shared to all nodes
 * logwatch
 * NUT (UPS monitoring)
 * SSH

Hardware Specs
==============

 * 2x 6-core 2.4 GHz Xeon E5645
 * 96 GiB RAM (12x 8GB DDR3 ECC reg)
 * 2x 80 GB Intel DC S3500 in mdadm RAID 1   
 * 14.5 TiB formatted storage (8x 4TB SAS HDs in ZFS RAID 10 + 1 spare)
 * LSI SAS HBA 9207-4i4e
 * 2x bonded Gb NICs (internal network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `SuperChassis 836E16-R1200B`_
and `Mainboard X8DTH-iF`_.

.. _SuperChassis 836E16-R1200B: http://www.supermicro.com/products/chassis/3u/836/sc836e16-r1200.cfm 
.. _Mainboard X8DTH-iF: http://www.supermicro.com/products/motherboard/qpi/5500/x8dth-if.cfm

ZFS
==========
Flatbed uses `ZFS <../zfs>`_ for storage. Compression is enabled, and the ZIL is disabled
(sync=disabled). The ZIL was disabled due to terrible NFS performance (as it
forces sync) and the budget is not present to install a proper SLOG. This
tradeoff is considered to be acceptable due to the presence of backups (with
ZIL on), a monitored UPS (resulting in a graceful shutdown in the even of
a power outage), and the fact that disabling the ZIL doesn't corrupt the FS,
it only loses data that hasn't yet been flushed. We don't host VMs, can
regenerate most data, and have backups for everything else.

NUT
===
Flatbed monitors both UPSs and shares the info to the network. Medusa polls
this info. For more info, read the `power docs <../power>`_.

Non-Debian Modifications/Installations
======================================
* ZFS comes from the ZFSonLinux repo.
* NUT comes from the unstable repository (need >=2.7.1 to avoid a bug with the Eaton UPS).
