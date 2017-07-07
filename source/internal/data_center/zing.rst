****
Zing
****
Zing is the data node. It was purchased 2016.12.

Services
========

 * NFS (via ZFS) - ``/home`` is shared to all nodes
 * NIS
 * logwatch
 * NUT (UPS monitoring)
 * SSH

Hardware Specs
==============

 * 1x 8-core 3.2 GHz Xeon E5-1660 v4
 * 96 GiB RAM (6x 16GB DDR4 2133 ECC reg)
 * 2x 120 GB Samsung SSD SM863 in mdadm RAID 1
 * 13x 3.84TiB SSD Sandisk Optimux 2 Max in 3x 4-wide RAIDZ1
 * 6x 4TB SAS HDD in 3x 2-wide mirrors
 * LSI SAS HBA 9300-4i4e
 * 2x 1Gb NICs
 * 2x 10Gb bonded NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `SuperChassis
216BE1C-R920LPB`_ and `Mainboard X10SRL-F`_.

.. _SuperChassis 216BE1C-R920LPB: http://www.supermicro.com/products/chassis/2U/216/SC216BE1C-R920LPB
.. _Mainboard X10SRL-F: http://www.supermicro.com/products/motherboard/Xeon/C600/X10SRL-F.cfm

Account Syncing
===============
kumo copies user accounts from zing every 5 minutes using a key-based login
for the ``senmccarthy`` account. ``senmccarthy`` has permission to execute
``shdwfilter`` via sudo without a password.

ZFS
===
zing uses ZFS for storage. Compression is enabled, and the ZIL is disabled
(sync=disabled). The ZIL is disabled because we don't have a dedicated SLOG and
we want to save the SSDs from the write loads. This trade-off is considered to
be acceptable due to the presence of backups (with ZIL on), a monitored UPS
(resulting in a graceful shutdown in the event of a power outage), and the fact
that disabling the ZIL doesn't lead to OS corruption; it only loses data that
hasn't yet been flushed. We don't host VMs, can regenerate most data, and have
backups for everything else.

NUT
===
zing monitors both UPSs and shares the info to the network. Medusa polls this
info. For more info, read the `power docs <./power>`_.

.. note::
  The network UPS is monitored via a serial port, and thus the ``nut`` user
  needs to be a member of the ``dialout`` group.

