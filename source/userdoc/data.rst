.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**************
Data on Medusa
**************

Where To Put Data
=================
All data in the ``/home`` directory is available throughout the entire cluster.
There are two common places to place data: 1) your home directory, where it
is essentially private. 2) your lab's folder inside ``/home/data``, where other
members of your lab will have read and write access to your data.

Backups
=======
Automatic backups of the entire ``/home`` directory are run nightly. If you
have data that does not need to be backed up (e.g. temporary data, data trivially
regenerated, etc), then please take the time to place a ``.nobackup`` file in the
directory containing that data. All data in/under that folder will be ignored
by the backups. To easily create this file::

  me@medusa:~$ touch global_tax_codes/.nobackup 

If you need to have data recovered from a backup, contact one of the Medusa Admins
and we'll be happy to oblige.

Transferring Data On and Off Medusa
===================================
There are three common tools used to move data on and off of Medusa.

Copying via ``scp``
-------------------
The simplest tool is ``scp``. ``scp`` works similarly to the conventional ``cp``
command, but allows you to copy files over SSH. It is simple, but not terribly 
clever. An example of using scp is::

  me@somewhere:~$ scp -r myanalysisfolder medusa.ovgu.de:~/analysis/

One-way Sync via ``rsync``
--------------------------
Synchronizing is much more efficient and powerful that copying -- and ``rsync`` is *the* 
tool for syncing. Just like ``scp``, ``rsync`` also uses SSH (so it's secure), and has a
very long and detailed manpage explaining the myriad of ways to tweak its behavior.
An example of using rsync is::

  me@somewhere:~$ rsync -avhz --progress myanalysisfolder medusa.ovgu.de:~/analysis/

Two-way Sync via ``unison``
---------------------------
The most sophisticated tool is ``unison``. It performs a two-way sync, watching for 
modifications on both Medusa *and* the remote machine. It syncs files both ways (notifying
the user about potential conflicts). ``Unison`` requires some setup, but it is very useful
if an analysis folder needs to be kept in sync on two machines for more than a few days.
As always, the `Unison manual`_ is a great place to start.

.. _Unison manual: http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html#tutorial
