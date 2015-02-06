.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

.. _condordoc:

**************************************
Condor: Submit and manage cluster jobs
**************************************
Medusa uses Condor_ to manage cluster jobs. Condor_ is a very powerful and
flexible tool that is well documented. In addition to the installed
manpages, the `complete manual`_ for recent Condor releases is available online.

.. _complete manual: http://research.cs.wisc.edu/condor/manual/
.. _Condor: http://research.cs.wisc.edu/condor/

While Condor can do many things, most users only need to know a few features
to use it efficiently. Everyone is strongly encouraged to read chapter
2 of the Condor manual 'User's manual.' Pay special attention to sections
2.4 (Roadmap for Running Jobs), 2.5 (Submitting a Job), and 2.6 (Managing a Job).

Matthew Farrellee has written a nice and short `introduction to submitting jobs to Condor`_
that is well worth reading. And there are some useful `tutorial videos`_ from
the Condor folks themselves.

By the end, you should have a firm understanding of when to use the commands
``condor_submit``, ``condor_rm``, ``condor_status``, ``condor_q``, and
``condor_userprio``.

.. _introduction to submitting jobs to Condor: http://spinningmatt.wordpress.com/2011/07/04/getting-started-submitting-jobs-to-condor/
.. _tutorial videos: http://research.cs.wisc.edu/htcondor/tutorials/videos/2014/

Prioritization of Jobs
======================
When the cluster is at full capacity and there are jobs in the queue, Condor
will evaluate whether any queued job's priority exceeds that of any of the
jobs that are currently running. If this is the case, Condor will politely ask
the running job to quit. When resources become available again, Condor will
restart the job.

Checkpointing
=============
Just like your laptop can hibernate and resume/wake with running programs, Condor
can do the same with your jobs using a feature called checkpointing. This is
especially useful if you have a long-running job that cannot be restarted without
the loss of all progress. Condor can even migrate these checkpoints across nodes,
in case your job has the opportunity to resume processing on a different machine.

For information on how to use checkpointing with your jobs, take a look at
``/usr/share/doc/condor/README.Debian`` on Medusa.

Condor-related Modifications on Medusa
======================================

condor_qsub
-----------
The version of Condor running on Medusa has a few features that are not described in
the Condor manual. One of particular note is ``condor_qsub``. This command (somewhat)
emulates the ``qsub`` command of the widely used Sun GridEngine. Run ``man condor_qsub``
in a terminal on Medusa for its documentation.

FSL and Condor
--------------
FSL has been modified to directly support Condor -- without the need for a submit
file. If you want FSL to submit its jobs to the cluster, set the environment variable:

  ``FSLPARALLEL=condor``

Note: ``feat`` does not use parallel processing for the first level analysis. Thus, to
use ``feat`` effectively in Condor, it is best to create a Condor submit file that
queues each ``feat`` call. The bash script below *creates and submits* such a file. The
script requires that all ``fsf`` files for each first level analysis are prepared and
stored in one directory and that this script is executed in that same directory (``cdir``).
This script is available as executable function ``fsf_submit`` in Wolf Zinke's collection
of handy bash tools for fMRI analysis (*MyFIA toolbox*) `on github`_.

.. _on github: https://github.com/wzinke/myfia.git

.. code-block:: bash

    #!/bin/bash

    unset FSLPARALLEL  # parallelization is not possible for submitted jobs

    onm=allfsf.submit  # submit file for condor
    memusg=4000        # expected memory usage for a single analysis

    cdir=$(pwd)        # get the path to current working directory
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
        echo "error  = $cdir/log/$cstem.e\$(Process)" >> $onm
        echo "output = $cdir/log/$cstem.o\$(Process)" >> $onm
        echo "Queue" >> $onm
    done

    condor_submit $onm # this will submit and run the analyses

Condor and Python
-----------------
As long there is no direct interface from python to condor you can use the following 
bash script to send your python script to condor. This might be handy split your 
python script into multiple parallel processes but have a unite preprocessing
beforehand.
This script doesn't give any output about progress back to python.

The bash script is an enhanced version of the above bash script from Wolf Zinke 
from his *MyFIA toolbox*.

in Python:

.. code-block:: python

    import os
    logdir  = '/path/to/save/your/logfiles'
    script  = '/path/to/your/script.py'
    inputs  = 'inputs to your "python script.py"'
    cmd='bash /path/to/py2condor.sh '+logdir+' '+' '+script+' '+inputs
    os.system(cmd)


in bash:

.. code-block:: bash

    #!/bin/bash

    ### read input ###
    #
    logdir=$1             # "/path/to/save/your/logfiles"
    script=$2             # "/path/to/your/script.py"
    inputs=$3             # "input1 input2 'input4.1 input4.2'"

    echo "logdir: "$logdir
    echo "script: "$script
    echo "inputs: "$inputs

    #______________________________________________________________________#
    ### general parameters ###
    #unset FSLPARALLEL  # parallelization is not possible for submitted jobs
    onm=pyAll2condor.submit  # submit file for condor
    memusg=30000       # expected memory usage for a single analysis
    req_cpus=2
    env="PYTHONPATH=/home/my/pythonpath/"
    initdir="/from/there/start/the/script"

    # create directory for condor log files if not existing
    mkdir -p $logdir

    #______________________________________________________________________#
    ## create header for the condor submit file ###
    echo "Executable = /usr/bin/python
    Universe = vanilla
    initialdir = $initdir
    request_cpus = $req_cpus
    request_memory = $memusg
    getenv = True
    should_transfer_files = YES
    kill_sig = 2
    when_to_transfer_output = ON_EXIT_OR_EVICT
    environment = $env
    " > $onm
    scriptpath="-- $script"

    input=$inputs
    echo "Arguments = $scriptpath $input" >> $onm
    echo "error  = $logdir/\$(PROCESS).\$(CLUSTER).err" >> $onm
    echo "output = $logdir/\$(PROCESS).\$(CLUSTER).out" >> $onm
    echo "log = $logdir/\$(PROCESS).\$(CLUSTER).log" >> $onm
    echo "queue" >> $onm

    condor_submit $onm # this will submit and run the analyses


Condor and Matlab
-----------------
The following is an example .submit file to call Matlab::

    Executable = /usr/bin/matlab
    Universe = vanilla
    initialdir = /home/user_bob/Wicked_Analysis
    request_cpus = 4
    request_memory = 24000
    getenv = True

    arguments = -r Gravity(1)
    error  = /home/user_bob/Wicked_Analysis/log/subj1.error$(Process)
    output = /home/user_bob/Wicked_Analysis/log/subj1.out$(Process)
    Queue
    arguments = -r Gravoty(2)
    error  = /home/user_bob/Wicked_Analysis/log/subj2.error$(Process)
    output = /home/user_bob/Wicked_Analysis/log/subj2.out$(Process)
    Queue

Many users will depend upon non-free toolboxes. OvGU does not have nearly as
many toolbox licenses as it does Matlab licenses. Licenses are per user per
machine. Since condor can run your jobs on many different machines, this can be
problematic when there are few toolbox licenses available (aka: situation normal).

An easy way to accommodate this is to restrict your jobs to one or two nodes.
Logically, it makes sense to choose nodes which have the most CPUs. snake7 has
64 CPUs and snake10 has 32. To restrict your job to these nodes, add the
following to your submit file::

    requirements = Machine == "snake7.local"  || Machine == "snake10.local"

Another common issue is Matlab's multithreading. By default, Matlab will use all
available CPUs. Even though the condor submit file has a section for *requested
CPUs*, it doesn't actually enforce that limit. Matlab's default behavior makes
it a very unkind cluster citizen.

To limit Matlab to a certain number of threads (and you should), use the
`maxNumCompThreads()`_ function. For example, to limit your script to use only 4
cores, add the following to the beginning of your Matlab script::

    maxNumCompThreads(4)

.. _maxNumCompThreads(): https://www.mathworks.com/help/matlab/ref/maxnumcompthreads.html


Condor Tips
===========

Get a list of all jobs currently in the queue::

    condor_q

Determine why a job is in a particular status::

    condor_q -analyze <jobid>

Alter job attributes after submission::

    condor_qedit

Remove jobs from the queue::

    condor_rm user    <username>   # removes all jobs from this user
    condor_rm cluster <clusterid>  # removes all jobs belonging to
    condor_rm         <jobid>      # removes this specific job

Get information about user statistics, including priority::

    condor_userprio --allusers
