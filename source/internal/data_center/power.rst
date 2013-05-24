.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

********************
Power Infrastructure
********************
The power setup is very simple.

PDU
===
We have one zero-U 3-phase PDU (mounted vertically). It is a Raritan PX2-2730 and the management interface 
is at https://10.0.1.231/ (accessible behind Medusa only). It is connected to a red `IEC_60309`_ power plug.
For specifics on which machine is plugged into which PDU outlet, consult the `rack diagram <index.html>`_.

.. _IEC_60309: https://en.wikipedia.org/wiki/IEC_60309

UPSs
====
We do not have much battery backup capacity, so we only backup critical services.

.. note:: Neither of these UPSs are connected to power or the network. This should change soon. (23.05.2013).

* APC Smart-UPS SC 1000
 - only connected to the Management and Data switches

* APC Smart-UPS 3000VA
 - only Medusa is connected
 - will shutdown Medusa if power outage exceeds a few minutes

