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

Hardware
========
We host as little hardware as possible in our labs.

b3
--
A small b3 excito box. It has a static DHCP lease at ``141.44.98.5``. It hosts:

* CUPS

 - all printers

* NIS

To support NIS in the labs, b3 copies users (with 1000 <= UID <= 9999) from Medusa nightly. 
This is currently done with the ``sen.mccarthy`` script, but that is in the process of being refactored 
and extended.

Because of this, the ``/etc/adduser.conf`` has been adjusted so that all new local UIDs and GIDs start
from 10000 (rather than 1000) to avoid conflicts during import.

Ullsperger Color Printer
------------------------
Kyocera FS-C5400DN. It has a static DHCP lease at ``141.44.98.7``

Pollmann Color Printer
----------------------
A Kyocera FS-C5020N. It has a static DHCP lease at ``141.44.98.8``

Floor Monochrome Copier/Printer
-------------------------------
An e-STUDIO 256SE. It has a static DHCP lease at ``141.44.96.89``

