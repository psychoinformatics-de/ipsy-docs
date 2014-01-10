.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

***
ZFS
***
Mudflap and Flatbed both use ZFS in place of traditional hardware RAID. Thus far,
it has proven to be reliable, flexible, and scalable when provided with the correct
hardware. ZFS challenges many preconceptions about file systems, and it is very easy
to end up in a suboptimal situation if you don't have the proper understanding of
its architecture. There is a lot of misinformation out there as a result.
If you don't know much about ZFS, I *highly* recommend reading up on it first.
Two sites which I found to be helpful (though no canonical) are `pthree.org`_ and
the `ZFS Evil Tuning Guide`_.

.. _pthree.org: https://pthree.org/2013/01/03/zfs-administration-part-xvii-best-practices-and-caveats/
.. _ZFS Evil Tuning Guide: http://www.solarisinternals.com/wiki/index.php/ZFS_Evil_Tuning_Guide

Rather than document everything about the pools (which might become outdated as the volume
evolves), I will instead do a quick overview and provide a few useful ZFS commands.

For a quick overview of all available zpools, run:

.. code-block:: bash

    root@flatbed:~# zpool list
    NAME        SIZE  ALLOC   FREE    CAP  DEDUP  HEALTH  ALTROOT
    jackknife  14.5T  8.26T  6.24T    56%  1.00x  ONLINE  -

To examine the structure of the zpool, run:

.. code-block:: bash

    root@flatbed:~# zpool status -v jackknife 
      pool: jackknife
     state: ONLINE
      scan: scrub repaired 0 in 5h28m with 0 errors on Sat Jan  4 10:28:49 2014
    config:

        NAME                        STATE     READ WRITE CKSUM
        jackknife                   ONLINE       0     0     0
          mirror-0                  ONLINE       0     0     0
            scsi-35000c500572823cb  ONLINE       0     0     0
            scsi-35000c5005727c85b  ONLINE       0     0     0
          mirror-1                  ONLINE       0     0     0
            scsi-35000c5005727d7fb  ONLINE       0     0     0
            scsi-35000c500572816fb  ONLINE       0     0     0
          mirror-2                  ONLINE       0     0     0
            scsi-35000c50056a36393  ONLINE       0     0     0
            scsi-35000c5005727658f  ONLINE       0     0     0
          mirror-3                  ONLINE       0     0     0
            scsi-35000c50057288c7f  ONLINE       0     0     0
            scsi-35000c50056d0c837  ONLINE       0     0     0
        spares
          scsi-35000c50056ea4b0b    AVAIL   

    errors: No known data errors

Here we see that four vdevs comprise the zpool. Each vdev is mirrored, and one
hot spare is available to the entire zpool. In traditional RAID terminology,
this is a RAID 10 array with 1 global hot spare.

To list the snapshots on the zpool, run:

.. code-block:: bash

    root@mudflap:~# zfs list -t snapshot
    NAME                        USED  AVAIL  REFER  MOUNTPOINT
    trucknuts@2013.01.08.0906  7.48G      -  1.68T  -
    ... <snip /> ...
    trucknuts@2013.05.18.2245   104M      -  5.40T  -
    trucknuts@2013.05.19.2245   326M      -  5.40T  -
    trucknuts@2013.05.20.2245   180M      -  5.40T  -
    trucknuts@2013.05.21.0945   102M      -  5.40T  -
    trucknuts@2013.05.21.2245   103M      -  5.40T  -
    trucknuts@2013.05.22.2245  2.17G      -  5.41T  -

To get all of the deduplication statistics, run:

.. code-block:: bash

    root@mudflap:~# zdb -DD trucknuts
    DDT-sha256-zap-duplicate: 11979918 entries, size 396 on disk, 176 in core
    DDT-sha256-zap-unique: 30419118 entries, size 373 on disk, 163 in core

    DDT histogram (aggregated over all DDTs):

    bucket              allocated                       referenced          
    ______   ______________________________   ______________________________
    refcnt   blocks   LSIZE   PSIZE   DSIZE   blocks   LSIZE   PSIZE   DSIZE
    ------   ------   -----   -----   -----   ------   -----   -----   -----
         1    29.0M   2.99T   2.99T   2.98T    29.0M   2.99T   2.99T   2.98T
         2    9.11M    975G    975G    974G    22.2M   2.36T   2.36T   2.36T
         4    1.77M    200G    200G    200G    8.68M    986G    986G    985G
         8     434K   43.4G   43.4G   43.4G    4.54M    461G    461G    461G
        16    85.9K   6.48G   6.48G   6.48G    1.67M    127G    127G    127G
        32    33.6K   3.83G   3.83G   3.82G    1.37M    159G    159G    159G
        64    5.47K    606M    606M    605M     482K   51.9G   51.9G   51.8G
       128    1.42K    138M    138M    138M     232K   21.5G   21.5G   21.5G
       256      425   34.9M   34.9M   34.9M     147K   12.2G   12.2G   12.2G
       512      288   21.5M   21.5M   21.5M     203K   14.5G   14.5G   14.5G
        1K       62   1014K   1014K   1.01M    86.6K   1.22G   1.22G   1.25G
        2K       50    843K    843K    856K     132K   2.46G   2.46G   2.50G
        4K        9   10.5K   10.5K   13.6K    52.7K   60.5M   60.5M   79.2M
        8K        8      8K      8K   10.4K    80.0K   75.8M   75.8M    102M
       16K        2      1K      1K   1.60K    38.3K   19.1M   19.1M   30.6M
      256K        1    128K    128K    128K     271K   33.9G   33.9G   33.8G
     Total    40.4M   4.19T   4.19T   4.18T    69.1M   7.18T   7.18T   7.17T

    dedup = 1.71, compress = 1.00, copies = 1.00, dedup * compress / copies = 1.72

For a list of all configured options on a zpool, run:

.. code-block:: bash

   root@flatbed:~# zfs get all jackknife
   NAME       PROPERTY              VALUE                  SOURCE
   jackknife  type                  filesystem             -
   jackknife  creation              Thu Dec 12 17:40 2013  -
   jackknife  used                  8.26T                  -
   jackknife  available             6.01T                  -
   jackknife  referenced            30K                    -
   jackknife  compressratio         1.09x                  -
   jackknife  mounted               yes                    -
   jackknife  quota                 none                   default
   jackknife  reservation           none                   default
   jackknife  recordsize            128K                   default
   jackknife  mountpoint            /jackknife             default
   jackknife  sharenfs              off                    default
   jackknife  checksum              on                     default
   jackknife  compression           lzjb                   local
   jackknife  atime                 off                    local
   jackknife  devices               on                     default
   jackknife  exec                  on                     default
   jackknife  setuid                on                     default
   jackknife  readonly              off                    default
   jackknife  zoned                 off                    default
   jackknife  snapdir               hidden                 default
   jackknife  aclinherit            restricted             default
   jackknife  canmount              on                     default
   jackknife  xattr                 on                     default
   jackknife  copies                1                      default
   jackknife  version               5                      -
   jackknife  utf8only              off                    -
   jackknife  normalization         none                   -
   jackknife  casesensitivity       sensitive              -
   jackknife  vscan                 off                    default
   jackknife  nbmand                off                    default
   jackknife  sharesmb              off                    default
   jackknife  refquota              none                   default
   jackknife  refreservation        none                   default
   jackknife  primarycache          all                    default
   jackknife  secondarycache        all                    default
   jackknife  usedbysnapshots       0                      -
   jackknife  usedbydataset         30K                    -
   jackknife  usedbychildren        8.26T                  -
   jackknife  usedbyrefreservation  0                      -
   jackknife  logbias               latency                default
   jackknife  dedup                 off                    default
   jackknife  mlslabel              none                   default
   jackknife  sync                  disabled               local
   jackknife  refcompressratio      1.00x                  -
   jackknife  written               0                      -
   jackknife  snapdev               hidden                 default

