.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******
Backups
*******

Laptops and Desktops
====================
There is no centralized backup process for user devices. Some people (especially
Mac users) backup their machines using local software (e.g. time machine). 
Others use DropBox and/or Unison (to Medusa). Different strokes for different folks.

Servers
=======
Mudflap does a nightly backup of critical directories (etc, root, srv, etc) of all
(non-compute) servers. These backups are stored in::

  /jackknife/<machine.name>/

Mudflap does a nightly backup of Flatbed's entire ``home`` and ``data`` datasets.
ZFS snapshots are rotated via zfSnap. Eventually, though not currently, any folder
on Mudflap with .nobackup in it will be deleted.
