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

 * NFS - /home/ is shared to all nodes
 * NIS
 * DHCP/DNS/TFTP-boot (via dnsmasq)

  - configuration is in the -- well documented -- /etc/dnsmasq.d/medusa.dnsmasq.conf

 * reprepro/apache for internal distribution of packages
 * exim4 - send email using mail.ovgu.de as a smarthost

  - machines behind NAT (mudflap specifically) use medusa as a smarthost

 * apt-cacher-ng
 * logwatch
 * backups

  - medusa does a nightly backup of all non-compute servers into the /home/backup/<machine.name> directory
  - for more info, read the `backup docs <../backups.html>`_

External Services
=================

 * SSH (protected with fail2ban)

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
Medusa uses hardware RAID for disk redundancy. The access the RAID manager, run:

.. code-block:: bash

    root@medusa:~# mrm 

