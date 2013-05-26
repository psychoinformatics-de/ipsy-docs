.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**************
Data on Medusa
**************

Where To Put Data
=================
All data in the ``/home`` directory is available throughout the entire cluster.
There are two common places to put data. 1) Your home directory, where it
is essentially private. 2) Your lab's folder in ``/home/data``, where other
members of your lab will have read and write access to your data.

Backups
=======
Backups of *everything* in the ``/home`` directory are run every night. If you
have data that does not need to be backed up (e.g. temporary data, data trivially
regenerated, etc), then please take the time to place a ``.nobackup`` file in the
directory containing that data. All data in/under that folder will be ignored
by the backups. To easily create this file::

  me@medusa:~$ touch global_tax_codes/.nobackup 

If you need to have data recovered from backups, contact one of the Medusa Admins
and we'll be happy to oblige.

Transfering Data On and Off Medusa
==================================
There are three common tools used to move data on and off Medusa.

Copying via ``scp``
-------------------
The easiest -- and least clever -- tool is ``scp``. ``scp`` works similarly to the 
conventional ``cp`` command, but allows you to copy files over SSH.
Any existing data (with the same filenames) at the destination (Medusa)
is overwritten. An example of using scp is::

  me@somewhere:~$ scp -r myanalysisfolder medusa.ovgu.de:~/analysis/

One-way Sync via ``rsync``
--------------------------
A more clever and complicated tool is ``rsync``. This tool also copies data via
an encrypted connection, but it supports data *synchronization*. This means that
it only copies data if the target file differs from the source. This results in
signficant speedups when doing repeated data transfers of the same files.
``rsync`` offers tons of options to customize its behavior (see its manpage).
An example of using rsync is::

  me@somewhere:~$ rsync -avhz --progress myanalysisfolder medusa.ovgu.de:~/analysis/

Two-way Sync via ``unison``
---------------------------
Even more clever is ``unison``. This tool is able to perform a two-way sync,
meaning that it notices files that are modified on medusa *and* the remote
machine and syncs them in both ways (notifying the users about potential
conflicts). This tool requires time to setup, but is very useful if an analysis folder
needs to be kept in sync on two machines for more than a few days. If you're interested
in this tool, the `Unison manual`_ is a great place to start.

.. _Unison manual: http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html#tutorial
