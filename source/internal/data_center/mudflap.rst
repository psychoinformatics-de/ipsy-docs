.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******
Mudflap
*******
Mudflap is the backup server for Medusa. Backups and documentation are
-- hopefully -- done in a way that allows Mudflap to quickly (sub 1 hour)
replace flatbed as the data node in the event of failure. It was purchased
2012.12.

Services
========

* logwatch
* SSH
* backup of Medusa

 - Runs every night (cronjob).
 - creates a snapshot and copies all of Medusa's array (mounted at ``/home``)
   to Mudflap's trucknuts array (mounted at ``/media/backup``)
 - for more info, read the `backup docs <../backups>`_

Hardware Specs
==============
Mudflap is a 1U server connected to two external 2U disk arrays.

 * 4x 8-core 2.6 GHz Opteron 6212
 * 512 GiB RAM (32x 16GB DDR3 ECC reg)
 * 16 TiB formatted storage (19x 2TB SAS Enterprise HDs) in ZFS pool
 * LSI HBA 9212-4i4e 6GB/s SAS Controller
 * 2x bonded Gb NICs (internal network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `A+ Server 1042G-TF`_
and `SuperChassis 826E16-R1200LPB`_.

.. _A+ Server 1042G-TF: http://www.supermicro.com/aplus/system/1u/1042/as-1042g-tf.cfm
.. _SuperChassis 826E16-R1200LPB: http://www.supermicro.com/products/chassis/2u/826/sc826e16-r1200lp.cfm

ZFS
===
Mudflap uses `ZFS <../zfs>`_ for the backup pool. The most notable configuration is that we
use block-level deduplication. This has significant performance implications,
but those trade-offs are worth it on a backup server. The high amount of RAM is
to ensure there's enough space for the DDT to remain in RAM (as there is no
tunable to ensure that). By definition, deduplication will cause the file system
to fragment heavily (even beyond the normal fragmentation of a COW file system).

Non-Debian Modifications/Installations
======================================
ZFS comes from the ZFSonLinux repo.
