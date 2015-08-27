.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

***********
Data Center
***********
We own a 42U rack in the campus Data Center. The contents of the rack are:

* one `head node <medusa>`_ (medusa)
* one `data node <flatbed>`_ (flatbed with an internal array jackknife)
* ten `compute nodes <compute_nodes>`_ (snake1-10)
* one `backup server <mudflap>`_ (mudflap) with an external array (trucknuts)
* one `XNAT server <mulder>`_ (mulder)
* two `network switches <network>`_ (one for IPMI, the other for data)
* two `UPSs and one zero-U PDU <power>`_

In addition to the contents of our rack, we have two VMs supplied by the URZ:

* `Web server <kumo>`_ - kumo.ovgu.de
* `NeuroDebian server <karr>`_ - neurodebian.ovgu.de (aka karr)

As with any project, there's a few straggling "gotchas" and unfinished ideas.

* Flatbed's SSDs are in drive bays without carriers. We didn't have any 2.5"
  carriers and we originally (and still do) want to install them in unused space
  for a slimline DVD drive. However, there are no extra 4 pin molex or SATA
  power connectors in Flatbed. There were, however, two 4 pin floppy connectors.
  Adapters should be purchased and the SSDs moved.
* The Eaton UPS currently connects from C19 to a C13 outlet. For the sake of
  preserving the few remaining C13s on the PDU and increasing the available
  current to the UPS, a C20(?) to C19 should be used.

.. todo:: Upgrade flatbed's BIOS. See it's page for the saga.

.. toctree::
   :hidden:
   :glob:

   *

The rack layout, as of 22.05.2013:

.. cssclass:: dc-rack

+-----+----+-----------------+----------------+--------------------------------+
| PDU | U# | Name            | Inventory Nr\. | Quick Notes                    |
+=====+====+=================+================+================================+
|     | 1  |                 | 243181,000     |                                |
+ 1   +----+ UPS: 1000 SC    |                |                                |
|     | 2  |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 3  |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 4  |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
| UPS | 5  | Mgmt Switch     |                | 24 Port HP ProCurce 1700-24    |
+-----+----+-----------------+----------------+--------------------------------+
| UPS | 6  | Data Switch     |                | 48 Port HP V1910-48G           |
+-----+----+-----------------+----------------+--------------------------------+
|     | 7  |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 8  |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 9  |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 10 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 11 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 12 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 13 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 14 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 15 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 16 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 17 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 18 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 19 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 20 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
| 10  | 21 | snake10         | 267616,000     | 4x 8-core 2.8 GHz Opteron 6320 |
|     |    |                 |                | 512 GiB RAM                    |
+-----+----+-----------------+----------------+--------------------------------+
| 4 \&| 22 | snake9          | 246831,000     | 1x 8-core 2.0 GHz Opteron 6128 |
| 13  |    |                 |                | 64 GiB RAM                     |
+-----+----+-----------------+----------------+--------------------------------+
|     | 23 |                 | 245075,000     | 1x 4-core 2.67 GHz i7 920      |
+ 19  +----+ snake8          |                | 18 GiB RAM                     |
|     | 24 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
| 33  | 25 | snake7          |                | 4x 16-core 2.4 GHz Opteron 6272|
|     |    |                 |                | 256 GiB RAM                    |
+-----+----+-----------------+----------------+--------------------------------+
| 20  | 26 | snake5 & snake6 |                | each snake:                    |
+-----+----+-----------------+                | 2x 6-core 2.4 GHz Xeon E5645   |
| 21  | 27 | snake3 & snake4 |                | 96 GiB RAM                     |
+-----+----+-----------------+                |                                |
| 22  | 28 | snake1 & snake2 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
| 31  | 29 |                 | 265021,000     | 4x 8-core 2.8 GHz Opteron 6320 |
+ \&  +----+ medusa          |                | 256 GiB RAM                    |
| UPS | 30 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 31 |                 | 260876,000     | 1x 4-core 3.2 GHz Xeon E3-1230 |
+ 27  +----+ mulder          |                | 16 GiB RAM                     |
|     | 32 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
| 32  | 33 | mudflap         |                | 4x 8-core 2.6 GHz Opteron 6212 |
|     |    |                 |                | 512 GiB RAM                    |
+-----+----+-----------------+----------------+--------------------------------+
| 28  | 34 |                 |                | 9x 2 TB drives                 |
+ \&  +----+ trucknuts       |                | 2x 4 TB drives                 |
| 7   | 35 |                 |                | 12 bays                        |
+-----+----+-----------------+----------------+--------------------------------+
| 34  | 36 |                 | 265526,000     | 8x 2 TB drives                 |
+ \&  +----+ trucknuts       |                | 2x 4 TB drives                 |
| 8   | 37 |                 |                | 12 bays                        |
+-----+----+-----------------+----------------+--------------------------------+
|     | 38 |                 |                |                                |
+ 2   +----+                 | 261309,000     | 2x 6-core 2.4 GHz Xeon E5645   |
| \&  | 39 | flatbed         |                | 96 GiB RAM                     |
+ UPS +----+                 |                | 13x 4 TB drives, 3x 80 GB SSDs |
|     | 40 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+
|     | 41 |                 |                |                                |
+ 16  +----+ UPS: 3000 VA    |                | bought: 2012.12                |
|     | 42 |                 |                |                                |
+-----+----+-----------------+----------------+--------------------------------+

The rack's Inventory Nr.: 248252,00

Legend:

* N/I: *not installed* (physically **not** in the rack)
* N/C: *not connected* (physically in the rack)
