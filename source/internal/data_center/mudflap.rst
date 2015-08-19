.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******
Mudflap
*******
Mudflap is our backup server and acts as a partial computational node. The
intent was/is for mudflap to be able to replace flatbed int he event of failure.
However, as long as dedup is in use, there is no hope that tolerable performance
can be achieved. It was purchased 2012.12.

Services
========

* logwatch
* SSH
* backup of all non-compute servers (for more info, read the `backup docs <../backups>`_)
* partial computational node.

For more info, look at the ``ipsy-mudflap`` package.

Hardware Specs
==============
Mudflap is a 1U server connected to two external 2U disk arrays.

 * 4x 8-core 2.6 GHz Opteron 6212
 * 512 GiB RAM (32x 16GB DDR3 ECC reg)
 * 21.8 TiB formatted storage (18x 2TB and 6x 4TB SAS HDs in ZFS RAID 10)
 * LSI HBA 9212-4i4e 6GB/s SAS Controller
 * 2x bonded Gb NICs (internal network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `A+ Server 1042G-TF`_
and `SuperChassis 826E16-R1200LPB`_.

.. _A+ Server 1042G-TF: http://www.supermicro.com/aplus/system/1u/1042/as-1042g-tf.cfm
.. _SuperChassis 826E16-R1200LPB: http://www.supermicro.com/products/chassis/2u/826/sc826e16-r1200lp.cfm

ZFS
===
Mudflap uses `ZFS <../zfs>`_ for the backup pool. The most notable configuration
is that we use block-level deduplication. This has significant performance
implications, but those trade-offs are worth it on a backup server. The high
amount of RAM is to ensure there's enough space for the DDT to remain in RAM (as
there is no tunable to ensure that). By definition, deduplication will cause the
file system to fragment heavily (even beyond the normal fragmentation of a COW
file system).

Non-Debian Modifications/Installations
======================================
ZFS comes from the ZFSonLinux repo.
