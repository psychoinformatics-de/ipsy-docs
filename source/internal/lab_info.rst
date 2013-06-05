.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*********
Lab Setup
*********
The technical setup isn't too involved, but has enough nuances to require
documentation.

Network
=======
Across all of our rooms in building 23 and 24 we have one VLAN (98). It offers
DHCP on the ``141.44.98.0/24`` subnet. There is *no* inbound traffic allowed to the
98 VLAN.

.. note:: Currently (23.05.2013) there are still remains of the 396 and 96 VLANs.
          Efforts are ongoing to get the URZ to kill them.

NIS Client Setup
================
NIS is hosted on ``b3``; read below for more specifics.

* The NIS domain is ``ipsy.local``.
* In ``/etc/yp.conf`` set ``ypserver`` to ``141.44.98.5``
* In ``/etc/nsswitch.conf`` set ``passwd``, ``group``, and ``shadow`` to ``files nis``.
* In ``/etc/pam.d/common-account`` add the following line:

.. code-block:: bash

  session    required   pam_mkhomedir.so skel=/etc/skel/ umask=0022

Hardware
========
We host as little hardware as possible in our labs.

OCD
---
This is a Windows computer in 003. For non-Windows users' convenience, it has a patched
termsrv.dll to enable unlimited remote desktop. Multiple users can use the same account
simultaneously. Username is ``neuro`` and password is ``neuro``. It has a static DHCP
lease at ``141.44.98.10``.

b3
--
A small b3 excito box. It has a static DHCP lease at ``141.44.98.5``. It hosts:

* CUPS

 - all printers

* NIS

To support NIS in the labs, b3 copies users (with 1000 <= UID <= 9999) from Medusa every 5 minutes. 

Because of this, the ``/etc/adduser.conf`` has been adjusted so that all new local UIDs and GIDs start
from 10000 (rather than 1000) to avoid conflicts during import.

Ullsperger Color Printer
------------------------
Kyocera FS-C5400DN. It has a static DHCP lease at ``141.44.98.7``.

Pollmann Color Printer
----------------------
A Kyocera FS-C5020N. It has a static DHCP lease at ``141.44.98.8``.

005 Color Printer
-----------------
A Brother MFC-9450CDN. It has a static DHCP lease at ``141.44.98.?``.

.. todo:: Get static lease for printer.

Floor Monochrome Copier/Printer
-------------------------------
An e-STUDIO 256SE. It has a static DHCP lease at ``141.44.96.89``.

