.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**********************
Compute Nodes (snakes)
**********************
Compute nodes have no purpose other than raw computation. While each server
may boast different hardware, they are kept as identical as possible when it
comes to software and configuration. The one notable exception to this policy
is the Condor configuration on each node, as that does vary as widely as the
hardware does.

Compute nodes are meant to be accessed only via Condor (for non-maintenance tasks).
SSH access for other users is kept as a courtesy to ease troubleshooting of
Condor jobs.

The current system uses:

 * TFTP to boot the debian install with preseeding
 * an internal repository (on kumo) with metapackages to deploy software
 * configs are deployed by config packages (kumo) and preseeding during install 

Besides the software installed, nodes are meant to be as disposable as possible.
Each node:

 * uses shared ``/home`` (via NFS) from Flatbed
 * uses NIS for accounts
 * uses DHCP for IPs and DNS
 * has only SSH as a service

Hardware Specs
==============

snake1-6
--------
snakes 1-6 are all identical, half-width servers (2 nodes per U). They were purchased
2011.12.

 * 2x 6-core 2.4 GHz Xeon E5645
 * 96 GiB RAM (12x 8 GiB DDR3 ECC reg)
 * 1x 500GB SATA2 Enterprise HD
 * 2x bonded Gb NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `Twinserver 6016TT-TF`_.

.. _Twinserver 6016TT-TF: http://www.supermicro.com/products/system/1u/6016/sys-6016tt-tf.cfm

snake7
------
snake7 was purchased 2012.06.

 * 4x 16-core 2.4 GHz Opteron 6272
 * 256 GiB RAM (32x 8 GiB DDR3 ECC reg)
 * 1x 1TB SATA3 Enterprise HD
 * 2x bonded Gb NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `H8QG6+-F Motherboard`_.

.. _H8QG6+-F Motherboard: http://www.supermicro.com/Aplus/motherboard/Opteron6000/SR56x0/H8QG6_-F.cfm

snake8
------
Formerly amras; purchased 2010.03.

 * 1x 4-core 2.67 GHz i7 920
 * 18 GiB RAM
 * 5x 1TB SATA2 Enterprise (6 HD bays)
 * 2x bonded Gb NICs

.. warning:: There is no IPMI NIC for this node

For more details, read Supermicro's detailed specifications of the `RM21706 Chassis`_ and
`X8STE Motherboard`_.

.. _RM21706 Chassis: http://www.chenbro.eu/corporatesite/products_detail.php?sku=134
.. _X8STE Motherboard: http://www.supermicro.com/products/motherboard/xeon3000/x58/x8ste.cfm

snake9
------
snake 9 was "just laying about" in Toemme's lab. Purchased 2010 (estimated)

 * 1x 8-core 2.0 GHz Opteron 6128
 * 64 GiB RAM (8x 8GiB DDR3 ECC Reg)
 * 1x 700GB SATA
 * 2x bonded Gb NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `H8DGU-F Motherboard`_.

.. _H8DGU-F Motherboard: http://www.supermicro.com/aplus/motherboard/opteron6100/sr56x0/h8dgu-f.cfm

snake10
-------
snake 10 was purchased 2013.12.

 * 4x 8-core 2.8 GHz Opteron 6320
 * 512 GiB RAM (32x 16GiB DDR3 ECC Reg)
 * 1x 1TB SATA
 * 2x bonded Gb NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `A+ Server 1042G-TF`_.

.. _A+ Server 1042G-TF: http://www.supermicro.com/aplus/system/1u/1042/as-1042g-tf.cfm

snake11
-------
snake 11 was purchased 2015.12.

 * 2x 10-core 2.3 GHz Intel Xeon E5-2650v3
 * 96 GiB RAM (6x 16GiB DDR4 ECC Reg)
 * 1x 250GB SATA
 * 2x bonded 10 Gb NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `825TQ-R740LPB Chassis`_
and `X10DRi-T Motherboard`_.

.. _825TQ-R740LPB Chassis: http://www.supermicro.com/products/chassis/2u/825/sc825tq-r740lp.cfm
.. _X10DRi-T Motherboard: http://www.supermicro.com/products/motherboard/xeon/c600/x10dri-t.cfm

snake12
-------
formerly mudflap; was purchased 2012.12.

 * 4x 8-core 2.6 GHz Opteron 6212
 * 512 GiB RAM (32x 16GB DDR3 ECC reg)
 * 512 GB SSD OCZ-AGILITY4
 * LSI HBA 9212-4i4e 6GB/s SAS Controller
 * 2x 1Gb NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the
`A+ Server 1042G-TF`_ and `SuperChassis 826E16-R1200LPB`_.

.. _A+ Server 1042G-TF: http://www.supermicro.com/aplus/system/1u/1042/as-1042g-tf.cfm
.. _SuperChassis 826E16-R1200LPB: http://www.supermicro.com/products/chassis/2u/826/sc826e16-r1200lp.cfm
