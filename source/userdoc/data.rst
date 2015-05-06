.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**************
Data on Medusa
**************

Where To Put Data
=================
All data in the ``/home/`` directory is available throughout the entire cluster.
But underneath ``/home/``, there are a few different ways data is organized on
Medusa.

``/home/<user_name>/``

    This directory is for all of your personal files.

``/home/data/<group_name>/``

    This directory is for data shared across the group. Typically shared project
    data is stored here.

``/home/data/scratch/``

    This directory is not backed-up. This is typically used to store interim
    results which can be reasonably easily regenerated. Storing data here helps
    relieve the burned on backups.

``/home/data/archive/<group_name>``

    Read-only and heavily compressed (via cool transparent compression mojo),
    this directory stores data for projects which are completed. If you need to
    archive data, contact Alex and he'll create a project folder for your data.

The "Ideal" Data Workflow
-------------------------
This certainly won't apply to everyone in every situation, but as a base example
for how a "typical" workflow could work.

``/home/rockstar``

  Other than a few private scripts, ``/home/rockstar`` doesn't contain much
  data. Ms. Rockstar is a sociable scientist and doesn't slave away in the
  darkness; she loves the light and actively collaborates with others in her lab.

``/home/data/psyinf/hasselhoff``

  "Hasselhoff" is the name of her project, so she kindly asks Alex to setup a
  dedicated folder for her project. Alex creates two folders:

  * ``/home/data/psyinf/hasselhoff/``
  * ``/home/data/psyinf/hasselhoff/RAW/``

  The ``RAW`` folder is for the EEG and 3T data she is collecting. Alex setup
  that directory so that everything placed within it is automatically,
  transparently, and magically compressed. Once she is done collecting data,
  Ms. Rockstar tells Alex, and he marks the ``RAW`` folder as readonly to
  prevent accidental modifications of this data.

  Ms. Rockstar and her colleagues create whatever directory structure makes
  sense to them under the ``/home/data/psyinf/hasselhoff/`` folder.

``/home/data/scratch/hasselhoff``

  Project Hasselhoff is a complex project, not to be taken lightly. It involves
  many steps and generates quite a bit of data. However, these interim
  data-sets, though numerous, are easily regenerated. This is because Ms.
  Rockstar scripts all of her analysis steps and submits those scripts using
  `Condor <condor>`_.

  Thus, these interim, data-heavy steps are stored in the ``scratch`` folder to
  alleviate the backup pain Alex must endure. She also created a ``hasselhoff``
  subfolder because she's organized like that. Being sloppy would reflect
  poorly on her project management skills, which are excellent.

``/home/data/archive/psyinf/hasselhoff``

  The project is completed, broke new ground, led to three articles published in
  Nature, and the first Fields Medal ever awarded to a neuroscientist.

  Ms. Rockstar asks Alex to create an archive folder for her. He promptly
  complies, and she moves the relevant, well-organized data, code, and
  documentation into the Hasselhoff archive folder. She then deletes any
  unneeded data relating to her project from her home folder, group folder, and
  scratch folder.

  She lets Alex know when she is done archiving, and he marks the archive folder
  as readonly.

Backups
=======
Automatic backups of the entire ``/home/`` directory (with the exception of
``/home/data/scratch/``) are run at 07:00 every day. If you have data that does
not need to be backed up (e.g. temporary data, data easily regenerated, etc),
then please place that data in ``/home/data/scratch/``

The backup retention policy is:
  * daily backups kept for 2 weeks
  * weekly backups kept for 6 weeks
  * monthly backups kept for 1 year
  * yearly backups kept "forever"

If you need to have data recovered from a backup, contact Alex and he'll help
you out.

Transferring Data On and Off Medusa
===================================
There are a few common tools used to move data on and off of Medusa.

Copying via ``scp``
-------------------
The simplest tool is ``scp``. ``scp`` works similarly to the conventional ``cp``
command, but allows you to copy files over SSH. It is simple, but not terribly
clever. An example of using scp is::

  me@somewhere:~$ scp -r myanalysisfolder medusa.ovgu.de:~/analysis/

One-way Sync via ``rsync``
--------------------------
Synchronizing is much more efficient and powerful that copying -- and ``rsync``
is *the* tool for syncing. Just like ``scp``, ``rsync`` also uses SSH (so it's
secure), and has a very long and detailed manpage explaining the myriad of ways
to tweak its behavior. An example of using rsync is::

  me@somewhere:~$ rsync -avhz --progress myanalysisfolder medusa.ovgu.de:~/analysis/

Two-way Sync via ``unison``
---------------------------
The most sophisticated tool is ``unison``. It performs a two-way sync, watching
for modifications on both Medusa *and* the remote machine. It syncs files both
ways (notifying the user about potential conflicts). ``Unison`` requires some
setup, but it is very useful if an analysis folder needs to be kept in sync on
two machines for more than a few days. As always, the `Unison manual`_ is a
great place to start.

.. _Unison manual: http://www.cis.upenn.edu/~bcpierce/unison/download/releases/stable/unison-manual.html#tutorial

FileZilla: For those who love their GUIs
----------------------------------------
If you're on Windows (which has poor CLI support), or you simply prefer a GUI
because you love to click, `FileZilla`_ is a great SFTP client.

To connect to Medusa, install and launch FileZilla. On the top toolbar, enter
the information for host (medusa.ovgu.de), user, and password. Click connect.
The left side is your local computer, and the right side is the filesystem on
medusa. Drag and drop data from one side to the other to transfer.

.. _FileZilla: https://filezilla-project.org/download.php?type=client
