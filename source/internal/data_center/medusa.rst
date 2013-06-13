.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

******
Medusa
******
Medusa is the gateway to the rest of the cluster. It provides critical services
(DHCP, NAT, NFS mounts, etc) for computational nodes. 

.. note:: Medusa is our single point of failure and is not easily restored. 

Internal Services
=================

 * NFS - ``/home`` is shared to all nodes
 * NIS
 * DHCP/DNS/TFTP-boot (via dnsmasq)

  - DHCP and DNS are well documented in ``/etc/dnsmasq.d/medusa.dnsmasq.conf``
  - TFTP is further discussed in the `Netboot and Preseeding docs <../preseeding>`_

 * exim4
 * apt-cacher-ng
 * logwatch
 * backups

  - medusa does a nightly backup of all non-compute servers into the ``/home/backup/<machine.name>`` directory
  - for more info, read the `backup docs <../backups>`_

External Services
=================

 * SSH (protected with fail2ban)
 * Ganglia's ``gmetad`` 

  - Collects ``gmond`` data from self and all compute nodes
  - Exposed on TCP 8651 to kumo.ovgu.de (both as a custom ``arno-firewall`` rule and in ``gmetad.conf``.

Hardware Specs
==============

 * 2x 6-core 2.4 GHz Xeon E5645
 * 96 GiB RAM (12x 8GB DDR3 ECC reg)
 * 2x 500 GB in RAID 1   
 * 15 TiB formatted storage (10x 2TB SATA2 Enterprise HDs) in RAID 6 with 3 global spares  
 * LSI Raidcontroller 9260-4i 
 * 2x bonded Gb NICs (internal network)
 * 1x Gb NIC (external network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `SuperChassis 836E16-R1200B`_
and `Mainboard X8DTH-iF`_.

.. _SuperChassis 836E16-R1200B: http://www.supermicro.com/products/chassis/3u/836/sc836e16-r1200.cfm 
.. _Mainboard X8DTH-iF: http://www.supermicro.com/products/motherboard/qpi/5500/x8dth-if.cfm

RAID Array
==========
Medusa uses hardware RAID for disk redundancy. To access the RAID manager, run::

  root@medusa:~# mrm 

Account Syncing
===============
B3 and kumo copy user accounts from Medusa every 5 minutes using key-based logins to the 
``senmccarthy`` account. ``senmccarthy`` has permission to execute ``shdwfilter`` via sudo
without a password.

Resource Limits
===============
Since Medusa is the sole gateway to the cluster, it is important to protect it from user error.
Thus, special resource limits are set on Medusa (``/etc/security/limits.d/protect_mainnode.conf``).
No process can use more than 8GiB on Medusa. There are no restrictions on the compute nodes.

Non-Debian Modifications/Installations
======================================
The cluster came with some binary blobs and non-standard configuration.

 * mrm (raid utils)
 * IPMIView

.. todo:: I (Alex) am in the process of unrolling these.

TigerVNC has been installed via 3rd-party Debian packages from http://winswitch.org/dists

.. todo:: Neurodebian has a package for >= Wheezy. When we upgrade, we can drop this external dep.

IPMIutil is installed via their package at http://ipmiutil.sourceforge.net/FILES/

.. todo:: I (Alex) am working to clean up ipmiutil's Debian package and get it into Debian proper.

