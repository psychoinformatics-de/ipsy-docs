Transferring Data
*****************
:order: 525


``scp``

  The simplest tool is ``scp``. It works similarly to the conventional
  ``cp`` command, but allows you to copy files over ``ssh``.::

    me@somewhere:~$ scp -r myanalysisfolder medusa.ovgu.de:~/analysis/

``rsync``

  Synchronizing is much more efficient and powerful that copying -- and ``rsync``
  is *the* tool for syncing. I prefer it for general use, because it (by default),
  checksums every file transferred to guarantee that it was copied
  correctly::

    me@somewhere:~$ rsync -avh --progress folder_here medusa.ovgu.de:~/folder_there/

WinSCP or FileZilla

  If you're on Windows (which has poor CLI support), or you simply prefer a GUI,
  `WinSCP`_ (Windows) and `FileZilla`_ (OS X and Linux) are decent SFTP
  clients.

  To connect to Medusa, install and launch your client. Enter the information
  for host (sftp://medusa.ovgu.de), user, and password. Click connect. The left
  side is your local computer, and the right side is the filesystem on medusa.
  Drag and drop data from one side to the other to transfer.

.. _FileZilla: https://filezilla-project.org/download.php?type=client
.. _WinSCP: https://winscp.net/eng/download.php
