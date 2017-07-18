******
Medusa
******
Medusa provides critical services (interactive SSH, condor master, etc) for
computational nodes. It was purchased 2013.12.

.. note::
  Medusa is increasingly becoming disposable. Real effort should go into
  packaging config files and writing a backup restore script. Then any other
  node can easily take over the job of head-node.

Internal Services
=================

 * exim4
 * logwatch

External Services
=================

 * SSH (protected with fail2ban)
 * Ganglia's ``gmetad``

  - Collects ``gmond`` data from self and all compute nodes
  - Exposed on TCP 8651 to kumo.ovgu.de (both as a custom ``pf`` rule and in ``gmetad.conf``.

Hardware Specs
==============

 * 4x 8-core 2.8 GHz Opteron 6320
 * 256 GiB RAM (16x 16GiB DDR3 ECC reg)
 * 3x 2TB in RAID 1
 * 2x 1Gb NICs
 * 2x bonded 10Gb NICs
 * 1x 1Gb NIC (external network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `A+ Server 2042G-TRF`_.

.. _A+ Server 2042G-TRF: http://www.supermicro.com/aplus/system/2u/2042/as-2042g-trf.cfm

Resource Limits
===============
Since Medusa is the primary method of interacting with the cluster, it is
important to protect it from user error.  Thus, special resource limits are set
on Medusa (``/etc/security/limits.d/protect_mainnode.conf``).  No process can
use more than 16GiB on Medusa. There are no restrictions on the compute nodes.
