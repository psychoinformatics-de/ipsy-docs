*****
Thunk
*****
Thunk is the backup node. It was purchased 2011.12.

Services
========

* logwatch
* SSH
* backup of all non-compute servers (for more info, read the `backup docs <../backups>`_)

Hardware Specs
==============
Thunk is a 3U server connected to one 2U JBOD.

 * 2x 6-core 2.4 GHz Xeon E5645
 * 96 GiB RAM (12x 8GB DDR3 ECC reg)
 * 2x 80 GB Intel DC S3500 in mdadm RAID 1
 * 21x 4TB SAS HDD as 3x 7-wide RAIDZ2
 * LSI SAS HBA 9207-4i4e
 * 2x 1Gb NICs
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the
`SuperChassis 836E16-R1200B`_ and `Mainboard X8DTH-iF`_.

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

Networking
==========

TODO:
  * firewall
  * IPMI stuff

IPs are:

  * IPMI: 10.54.6.6
  * Data: 141.44.18.76

ZFS
===
Thunk uses ZFS for the backup pool. The most notable configuration is that we
block-level compress /everything/ with gzip-9.

