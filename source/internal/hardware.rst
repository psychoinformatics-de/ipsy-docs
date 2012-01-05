.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**************
Hardware setup
**************



Stress test
===========

CPU
---

After an initial setup I ran a stress test using a cluster-wide searchlight
analysis. That means 24 Python processes running at 100% load per machine, on
each of the 6 compute nodes. After a cluster-wide average machine load of 24 for
15 minutes the CPU temperature did not get to 35C on any node. No change of the
picture at the 30 min mark.
