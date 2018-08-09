Data on Medusa
**************
:order: 520

Folder Hierarchy
----------------
All data in the ``/home`` directory is available across the entire cluster.

``/home/<user_name>``
  This directory is for all of your personal files.

``/home/data/<project_name>``
  This directory is for data shared across the group/project.

``/home/<user_name>/scratch`` or ``/home/data/<project_name>/scratch``
  This directory is not backed-up and should be used to store interim results
  which can be easily regenerated. Storing data here helps relieve the burden
  on backups.

``/home/data/archive/<project_name>``
  Read-only and heavily compressed (via cool transparent compression mojo),
  this directory stores data for projects which are completed. If you need to
  archive data, contact Alex and he'll create a project folder for your data.

The "Ideal" Data Layout
-----------------------
This certainly won't apply to everyone in every situation, but as a base example
for how a "typical" workflow could work.

``/home/rockstar``
  Other than a few private scripts, ``/home/rockstar`` doesn't contain much
  data. Ms. Rockstar is a sociable scientist and doesn't slave away in the
  darkness; she loves the light and actively collaborates with others in her lab.

``/home/data/hasselhoff``
  "Hasselhoff" is the name of her project, so she kindly asks Alex to setup a
  dedicated folder for her project. Alex creates the following folders:

  * ``/home/data/hasselhoff``
  * ``/home/data/hasselhoff/RAW``
  * ``/home/data/hasselhoff/scratch``

  The ``RAW`` folder is for the EEG and 3T data she is collecting. Alex setup
  that directory so that everything placed within it is automatically,
  transparently, and magically compressed. Once she is done collecting data,
  she notifies Alex and he marks the ``RAW`` folder as readonly to
  prevent accidental modifications of this data.

  Ms. Rockstar and her colleagues create whatever directory structure makes
  sense to them under the ``/home/data/hasselhoff`` folder.

``/home/data/hasselhoff/scratch``
  Project Hasselhoff is a complex project, not to be taken lightly. It involves
  many steps and generates quite a bit of data. However, these interim
  data-sets, though numerous, are easily regenerated. This is because Ms.
  Rockstar scripts all of her analysis steps and submits those scripts using
  `Condor <{filename}condor.rst>`_.

  Thus, these interim, data-heavy steps are stored in the ``scratch`` folder to
  alleviate stress on the backups.

``/home/data/archive/psyinf/hasselhoff``
  The project is completed, broke new ground, led to three articles published in
  Nature, and the first Fields Medal ever awarded to a neuroscientist.

  Ms. Rockstar asks Alex to create an archive folder for her. He promptly
  complies, and she moves the relevant, well-organized data, code, and
  documentation into the Hasselhoff archive folder. She then deletes any
  unneeded data relating to her project from her home folder, project folder,
  and scratch folder.

  She lets Alex know when she is done archiving, and he marks the archive folder
  as readonly.

Copying to/from Medusa
----------------------
``scp``
  The simplest tool is ``scp``. It works similarly to the ``cp`` command, but
  allows you to copy files over ``ssh``.

  .. code::

    scp -r myanalysisfolder medusa.ovgu.de:~/analysis/

``rsync``
  Synchronizing is more powerful and efficient than copying — and ``rsync``
  is *the* tool for syncing. I prefer it for general use, because it (by
  default) checksums every file transferred to guarantee that it was copied
  correctly.

  .. code::

    rsync -avh --progress dir_here/ medusa.ovgu.de:~/dir_there

WinSCP or Cyberduck
  If you're on Windows (which has poor CLI support) or you simply prefer a GUI,
  `WinSCP`_ (Windows) and `Cyberduck`_ (macOS and Windows) are decent SFTP
  clients.

  To connect to Medusa: install and launch your client. Enter the information
  for host (sftp://medusa.ovgu.de), user, and password. Click connect. Now you
  are connected. Drag and drop data to transfer.

.. _WinSCP: https://winscp.net/eng/download.php
.. _Cyberduck: https://cyberduck.io
