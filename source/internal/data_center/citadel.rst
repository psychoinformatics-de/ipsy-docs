*******
citadel
*******
Citadel is the router/firewall. It was purchased in ~2016.

Services
========

 * SSH
 * DHCP
 * DNS
 * NAT/Firewall/Routing (via pf)
 * NTPd
 * tFTP

Hardware Specs
==============

 * 1x 2.4 GHz 8-core Atom C2758
 * 8GB RAM
 * 60GB SSD/Flash
 * 2x 1Gb Intel I211
 * 4x 1Gb Intel I350 (SoC Intel I354 Quad GbE on-die MACs)

For more details, read NetGate's specifications of the `SG-8860 1U`_. For a
discussion of the I211 vs the I350, read this `pfSense thread`_.

.. _SG-8860 1U: https://www.netgate.com/products/sg-8860-1u.html
.. _pfSense thread: https://forum.pfsense.org/index.php?topic=124837.0

Networks
========

Citadel routes/networks between the egress, data, management, and DMZ networks.
For more specifics, refer to the networking page.

However, to note, the ports are labeled on the box as::

  WAN | LAN | OPT1 | OPT2 | OPT3 | OPT4

And yet they are enumerated in OpenBSD as::

  em1 | em0 | em2  | em3  | em4  | em5


Serial Port
===========

Mulder is connected to Citadel's USB serial port. To connect, run::

  screen /dev/ttyUSB0 115200

When installing OpenBSD via the serial port, it may loop repeatedly at boot.
This is because it's struggling to find a valid TTY. At the boot prompt, run::

  stty com1 115200
  set ttyl com1

For more information, read `NetGate's instructions`_.

.. _NetGate's instructions: https://www.netgate.com/docs/sg-8860-1u/connect-to-console.html#advanced-configuration

