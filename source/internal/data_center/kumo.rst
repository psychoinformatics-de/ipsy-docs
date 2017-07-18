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
 - Ganglia web frontend

* Ganglia's ``gmetad``

 - Polls ``gmetad`` instance on medusa.ovgu.de for use on web front-end. No ports are exposed on Kumo.

To support user logins, kumo copies the users (with 1000 <= UID <= 9999) from
Medusa every 5 minutes.

Because of this, the ``/etc/adduser.conf`` has been adjusted so that all new
local UIDs and GIDs start from 10000 (rather than 1000).

Also, to automatically create home folders when users login, I adding the
following line to ``/etc/pam.d/common-account``::

  session    required   pam_mkhomedir.so skel=/etc/skel/ umask=0022

Also, ``/etc/skel/`` has an empty ``public_html`` folder and a symlink ``srv_www
-> /srv/kumo.ovgu.de`` added for users.

(virtual) Hardware Specs
========================
* 2-core, 2 GiB RAM, 250 GiB HD

Management
==========
VM level management is done with the `vSphere Web Client`_. Access is through campus
credentials, and current only I (Alex) have access. The URZ can grant additional access.

.. _vSphere Web Client: https://vcenter.urz.uni-magdeburg.de:9443/vsphere-client/
