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

The current system uses FAI to setup and update each machine. This is
currently (23.05.2013) in the process of being replaced. The future will use:

 * TFTP to boot the debian install with preseeding
 * an internal repository with metapackages to deploy software
 * quilt to manage configuration changes (patches deployed via the internal repo)

Besides the software installed, nodes are meant to be as disposable as possible.
Each node:

 * uses shared ``/home`` (via NFS) from Medusa
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
Formerly amras; purchased 2009.06.

 * 1x 4-core 2.67 GHz i7 920
 * 18 GiB RAM
 * 5x 1TB SATA2 Enterprise (6 HD bays)
 * 2x bonded Gb NICs

.. warning:: There is no IPMI NIC for this node

For more details, read Supermicro's detailed specifications of the `X8ST3-F Motherboard`_.

.. _X8ST3-F Motherboard: http://www.supermicro.com/products/motherboard/xeon3000/x58/x8st3-f.cfm

snake9
------
snake 9 is a server that was "just laying about" in Toemme's lab. Purchased 2010 (estimated)

 * 1x 8-core 2.0 GHz Opteron 6128
 * 64 GiB RAM (8x 8GiB DDR3 ECC Reg)
 * 1x 700GB SATA
 * 2x bonded Gb NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `H8DGU Motherboard`_.

.. _H8DGU Motherboard: http://www.supermicro.com/aplus/motherboard/opteron6000/sr56x0/h8dgu.cfm
