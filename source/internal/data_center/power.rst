.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

********************
Power Infrastructure
********************
The power setup is simple. 

PDU
===
We have one zero-U 3-phase PDU (mounted vertically). It is a `Raritan PX2-2730`_ and the web admin interface 
is at https://10.0.1.231/ (accessible behind Medusa only). It is connected to a red `IEC_60309`_ power plug.
For specifics on which machine is plugged into which PDU outlet, consult the `rack diagram <index>`_.

.. _Raritan PX2-2730: http://www.raritan.com/px-2000/px2-2730/tech-specs/
.. _IEC_60309: https://en.wikipedia.org/wiki/IEC_60309

UPSs
====
We do not have much battery backup capacity, so only critical equipment is protected. In the event of a power
outage, all other servers will crash -- hard.

.. note:: Neither of these UPSs are active at the moment. This should change soon. (23.05.2013).

* APC Smart-UPS SC 1000

 - protects only the Management and Data switches

* APC Smart-UPS 3000VA

 - protects only Medusa
 - will shutdown Medusa if power outage exceeds a few minutes

