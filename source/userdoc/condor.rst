.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

.. _condordoc:

**************************************
Condor: Submit and manage cluster jobs
**************************************

Medusa uses Condor_ to manage cluster jobs. Condor_ is a very powerful and
flexible tool that is also very well documented. In addition to the installed
manpages, the complete manual for recent Condor releases is available `online
<http://research.cs.wisc.edu/condor/manual/>`_.

.. _Condor: http://research.cs.wisc.edu/condor/

While Condor can do many things, most users only need to know about a few
pieces to use it efficiently. Everyone is strongly encouraged to read chapter
2 of the Condor manual 'User's manual'. If you have only a few minutes to spare,
you should at least read sections 2.4 (Roadmap for running jobs), 2.5
(Submitting a job) and 2.6 (Managing a job).

To check your knowledge, you should have an understanding of when you will
need the commands ``condor_submit``, ``condor_rm``, ``condor_status``,
``condor_q``, and ``condor_userprio``. And you should now that ``condor_q`` has
an option ``-analyze``!

A nice and short `introduction to submitting jobs to Condor` can be found on
`Matthew Farrellee's blog`_.

.. _introduction to submitting jobs to Condor: http://spinningmatt.wordpress.com/2011/07/04/getting-started-submitting-jobs-to-condor/
.. _Matthew Farrellee's blog: http://spinningmatt.wordpress.com/

Beware of *looong* running jobs!
==============================

When the cluster is busy and there are still jobs in the queue, Condor will
evaluate whether the user priorities of incoming jobs exceed the ones of
currently running jobs. If this is the case, Condor will politely ask a job to
stop consuming resources and get off the compute node. It will generously
offer each job some time to finish its business (at the time of this writing,
this is an hour), but will kill the job cold-blooded if the job exhausts that generosity.
Whenever resources become available again, Condor will restart the job.

If you have jobs that need to run for a long time, and cannot be restarted
without losing all the progress made so far, you need to add a safety net to
your Condor job submission. Medusa's Condor supports the checkpoint and restart of
job via DMTCP_. If this is enable for a particular job, Condor will "vacate"
the job when it needs to leave a compute node -- it will write all data to disk
and keep the job in the queue until it can be restarted again (resources are
available again, and user priority is high enough). Upon restart, the job
continues exactly where it was asked to stop. Using the facility, Condor can
also move jobs between machines, in case a better machine becomes available
in the meantime.

For information on how to use DMTCP-based checkpointing with your job take a
look into ``/usr/share/doc/condor/README.Debian`` on Medusa.

.. _dmtcp: http://dmtcp.sourceforge.net/


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

Feat does not use parallel processing for the first level analysis. Thus, it is
more effective to run the feat analyses themfelf parallel on condor. This is best
done by creating a condor submit file that queues each feat call. Below is an example
bash script that creates such a file and submits it to condor. It requires, that all
fsf files for each first level analysis are prepared and stored in one directory.
From within this directory, the following script can be called.

.. code-block:: sh
    #!/bin/bash

    unset FSLPARALLEL  # no other parallelization wanted

    onm=allfsf.submit  # submit file for condor
    memusg=4000        # expected memory usage for a single analysis

    cdir=`pwd`         # get the path to current working directory
    fsflst=`ls -1 $fsfdir/*.fsf`

    if [ ! -d $cdir/log ] # create directory for condor log files
    then
        mkdir $cdir/log
    fi

    # create header for the condor submit file
    echo "Executable = $FSLDIR/bin/feat
    Universe = vanilla
    initialdir = $cdir
    request_cpus = 1
    request_memory = $memusg
    getenv = True
    " > $onm

    # create a queue with each fsf file found in the current directory
    for cfsf in $fsflst
    do
        cstem=`basename "$cfsf" | sed -e 's/.fsf//g'`

        echo "arguments = $cfsf" >> $onm
        echo "error  = $idir/log/$cstem.e\$(Process)" >> $onm
        echo "output = $idir/log/$cstem.o\$(Process)" >> $onm
        echo "Queue" >> $onm
    done

    condor_submit $onm


Condor hints
============

Wondering why a job is in a particular status?

  Try ``condor_q -analyze <jobid>``

Need to alter job attributes after submission?

  Try ``condor_qedit``
