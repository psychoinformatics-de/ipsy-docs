********************
Power Infrastructure
********************

PDU
===
We have one zero-U 3-phase PDU (mounted vertically). It is a `Raritan PX2-2730`_
and the web admin interface is at ``10.0.1.10``.  It is connected to a red
`IEC_60309`_ power plug. For specifics on which machine is plugged into which
PDU outlet, consult the `rack diagram <index>`_.

.. _Raritan PX2-2730: http://www.raritan.com/product-selector/pdu-detail/px2-2730
.. _IEC_60309: https://en.wikipedia.org/wiki/IEC_60309

UPSs
====
We do not have much battery backup capacity, so only critical equipment is
protected. In the event of a power outage, all other servers will crash
-- hard.

* `APC Smart-UPS SC 1000`_

 - age: ~2009
 - protects router and switches

* `Eaton 5PX 2200`_

 - age: 2012.12
 - protects Medusa and zing

.. note::
  While both UPSs appear to have RJ45 ports, the APC's is for surge protection
  only and the Eaton's is a serial interface. Neither are for management over
  ethernet.

.. _APC Smart-UPS SC 1000: http://www.apc.com/shop/de/de/products/APC-Smart-UPS-SC-1000-VA-230-V-2-U-rackmontiert-Tower/P-SC1000I
.. _Eaton 5PX 2200: http://powerquality.eaton.de/5PX2200iRTN.aspx

NUT
===
Both UPSs are monitored by `zing <zing>`_ via NUT. Medusa runs nut-client to
poll info from zing. If the main UPS (Eaton) reaches **low battery**, both
Medusa and zing will shutdown immediately.
