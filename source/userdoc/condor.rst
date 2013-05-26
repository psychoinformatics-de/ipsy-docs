.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

.. _condordoc:

**************************************
Condor: Submit and manage cluster jobs
**************************************
Medusa uses Condor_ to manage cluster jobs. Condor_ is a very powerful and
flexible tool that is well documented. In addition to the installed
manpages, the complete manual for recent Condor releases is available `online
<http://research.cs.wisc.edu/condor/manual/>`_.

.. _Condor: http://research.cs.wisc.edu/condor/

While Condor can do many things, most users only need to know a few features
to use it efficiently. Everyone is strongly encouraged to read chapter
2 of the Condor manual 'User's manual.' Pay special attention to sections 
2.4 (Roadmap for Running Jobs), 2.5 (Submitting a Job), and 2.6 (Managing a Job).

Matthew Farrellee has written a nice and short `introduction to submitting jobs to Condor`
that is well worth reading.

By the end, you should have a firm understanding of when to use the commands
``condor_submit``, ``condor_rm``, ``condor_status``, ``condor_q``, and
``condor_userprio``. 

.. _introduction to submitting jobs to Condor: http://spinningmatt.wordpress.com/2011/07/04/getting-started-submitting-jobs-to-condor/

.. todo:: prioritization of jobs; current situation?

.. todo:: checkpointing; is it working?

Prioritization of Jobs
======================
When the cluster is at full capacity and there are jobs in the queue, Condor
will evaluate whether any queued job's priority exceeds that of one any of the
jobs that are currently running. If this is the case, Condor will politely ask
the running quit within an hour; if it takes longer, then the job will be
forcefully quit by Condor. When resources become available again, Condor will
restart the job.

Checkpointing
=============
Just like your laptop can hibernate and come back up with running programs, Condor
can do the same with your jobs using a feature called checkpointing. This is
especially useful if you have a long-running job that cannot be restarted without
the loss of all progress. Condor can even migrate these checkpoints across nodes,
in case your job has the oppourtunity to resume processing on a different machine.

For information on how to use checkpointing with your jobs, take a look into
``/usr/share/doc/condor/README.Debian`` on Medusa.

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

.. code-block:: bash

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


Condor Tips
===========

Wondering why a job is in a particular status?

  Try ``condor_q -analyze <jobid>``

Need to alter job attributes after submission?

  Try ``condor_qedit``
