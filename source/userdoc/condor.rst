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

Interactive
===========
Condor has an interactive mode where you can use a shell directly on a
computational node. This is particularly helpful when you need a lot of RAM or
CPU power, but don't have all the steps scripted out yet.::

    condor_submit -interactive your.submit

A submit file is options, but recommended, so you can specify CPU/RAM needs,
etc.

Condor-related Modifications on Medusa
======================================

condor_qsub
-----------
The version of Condor running on Medusa has a few features that are not
described in the Condor manual. One of particular note is ``condor_qsub``. This
command (somewhat) emulates the ``qsub`` command of the widely used Sun
GridEngine. Run ``man condor_qsub`` in a terminal on Medusa for its
documentation.

FSL and Condor
--------------
FSL has been modified to directly support Condor -- without the need for a
submit file. If you want FSL to submit its jobs to the cluster, set the
environment variable:

  ``FSLPARALLEL=condor``

Note: ``feat`` does not use parallel processing for the first level analysis.
Thus, to use ``feat`` effectively in Condor, it is best to create a Condor
submit file that queues each ``feat`` call. The bash script below *creates and
submits* such a file. The script requires that all ``.fsf`` files for each first
level analysis are prepared and stored in one directory and that this script is
executed in that same directory (``currentdir``). This script is available as
executable function ``fsf_submit`` in Wolf Zinke's collection of handy bash
tools for fMRI analysis (*MyFIA toolbox*) `on github`_.

.. _on github: https://github.com/wzinke/myfia.git

.. code-block:: bash

    #!/bin/bash

    unset FSLPARALLEL            # disable built-in FSL parallelization

    submitfile=allfsf.submit     # submit file for condor
    memusage=4000                # expected memory usage
    cpuusage=1                   # CPU cores needed

    currentdir=$(pwd)            # path to current working directory
    logdir="${currentdir}/log/"  # log path
    fsfdir="${currentdir}/fsf/"  # path to fsf files

    [ ! -d "$logdir" ] && mkdir -p "$logdir" # create log dir if it does not exist

    # create header for the condor submit file
    printf "Executable = ${FSLDIR}/bin/feat
    Universe = vanilla
    initialdir = $currentdir
    request_cpus = $cpuusage
    request_memory = $memusage
    getenv = True
    " > $submitfile

    # create a queue with each fsf file found in the current directory
    for fsf in $fsfdir/*.fsf ; do
        c_basename=`basename "$fsf"`
        c_stem=${c_basename%.fsf}

        printf "arguments = ${fsf}\n" >> $submitfile
        printf "error  = ${logdir}/${c_stem}.e\$(Process)\n" >> $submitfile
        printf "output = ${logdir}/${c_stem}.o\$(Process)\n" >> $submitfile
        printf "Queue\n" >> $submitfile
    done

    condor_submit "$submitfile" # submit and run the analyses

Condor and Python
-----------------
While there is no direct interface from python to condor, you can use the
following bash script to send your python script to condor. This might be handy
split your python script into multiple parallel processes but have a united
preprocessing step beforehand. This script doesn't give any output about
progress back to python.

The bash script is an enhanced version of the above bash script from Wolf Zinke
from his *MyFIA toolbox*.

in Python:

.. code-block:: python

    import os
    logdir  = '/path/to/save/your/logfiles'
    script  = '/path/to/your/script.py'
    inputs  = 'inputs to your "python script.py"'
    cmd='bash /path/to/py2condor.sh ' + logdir + ' ' + ' ' + script + ' ' + inputs
    os.system(cmd)


in bash:

.. code-block:: bash

    #!/bin/bash

    ### read input ###
    logdir=$1             # "/path/to/save/your/logfiles"
    script=$2             # "/path/to/your/script.py"
    inputs=$3             # "input1 input2 'input4.1 input4.2'"

    printf "logdir: %s\n" "$logdir"
    printf "script: %s\n" "$script"
    printf "inputs: %s\n" "$inputs"

    ### general parameters ###
    unset FSLPARALLEL               # disable built-in FSL parallelization
    submitfile=pyAll2condor.submit  # submit file for condor
    memusg=30000                    # expected memory usage for a single analysis
    cpuusage=2
    env="PYTHONPATH=/home/my/pythonpath/"
    initdir="/from/there/start/the/script"

    # create log dir if it does not exist
    [ ! -d "$logdir" ] && mkdir -p "$logdir"

    ## create header for the condor submit file ###
    printf "Executable = /usr/bin/python
    Universe = vanilla
    initialdir = $initdir
    request_cpus = $cpuusage
    request_memory = $memusg
    getenv = True
    kill_sig = 2
    when_to_transfer_output = ON_EXIT_OR_EVICT
    environment = $env
    " > $submitfile
    scriptpath="-- $script"

    input=$inputs
    printf "Arguments = $scriptpath $input" >> $submitfile
    printf "error  = $logdir/\$(PROCESS).\$(CLUSTER).err" >> $submitfile
    printf "output = $logdir/\$(PROCESS).\$(CLUSTER).out" >> $submitfile
    printf "log = $logdir/\$(PROCESS).\$(CLUSTER).log" >> $submitfile
    printf "queue" >> $submitfile

    condor_submit "$submitfile" # submit and run the analyses


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

Many users will depend upon non-free toolboxes, and OvGU does not have nearly
as many toolbox licenses as it does Matlab licenses. Licenses are per user per
machine (10 jobs from the same user on 10 different machines will use 10
licenses. But 10 jobs from the same user on 1 machine will use 1 license).

You can check the current license usage by running::

    lmutil lmstat -a -c 1984@liclux.urz.uni-magdeburg.de

An easy way to accommodate this is to restrict your jobs to one or two nodes.
Logically, it makes sense to choose nodes which have the most CPUs. snake7 has
64 CPUs and snake10 has 32. To restrict your job to these nodes, add the
following to your submit file::

    requirements = Machine == "snake7.local" || Machine == "snake10.local"

Another common issue is Matlab's multithreading. By default, Matlab will use all
available CPUs. Even though the condor submit file has a section for *requested
CPUs*, it doesn't actually enforce that limit. Matlab's default behavior makes
it a very uncooperative cluster citizen.

To limit Matlab to a certain number of threads (and you should), use the
`maxNumCompThreads()`_ function. For example, to limit your script to use only 4
cores, add the following to the beginning of your Matlab script::

    maxNumCompThreads(4)

.. _maxNumCompThreads(): https://www.mathworks.com/help/matlab/ref/maxnumcompthreads.html

For various reasons, Matlab performs significantly (up to 50%) faster on our
nodes with Intel CPUs than AMD CPUs. Our nodes are configured to advertise their
CPU vendor. If speed is your concern, and you aren't limited by licensing, then
limiting to nodes with Intel CPUs can be beneficial. To do so, add the
following to your condor submit file::

    Requirements = CPUVendor == "Intel"

Or, if you merely want to *prefer* Intel CPUs but not *require* them::

    Rank = CPUVendor == "Intel"

Condor and OpenBlas
-------------------
OpenBlas automatically scales wide to use all CPUs. For example, to limit it two
CPUs, set the following environmental variable::

    OMP_NUM_THREADS=2

Condor Tips
===========

Get a list of all jobs currently in the queue::

    condor_q

Determine why a job is in a particular status::

    condor_q -analyze <jobid>

Alter job attributes after submission::

    condor_qedit

Remove jobs from the queue::

    condor_rm user    <username>   # removes all jobs for this user
    condor_rm cluster <clusterid>  # removes all jobs belonging to this cluster
    condor_rm         <jobid>      # removes this specific job

Get information about user statistics, including priority::

    condor_userprio --allusers
