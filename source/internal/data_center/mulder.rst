******
Mulder
******
Mulder (psydata.ovgu.de) is our large-yet-disposable-data-that-needs-to-be-served
server. It also serves as a second point-of-entry into the cluster network, and
was purchased 2011.06(?).

Services
========

* Apache
* rsyncd
* apt-cacher-ng (internal only)
* logwatch
* SSH
* Arno's IPTables firewall

For more info, look at the ``ipsy-mulder`` package.

Hardware Specs
==============
Mulder is a 2U server.

 * 1x Intel Xeon E3-1230 3.2 GHz CPU
 * 16 GiB RAM (4x 4GB DDR3 ECC reg)
 * 500 GB host drives (2x 500 GB SATA Enterprise HDs) in RAID 1 array
 * 6 TB storage (6x 2TB SATA Enterprise HDs) in RAID 10 array
 * RAID: Supermicro SMC2108 (LSI)
 * 2x bonded Gb NICs (internal network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `X9SCA-F`_
and `SuperChassis 825TQ-563LPB`_.

.. _X9SCA-F: http://www.supermicro.com/products/motherboard/xeon/c202_c204/x9sca-f.cfm
.. _SuperChassis 825TQ-563LPB: http://www.supermicro.com/products/chassis/2U/825/SC825TQ-563LP.cfm

Non-Debian Modifications/Installations
======================================
Mulder has some non-standard binary blobs, both provided via Kumo.

 * `LSI MegaRAID Storage Manager`_ - Mulder is the only server we still use
   hardware RAID on. There is no FOSS alternative for the proprietary management
   software. The GUI is launched via ``/usr/local/MegaRAID Storage Manager/startupui.sh``
   and the ``vivaldiframeworkd`` service it requires likes to crash, so just
   restart it.

.. _LSI MegaRAID Storage Manager: ftp://ftp.supermicro.com/driver/SAS/LSI/MegaRAID_Storage_Manager/
