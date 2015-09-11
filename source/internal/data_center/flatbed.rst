.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******
Flatbed
*******
Flatbed is the data node for the cluster. It was purchased 2011.12.

.. note:: Flatbed is /the/ single point of failure.

Services
========

 * NFS (via ZFS) - ``/home`` is shared to all nodes
 * NIS
 * logwatch
 * NUT (UPS monitoring)
 * SSH

Hardware Specs
==============

 * 2x 6-core 2.4 GHz Xeon E5645
 * 96 GiB RAM (12x 8GB DDR3 ECC reg)
 * 2x 80 GB Intel DC S3500 in mdadm RAID 1
 * 21.8 TiB formatted storage (14x 4TB SAS HDs in ZFS RAID 10)
 * LSI SAS HBA 9207-4i4e
 * 2x bonded Gb NICs (internal network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `SuperChassis 836E16-R1200B`_
and `Mainboard X8DTH-iF`_.

.. warning::
  This BIOS (v2.0.0) has a *wonderful* bug. If there are more than 12 boot
  devices (or at least disks), then the list will overflow, and though those
  devices may be detected, they will not be enumerated (and thus never even be
  considered for boot) by the BIOS.

  Thus no USB boot, no PXE boot, booting to drives other than the "first" 12
  detected.

  The fix is to pull all the pool drives, leave the OS drives in place, and
  then boot the install media. No other incantations, juju dances, or
  profanities are known to work.

  I would have updated the BIOS, but I was well behind schedule after 4 hours
  troubleshooting...

.. _SuperChassis 836E16-R1200B: http://www.supermicro.com/products/chassis/3u/836/sc836e16-r1200.cfm
.. _Mainboard X8DTH-iF: http://www.supermicro.com/products/motherboard/qpi/5500/x8dth-if.cfm

Account Syncing
===============
kumo copies user accounts from Flatbed every 5 minutes using a key-based login
for the ``senmccarthy`` account. ``senmccarthy`` has permission to execute
``shdwfilter`` via sudo without a password.

ZFS
===
Flatbed uses `ZFS <../zfs>`_ for storage. Compression is enabled, and the ZIL is
disabled (sync=disabled). The ZIL was disabled due to terrible NFS performance
(as it forces sync) and the budget is not present to install a proper SLOG. This
tradeoff is considered to be acceptable due to the presence of backups (with ZIL
on), a monitored UPS (resulting in a graceful shutdown in the event of a power
outage), and the fact that disabling the ZIL doesn't corrupt the FS, it only
loses data that hasn't yet been flushed. We don't host VMs, can regenerate most
data, and have backups for everything else.

NUT
===
Flatbed monitors both UPSs and shares the info to the network. Medusa polls
this info. For more info, read the `power docs <./power>`_.

.. note::
  The network UPS is monitored via a serial port, and thus the ``nut`` user
  needs to be a member of the ``dialout`` group.

Non-Debian Modifications/Installations
======================================
* ZFS comes from the ZFSonLinux repo.
