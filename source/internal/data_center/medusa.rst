.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

******
Medusa
******
Medusa is the gateway to the rest of the cluster. It provides critical services
(DHCP, NAT, condor master, etc) for computational nodes. It was purchased 2013.12.

.. note::
  Medusa is increasingly becoming disposable. Once a router replaces its
  NAT/DHCP/DNS services, then real effort should go into packaging config files
  and writing a backup restore script. Then any other node can easily take over
  the job of head-node.

Internal Services
=================

 * Arno's IPTables firewall (with NAT)
 * DHCP/DNS/TFTP-boot (via dnsmasq)

  - DHCP and DNS are well documented in ``/etc/dnsmasq.d/medusa.dnsmasq.conf``
  - TFTP is further discussed in the `Netboot and Preseeding docs <../preseeding>`_

 * exim4
 * logwatch

External Services
=================

 * SSH (protected with fail2ban)
 * Ganglia's ``gmetad``

  - Collects ``gmond`` data from self and all compute nodes
  - Exposed on TCP 8651 to kumo.ovgu.de (both as a custom ``arno-firewall`` rule and in ``gmetad.conf``.

Hardware Specs
==============

 * 4x 8-core 2.8 GHz Opteron 6320
 * 256 GiB RAM (16x 16GiB DDR3 ECC reg)
 * 3x 2TB in RAID 1
 * 2x bonded Gb NICs (internal network)
 * 1x Gb NIC (external network)
 * 1x Gb NIC (IPMI network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `A+ Server 2042G-TRF`_.

.. _A+ Server 2042G-TRF: http://www.supermicro.com/aplus/system/2u/2042/as-2042g-trf.cfm

Resource Limits
===============
Since Medusa is the sole gateway to the cluster, it is important to protect it
from user error.  Thus, special resource limits are set on Medusa
(``/etc/security/limits.d/protect_mainnode.conf``).  No process can use more
than 16GiB on Medusa. There are no restrictions on the compute nodes.

Non-Debian Modifications/Installations
======================================
The cluster has some binary blobs and non-standard configuration.

 * `IPMIView`_ - as far as I know, there is no FOSS alternative.

.. _IPMIView: ftp://ftp.supermicro.com/utility/IPMIView/
