News
####
:order: 999

Known Issues
************
* "Some" ``.hdf5`` files remain locked after initial creation. The source of
  this problem is elusive, and makes little sense.

  The current work-around is to ``cp`` the file and then ``mv`` the copy over
  the original. This forces the file to be assigned a new inode, which
  invalidates the in-file locking. Madness.

Events
******
2020.02.05 - Major update to the docs
  The majority of content from the INM-7 Docs has been ported over and adapted
  for IPSY. This represents over a year's worth of documentation fixes and
  improvements.

2020.02.04 - Dotfiles updated
  The `Dotfiles repo </services/hosted/#dotfiles>`_ has been been entirely
  overhauled, porting fixes and improvements from the INM-7 dotfiles. It is
  located at ``/home/git/dotfiles.git`` on Medusa.

2019.11.10 - Degraded data array on Medusa
  Zing (the data node) currently has a bad SSD drive in one of its arrays.
  The rebuild completed successfully with no data loss.

2019.08.01 - snake12 down
  ``snake12`` has a hardware failure and needs to be repaired.

2018.12.17 - ZFS upgrade and reboot; IPython history functional again
  The data node's version of ZFS was upgraded to 0.7.12. This brings a wide
  range of fixes.

  The cluster was rebooted for the update to take effect.

  As a result of the reboot, the `IPython history problem
  <https://github.com/psychoinformatics-de/ipsy-docs/commit/f9bae54da96c582194cb29fb3a7efe955400e14d>`_
  was cleared, though unfortunately not fully understood.

2018.12.14 - SPSS 25
  SPSS 25 has been packaged for Debian. The university's SPSS 24 license has
  expired, so to continue using SPSS, you must upgrade to this new package. To
  upgrade, simply run ``apt-get update`` and ``apt-get install ipsy-spss25``.

2018.08.31 - ZFS upgrade
  The data node's version of ZFS was upgraded to 0.7.9. This brings a wide range
  of fixes.

  The cluster was rebooted for the update to take effect.

2018.08.02 - Wine 3.0.1 installed cluster-wide
  If you really need to shoe-horn your Windows-based workflow onto our Debian
  cluster, then there is a small ray of hope for you. If you can get your
  application to run via Wine 3.0.x, you can now run it across the entire cluster.

2018.07.09 - Increased number of Matlab toolbox licenses
  The university has a new licensing agreement with Mathworks. In all
  practicality, there are now an unlimited number of Matlab and toolbox licenses
  (10,000).

  Thus, Matlab users on Condor no longer need to limit the number of compute
  nodes used due to licensing constraints. The `Condor/Matlab documentation
  <{filename}medusa/condor.rst#matlab>`_ has been updated to reflect this.

2018.07.09 - Fixed swap vs /tmp disk allocation on compute nodes
  Due to a bug in the installation's preseed configuration, compute nodes with
  large hard drives were allocating the excess space to the swap partition
  rather than the ``/tmp`` directory. This has been fixed, and all nodes have
  been reinstalled.

  It is now possible for jobs to run which need a large amount of local disk
  space rather than NFS.

2018.07.06 - Updated nibabel, nipype, indexed-gzip, fsleyes
  Updated version of these packages have been installed, which should finally
  allow them all to coexist in fully updated harmony. Previously, many tools
  were displaying warnings, and a downgraded version of nibabel was needed to
  keep everything functional.

2018.06.13 - Signing Key for IPSY's Debian Repo Expired
  The signing key for IPSY repository of Debian packages on Kumo expired. It has
  been updated and the updated key deployed to all cluster systems. If this is
  affecting you on your local system, run the following:

  * ``curl http://kumo.ovgu.de/debian/ipsy_apt.gpg.key | sudo apt-key add -``
  * ``sudo apt-get update``
  * ``sudo apt-get install --only-upgrade ipsy-keyring``

  If prompted about a conflicting ``ipsy.gpg`` file, respond with ``Y``.

2018.04.11 - Condor jobs fail to start on snake4
  When jobs attempted to run on snake4, they would bounce between running and
  idle and complain in the logs about a "Shadow Exception". The cause was a
  deeply mangled /etc/passwd file. The node has been reinstalled.

2018.04.05 - fsleyes crashes on start
  An updated dependency of fsleyes caused it to crash. The bug was reported,
  the upstream maintainer released a fix, and that fix has now been deployed.

2018.03.16 - DataLad Upgrade
  DataLad was upgraded and moved from a system package to a singularity
  container. Most users shouldn't notice a difference, but if you were using any
  of its Python libraries directly, they are no longer installed system-wide.

2018.03.13 - HeuDiConv/Nipype Fixed
  Nipype was failing (prematurely), complaining about an outdated version of
  Pydot. Until the real fix is applied, an updated version of Pydot has been
  backported, which seems to resolve the problem.

2018.03.11 - ZFS upgrade
  The data node's version of ZFS was upgraded to 0.7.6. This brings a wide range
  of fixes, especially performance related. Hopefully this will end the elusive
  "some files, take 1+ minute each to delete" problem.

  The cluster was rebooted for the update to take effect.
