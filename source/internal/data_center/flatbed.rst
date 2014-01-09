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
 * SSH

Hardware Specs
==============

 * 2x 6-core 2.4 GHz Xeon E5645
 * 96 GiB RAM (12x 8GB DDR3 ECC reg)
 * 2x 80 GB Intel DC S3500 in mdadm RAID 1   
 * 15 TiB formatted storage (8x 4TB SAS HDs in ZFS RAID 10 + 1 spare)  
 * LSI SAS HBA 9207-4i4e
 * 2x bonded Gb NICs (internal network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `SuperChassis 836E16-R1200B`_
and `Mainboard X8DTH-iF`_.

.. _SuperChassis 836E16-R1200B: http://www.supermicro.com/products/chassis/3u/836/sc836e16-r1200.cfm 
.. _Mainboard X8DTH-iF: http://www.supermicro.com/products/motherboard/qpi/5500/x8dth-if.cfm

ZFS
==========
Flatbed uses ZFS, RAID 10 for its storage. ZFS is also responsible for the NFS exports.

Non-Debian Modifications/Installations
======================================
ZFS comes from the ZFSonLinux repo.
