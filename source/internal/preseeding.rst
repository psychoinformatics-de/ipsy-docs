**********************
Netboot and Preseeding
**********************

Everything is hosted from citadel.


Netboot
=======
The tFTP server is handled in ``/etc/tftpd.conf`` and files are server from
``/pxe``. Which hosts PXE boot is controlled in ``/etc/dhcpd.conf``, and pf has
FTP anchoring setup to it all works.
