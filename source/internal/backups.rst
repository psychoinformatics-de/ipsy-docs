.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******
Backups
*******

Laptops and Desktops
====================
There is no centralized backup process for user devices. Some people (especially
Mac users), backup their machines using local software (e.g. time machine). 
Others use DropBox and/or OwnCloud to backup/sync critical documents. While
others use Unison to sync with a directory on Medusa. Different strokes for
different folks.

Servers
=======
Medusa does a nightly backup of critical directories (etc, root, srv, etc) of all other
(non-compute) servers. These backups are stored in:: 

  /home/backups/<machine.name>

Mudflap does a nightly backup of Medusa's entire /home directory (including the
/home/backups directory mentioned above). While this is somewhat wasteful, it keeps
the backup scripts clear and makes it easier to treat Mudflap as a backup head-node.

If a *.nobackup* file exists in a directory, that directory and all child directories 
will be excluded from the backups.

