.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

.. _condordoc:

**************************************
Condor: Submit and manage cluster jobs
**************************************

Medusa uses Condor_ to manage cluster jobs. Condor_ is a very powerful and
flexible that is, in addition, also very well documented. The HTML manual for
the currently installed version of Condor can be found at
``/usr/share/doc/condor/html/`` on Medusa. Moreover, the manual for various
recent Condor releases is also available `online
<http://research.cs.wisc.edu/condor/manual/>`_.

.. _Condor: http://research.cs.wisc.edu/condor/

While Condor can do many things most users will only need to know about a few
pieces to use it efficiently. Everybody is strongly encouraged to read chapter
2 of the Condor manual 'User's manual'. If you have only a few minutes to spare
you should at least read section 2.4 (Road-map for running jobs), 2.5
(Submitting a job) and 2.6 (Managing a job).

To check your knowledge you should at least have some sense of when you woud
need the commands ``condor_submit``, ``condor_rm``, ``condor_status``,
``condor_q``, and ``condor_userprio``. And you should now that ``condor_q`` has
an option ``-analyze``!

Condor-related modifications on Medusa
======================================

condor_qsub
-----------

The version of Condor running on Medusa has a few features that are not
described in the Condor manual. The one that shall be mentioned here is
``condor_qsub``. This is command that (somewhat) emulates the ``qsub`` command
of the widely used Sun GridEngine. Run ``man condor_qsub`` in a terminal on
medusa for its documentation.


FSL and Condor
--------------

FSL has also been modified to work with condor. If you want FSL to submit its
jobs to the cluster, you have to set the evironment variable
``FSLPARALLEL=condor``.
