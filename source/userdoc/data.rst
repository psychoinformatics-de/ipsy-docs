.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**************
Data on Medusa
**************

Data transfer on and off Medusa
===============================

There are at least three simple ways to move data on and off Medusa.

Copying via ``scp``
-------------------

The easiest, but also least clever, solution as copying data via secure copy,
aka ``scp``. The will open an encrypted connection to medusa and copy data from
a remote machine. Any existing data (with the same filenames) is overwritten.
This might look like this::

  me@somewhere% scp myanalysisfolder medusa.ovgu.de:~/analysis/


One-way sync via ``rsync``
--------------------------

A little more clever is ``rsync``. This tool will also copy data via an
encrypted connection, but it supports data synchronization. This means that it
will only copy data if the target file differs from the source. This yield
enormous speed ups when doing repeated data transfers of the same files.
``rsync`` offers tons of options to customize its behavior (see its manpage).
Using rsync might look like this::

  me@somewhere% rsync -avz myanalysisfolder medusa.ovgu.de:~/analysis/

Two-way sync via ``unison``
---------------------------

Even more clever is ``unison``. This tool is able to perform a two-way sync,
meaning it notices files that have been modified on medusa *and* the remote
machine and sync them in both ways (notifying the users about potential
conflicts). In comparison to ``scp`` and ``rsync`` the setup is a little more
complex, but this tool is recommended whenever an analysis folder needs to be
kept in sync on two machine for a longer than a few days. Here is the unison manual:

http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html#tutorial


