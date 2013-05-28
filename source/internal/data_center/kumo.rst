.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

****
Kumo
****
Kumo is our web server. 

Services
========
* SSH (protected with fail2ban)
* logwatch
* Apache

 - each domain is documented in its respective site file
 - ``~/public_html`` folders
 - owncloud runs via https

To support user logins, kumo copies the users (with 1000 <= UID <= 9999) from Medusa every 5 minutes.
This is currently done with the ``sen.mccarthy`` script, but that is in the process of being refactored
and extended.

Because of this, the ``/etc/adduser.conf`` has been adjusted so that all new local UIDs and GIDs start
from 10000 (rather than 1000).

(virtual) Hardware Specs
========================
* 2-core, 2 GiB RAM, 250 GiB HD

Management
==========
VM level management is done with the `vSphere Web Client`_. Access is through campus
credentials, and current only I (Alex) have access. The URZ can grant additional access.

.. _vSphere Web Client: https://vcenter.urz.uni-magdeburg.de:9443/vsphere-client/

