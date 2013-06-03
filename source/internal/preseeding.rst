.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**********************
Netboot and Preseeding
**********************

Netboot
=======
The TFTP server is handled (and documented) in ``/etc/dnsmasq.d/medusa.dnsmasq.conf``.

TFTP files are hosted from ``/srv/tftp``. Debian makes this very easy. Just download
and unpack the netboot.tar.gz file for your release of choice into ``/srv/tftp`` and
you can boot straight into the installer.

To automate the install, ``/srv/tftp/pxelinux.cfg/default`` should be edited to look
similar to this:

.. code-block:: bash

  # D-I config version 2.0
  include debian-installer/amd64/boot-screens/menu.cfg
  default debian-installer/amd64/boot-screens/vesamenu.c32

  prompt 1
  timeout 3

  DEFAULT wheezy_amd64

  LABEL wheezy_amd64
     kernel debian-installer/amd64/linux
     append vga=normal initrd=debian-installer/amd64/initrd.gz auto=true interface=auto netcfg/dhcp_timeout=60 netcfg/choose_interface=auto priority=critical url=tftp://10.0.0.254/preseed.cfg DEBCONF_DEBUG=5 IPAPPEND 2

Preseeding
==========
The preseed file is located at ``/srv/tftp/preseed.cfg``. Debian provides an `example preseed.cfg`_
file for each release of Debian.

.. _example preseed.cfg: http://www.debian.org/releases/wheezy/example-preseed.txt

Documentation is located within that file.

