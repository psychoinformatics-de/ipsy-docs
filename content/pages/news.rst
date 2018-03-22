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
