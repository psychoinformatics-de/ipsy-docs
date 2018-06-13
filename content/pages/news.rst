News
****
:order: 999

Known Issues
------------
* "Some" ``.hdf5`` files remain locked after initial creation. The source of
  this problem is elusive, and makes little sense.

  The current work-around is to ``cp`` the file, and then ``mv`` the copy over
  the original. This forces the file to be assigned a new inode, which
  invalidates the in-file locking. Madness.

Events
------
2018.06.13 - Signing Key for IPSY's Debian Repo Expired
  The signing key for IPSY repository of Debian packages on Kumo expired. It has
  been updated and the updated key deployed to all cluster systems. If this is
  affecting you on your system, run the following:

  * ``curl http://kumo.ovgu.de/debian/ipsy_apt.gpg.key | sudo apt-key add -``
  * ``sudo apt-get update``
  * ``sudo apt-get install --only-upgrade ipsy-keyring``

  If prompted about a conflicting ``ipsy.gpg`` file, respond with ``Y``.

2018.04.11 - Condor jobs fail to start on snake4
  When jobs attempted to run on snake4, they would bounce between running and
  idle and complain in the logs about a "Shadow Exception". The cause was a
  deeply mangled /etc/passwd file. The node has been reinstalled.

2018.04.05 - fsleyes crashes on start
  An updated dependency of fsleyes caused it to crash. The bug was reported and
  the upstream maintainer released a fix.

2018.03.16 - DataLad Upgrade
  DataLad was upgraded and moved from a system package to a singularity
  container. Most users shouldn't notice a difference, but if you were using any
  Python libraries directly, they are no longer installed system-wide.

2018.03.13 - HeuDiConv/Nipype Fixed
  Nipype was failing (prematurely), complaining about an outdated version of
  Pydot. Until the real fix is applied, an updated version of Pydot has been
  backported, which seems to resolve the problem.

2018.03.11 - ZFS upgrade
  The data node's version of ZFS was upgraded to 0.7.6. This brings a wide range
  of fixes, especially performance related. Hopefully this will end the elusive
  "some files, take 1+ minute each to delete" problem.

  The cluster was rebooted for the update to take effect.
