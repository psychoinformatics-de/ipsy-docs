.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******
Mudflap
*******
Mudflap is the backup server for Medusa. Backups and documentation are
-- hopefully -- done in a way that allows Mudflap to quickly (sub 1 hour)
replace flatbed as the data node in the event of failure. It was purchased
2012.12.

Services
========

* logwatch
* SSH
* backup of Medusa

 - Runs every night (cronjob).
 - creates a snapshot and copies all of Medusa's array (mounted at ``/home``)
   to Mudflap's trucknuts array (mounted at ``/media/backup``)
 - for more info, read the `backup docs <../backups>`_

Hardware Specs
==============
Mudflap is a 1U server connected to two external 2U disk arrays.

 * 4x 8-core 2.6 GHz Opteron 6212
 * 512 GiB RAM (32x 16GB DDR3 ECC reg)
 * 16 TiB formatted storage (19x 2TB SAS Enterprise HDs) in ZFS pool
 * LSI HBA 9212-4i4e 6GB/s SAS Controller
 * 2x bonded Gb NICs (internal network)
 * 1x IPMI NIC

For more details, read Supermicro's detailed specifications of the `A+ Server 1042G-TF`_
and `SuperChassis 826E16-R1200LPB`_.

.. _A+ Server 1042G-TF: http://www.supermicro.com/aplus/system/1u/1042/as-1042g-tf.cfm
.. _SuperChassis 826E16-R1200LPB: http://www.supermicro.com/products/chassis/2u/826/sc826e16-r1200lp.cfm

ZFS
===
Mudflap uses ZFS in place of a traditional hardware RAID setup. Thus far, it has proven
to be reliable, flexible, and scalable. If you don't know much about ZFS, I *highly*
recommend reading up on it first. 

Rather than document everything about the volume (which might become outdated as the volume
evolves), I will instead do a quick overview and provide a few useful ZFS commands.

For a quick overview of all available zpools, run:

.. code-block:: bash

    root@mudflap:~# zpool list
    NAME        SIZE  ALLOC   FREE    CAP  DEDUP  HEALTH  ALTROOT
    trucknuts  18.1T  5.31T  12.8T    29%  1.71x  ONLINE  -

To examine the structure of the zpool, run:

.. code-block:: bash

    root@mudflap:~# zpool status -v trucknuts 
      pool: trucknuts
     state: ONLINE
      scan: scrub repaired 0 in 52h46m with 0 errors on Fri May 10 15:00:39 2013
    config:

            NAME                        STATE     READ WRITE CKSUM
            trucknuts                   ONLINE       0     0     0
              raidz1-0                  ONLINE       0     0     0
                scsi-350014ee500020cc4  ONLINE       0     0     0
                scsi-350014ee555575fe0  ONLINE       0     0     0
                scsi-350014ee5aaac7c88  ONLINE       0     0     0
                scsi-350014ee500020b9c  ONLINE       0     0     0
                scsi-350014ee5aaacb86c  ONLINE       0     0     0
              raidz1-1                  ONLINE       0     0     0
                scsi-350014ee5aaaca358  ONLINE       0     0     0
                scsi-350014ee5000205ec  ONLINE       0     0     0
                scsi-350014ee5555756d4  ONLINE       0     0     0
                scsi-350014ee5aaac30c0  ONLINE       0     0     0
                scsi-350014ee5000206dc  ONLINE       0     0     0
            spares
              scsi-350014ee555575d38    AVAIL   
              scsi-350014ee555575cf0    AVAIL   
    
    errors: No known data errors

Here we see that two vdevs comprise the zpool. Each vdev is running RAIDZ-1 (similar to RAID5)
and two hot spares are available to the entire zpool. In traditional RAID terminology, this is
a RAID 50 with 2 global hot spares.

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

    root@mudflap:~# zfs get all trucknuts
    NAME       PROPERTY              VALUE                  SOURCE
    trucknuts  type                  filesystem             -
    trucknuts  creation              Fri Dec 21 12:39 2012  -
    trucknuts  used                  7.23T                  -
    trucknuts  available             9.96T                  -
    trucknuts  referenced            5.48T                  -
    trucknuts  compressratio         1.00x                  -
    trucknuts  mounted               yes                    -
    trucknuts  quota                 none                   default
    trucknuts  reservation           none                   default
    trucknuts  recordsize            128K                   default
    trucknuts  mountpoint            /media/backup          local
    trucknuts  sharenfs              off                    default
    trucknuts  checksum              on                     default
    trucknuts  compression           off                    default
    trucknuts  atime                 on                     default
    trucknuts  devices               on                     default
    trucknuts  exec                  on                     default
    trucknuts  setuid                on                     default
    trucknuts  readonly              off                    default
    trucknuts  zoned                 off                    default
    trucknuts  snapdir               hidden                 default
    trucknuts  aclinherit            restricted             default
    trucknuts  canmount              on                     default
    trucknuts  xattr                 on                     default
    trucknuts  copies                1                      default
    trucknuts  version               5                      -
    trucknuts  utf8only              off                    -
    trucknuts  normalization         none                   -
    trucknuts  casesensitivity       sensitive              -
    trucknuts  vscan                 off                    default
    trucknuts  nbmand                off                    default
    trucknuts  sharesmb              off                    default
    trucknuts  refquota              none                   default
    trucknuts  refreservation        none                   default
    trucknuts  primarycache          all                    default
    trucknuts  secondarycache        all                    default
    trucknuts  usedbysnapshots       1.73T                  -
    trucknuts  usedbydataset         5.48T                  -
    trucknuts  usedbychildren        20.2G                  -
    trucknuts  usedbyrefreservation  0                      -
    trucknuts  logbias               latency                default
    trucknuts  dedup                 on                     local
    trucknuts  mlslabel              none                   default
    trucknuts  sync                  standard               default
    trucknuts  refcompressratio      1.00x                  -
    trucknuts  written               225G                   -
    trucknuts  snapdev               hidden                 default
