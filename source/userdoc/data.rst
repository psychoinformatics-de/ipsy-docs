.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**************
Data on Medusa
**************

Where to put my data
====================

There are essentially two places to put data on Medusa. The first is a user's
home directory. Data put there is available throughout the cluster and is
appropriate for anything that does not need to be shared with other users.
Data that needs to be accessible (and writable) by multiple users is best
placed in ``/home/data``. In this directory, each lab has a folder that can
only be accessed by the members of each respective lab.


Is it better to copy my data to Medusa, or shall I access it over the network?
==============================================================================

In most cases, it is better to copy data to Medusa before doing any kind of
processing. Accessing remote data is slower, wastes bandwidth, and is often
less reliable.

Data transfer on and off Medusa
===============================

There are at least three simple ways to move data on and off Medusa.

Copying via ``scp``
-------------------

The easiest -- and least clever -- solution is copying data via secure copy
(aka ``scp``). This opens an encrypted connection to medusa and copies data
to is. Any existing data (with the same filenames) at the destination (medusa)
is overwritten. An example of using scp is::

  me@somewhere% scp myanalysisfolder medusa.ovgu.de:~/analysis/


One-way sync via ``rsync``
--------------------------

A more clever and complicated tool is ``rsync``. This tool also copies data via
an encrypted connection, but it supports data *synchronization*. This means that
it only copies data if the target file differs from the source. This results in
signficant speedups when doing repeated data transfers of the same files.
``rsync`` offers tons of options to customize its behavior (see its manpage).
An example of using rsync is::

  me@somewhere% rsync -avhz --progress myanalysisfolder medusa.ovgu.de:~/analysis/

Two-way sync via ``unison``
---------------------------

Even more clever is ``unison``. This tool is able to perform a two-way sync,
meaning that it notices files that are modified on medusa *and* the remote
machine and syncs them in both ways (notifying the users about potential
conflicts). In comparison to ``scp`` and ``rsync``, the setup is a little more
complex, but this tool is recommended whenever an analysis folder needs to be
kept in sync on two machine for a longer period than a few days. Here is the unison manual:

http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html#tutorial
