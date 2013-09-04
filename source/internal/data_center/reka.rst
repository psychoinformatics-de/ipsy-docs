.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

****
Reka
****
Reka is currently unused, but will likely become a public/private XNAT server.

Services
========

* logwatch
* SSH
* nothing else as of yet

Hardware Specs
==============
Reka is a 2U server.

 * 1x unknown Intel CPU
 * 16 GiB RAM (4x 4GB DDR3 ECC reg)
 * 8 TB storage (8x 2TB SATA Enterprise HDs) in ZFS RAID 10 pool
 * HBA: unknown SuperMicro
 * 2x bonded Gb NICs (internal network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `X9SCA-F`_
and `SuperChassis 825TQ-563LPB`_.

.. _X9SCA-F: http://www.supermicro.com/products/motherboard/xeon/c202_c204/x9sca-f.cfm
.. _SuperChassis 825TQ-563LPB: http://www.supermicro.com/products/chassis/2U/825/SC825TQ-563LP.cfm
