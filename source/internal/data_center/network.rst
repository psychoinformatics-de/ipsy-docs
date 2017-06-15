*************
Network Setup
*************

`Citadel <citadel>`_ is the gateway for the rack. Mulder provides a second point
of entry (but no routing) in case of problems. Those are the only
two machines in the rack that have direct access to the Internet.

Citadel connects to 4 networks

 * egress (green cables)
 * data (grey cables)
 * management (yellow cables for IPMI; orange cables for power)
 * DMZ (purple cables)

All communication between networks is routed through citadel.

Citadel handles routing between networks, NAT, DHCP, internal DNS, and tFTP.

Data Network
============
The data network lives in the ``10.0.0.0/24`` subnet. Each host has a single
1Gb connection to this network, except for:

* medusa: 2x 10Gb
* zing: 2x 10Gb
* snake11: 1x 10Gb

Hardware
--------
1x Switch Netgear XS728T V1

 * 24x 10Gb RJ45
 * 4x 10Gb SFP+
 * with link-aggregation setup for bonded 10Gb hosts
 * wiring convention: port # == snake# (eg. port 3 -> snake3)
 * web interface is at ``10.0.0.230`` (accessible on data network only)

DMZ Network
===========
The data network lives in the ``10.0.2.0/24`` subnet. Nothing is connected to
this network yet.

Hardware
--------
1x Switch HP V1910-48G (JE009A)

 * 48x 1Gb Ports
 * web interface is at ``10.0.2.230`` (accessible on DMZ network only)

Management Network
==================
The management network lives in the ``10.0.1.0/24`` subnet. Each host's IPMI NIC
is connected to this network. Also, the power infrastructure (PDU and UPSs) are
connected to this network.

Hardware
--------
1x Switch HP ProCurve 1700-24 (J9080A)

 * 24x 100Mb Ports
 * wiring convention: port # == snake# (eg. port 3 -> snake3)
 * web interface is at ``10.0.1.232`` (accessible on management network only)
