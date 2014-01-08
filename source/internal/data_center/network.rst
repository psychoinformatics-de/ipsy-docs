.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*************
Network Setup
*************
The network setup is pretty simple.

`Medusa <medusa>`_ is the gateway to the cluster. Mulder provides a second point
of entry (but no routing) in case of problems with Medusa. Those are the only
two machines in the rack that have direct access to the Internet.

Behind Medusa are two separate networks: data and management. Medusa handles
routing (NAT), DHCP, DNS, etc for both networks. See `Medusa's <medusa>`_
documentation for information on configuring those services

The network cables are color coded.

 * Data is "grey."
 * IPMI (on management network) is "yellow."
 * Power (on management network) is "orange."

Data Network
============
The data network lives in the ``10.0.0.0/24`` subnet. Each host has two connections
to this network, bonded together.

Hardware
--------
1x Switch HP V1910-48G

 * 48x 1Gb Ports
 * with link-aggregation setup for bonded 1Gb to hosts
 * wiring convention: column # == snake# (eg. column 3 [jacks 5 and 6] → snake3)
 * web admin interface is at ``10.0.0.230`` (accessible behind Medusa only)

Management Network
==================
The management network lives in the ``10.0.1.0/24`` subnet. Each host's IPMI NIC
is connected to this network. Also, the power infrastructure (PDU and UPSs) are
connected to this network.

Hardware
--------
1x Switch HP ProCurve 1700-24 (J9080A)

 * 24x 100Mb Ports
 * wiring convention: port # == snake# (eg. port 3 → snake3)
 * web admin interface is at ``10.0.1.232`` (accessible behind Medusa only)
