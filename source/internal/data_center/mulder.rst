.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

****
Mulder
****
Mulder will become a public/private XNAT server. It 
serves as a second point-of-entry into the cluster network, and was
purchased 2-11.06(?).

Services
========

* logwatch
* SSH
* nothing else as of yet

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
Mulder has one non-standard binary blob.

 * `LSI MegaRAID Storage Manager`_ - Mulder is the only server we still use
   hardware RAID on. There is no FOSS alternative for the proprietary management
   software. Main RPM was converted into .deb via alien. libstdc++5 and libstdc++6
   are (unlisted) dependencies. The vivaldiframeworkd service must be started.

.. _LSI MegaRAID Storage Manager: ftp://ftp.supermicro.com/driver/SAS/LSI/MegaRAID_Storage_Manager/
