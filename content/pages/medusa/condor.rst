Condor
******
:order: 530

Medusa uses HTCondor (aka: Condor) to schedule computational jobs across the
cluster. While Condor is very featureful, one only needs to know a few core
commands to begin using it effectively.

Useful Commands
===============

List all slots (available and used) and their size
  .. code::

    condor_status

Submit a job/job cluster
  .. code::

    condor_submit <file.submit>

Summary of your jobs in the queue
  .. code::

    condor_q

All of your running jobs and which machine they are on
  .. code::

    condor_q -nobatch -run

All jobs from all users in the queue
  .. code::

    condor_q -nobatch -allusers

Explain why a job is in a particular state
  .. code::

    condor_q -better-analyze <jobid>

Remove jobs from the queue
  .. code::

    condor_rm <username>            # remove all jobs for this (your) user
    condor_rm <clusterid>           # remove all jobs belonging to this cluster
    condor_rm <clusterid>.<jobid>   # remove this specific job

User statistics, including priority
  .. code::

    condor_userprio --allusers

For those who are more familiar with Sun's GridEngine, condor provides ``condor_qsub``.
  .. code::

    condor_qsub

Documentation
=============
The `official Condor documentation`_ is long, but comprehensive. If you have
questions, their docs are a great resource. Pay special attention to sections
2.4, 2.5, and 2.6 of the chapter entitled `Condor User Guide`_.

If short-and-sweet is more your style, Matthew Farrellee has written a short
`introduction to submitting jobs to Condor`_.

.. _official Condor documentation: http://research.cs.wisc.edu/htcondor/manual/v8.4/
.. _Condor User Guide: http://research.cs.wisc.edu/htcondor/manual/v8.4/2_Users_Manual.html
.. _introduction to submitting jobs to Condor: https://spinningmatt.wordpress.com/2011/07/04/getting-started-submitting-jobs-to-condor/



Anatomy of a .submit file
=========================

A .submit file specifies all relevant commands and keywords for condor to schedule an
analysis. The "header" contains the basic job setup:

.. code::

    executable 	= code/analysis.py
    universe	= vanilla
    initial_dir = /home/user_bob/Tasty_Py/
    getenv 	= True
    environment = PYTHONPATH=/usr/lib/python3.5

The most important part concerns "executable". It specifies the executable to be run.
This could be a path to a script that has been made executable via ``chmod +x analysis.py``,
or, alternatively, could point to the interpreter that runs the script, such as
``/usr/bin/python`` or ``/usr/bin/matlab``. "universe" specifies a condor execution
environment. Vanilla is what you'll likely want to stick with. "initial_dir" should
be the local base path for all input and output files. Generally, set "getenv" to be
True. When True, Condor will use the current environment variables of the user.
Additional environment variables can be specified via "environment" in the last line.

Some additional resource requests about the CPU cores needed and the expected memory
usage are made with the following specifications:

.. code::

    request_cpus = 1
    request_memory = 4000

If the executable above is a script, any number of arguments for the executable
are specified like this:

.. code::

    arguments = "arg1" "arg2"

If the executable is referring to the interpreter instead, the script that should
be executed has to be given as an argument as well.

.. code::

    arguments = "../code/analysis.py" "arg1" "arg2"

There are three types of files that should be specified in the submit file: Log, Error,
and Output.

.. code::

    log	= /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).log
    error = /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).err
    output = /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).out

These files will provide important information about the processing of the jobs.
Especially when running into errors, these are the files to look in for information
on what went wrong. The log file provides extensive information on what happened to a
job at which time. The error file captures any error messages and the output file
contains any information the program would usually output to the screen. Note the
``$(Cluster)`` and ``$(Process)`` macros in the above example. They supply the
values of the job attributes and are intended to aid in the specification of the
files. The above example will create a log, error and output file for every job
run with the job attributes as a name in a subdirectory ``log/``.

The last line of a .submit file is:

.. code::

    Queue

This tells condor to add the job described above to the job Queue.

Generating a .submit file with a script
=======================================

For many reasons it can be handy to not write a lengthy and repetitive
.submit file from scratch but have a script do all the work.
Consider the average user Bob, who wants to run his script analysis.py not
only on a single data file, but on the data files of all his 60 subjects.
Creating the 60 jobs by hand would take hours. However, a small script could
do this in no time at all.
The following example is a shell script. Its task is simple: Print all information
that a condor .submit file needs.

.. code::

    #!/bin/sh

    [ -d "$log_dir" ] || mkdir -p "$logdir" 		#create log_dir if it doesn't exist


    #create variables to store paths in
    initial_dir=/home/user_bob/Tasty_Py/
    log_dir=/home/user_bob/Tasty_Py/log/

    #create a variable with the name of each .csv data file found in Bobs Tasty_Py/inputs/ directory
    inputfiles=$(find ${initial_dir}/inputs/ -type f -name sub*.csv -printf "%f ")

    #this prints the header
    printf "executable=code/analysis.py			# path to executable script
    universe = vanilla
    initial_dir=${initial_dir}				# local base path
    getenv = True					# use local environment variables
    environment = PYTHONPATH=/usr/lib/python3.5
    request_cpus = 1					# CPU cores needed
    request_memory = 4000\n"				# expected memory usage; notice the line break!

    #loop over the variable inputfiles to create a queue with a job for each data file
    for file in ${inputfiles}; do
        printf "arguments = $file\n"			# notice the line breaks!
        printf "log = ${log_dir}/\$(Cluster).\$(Process).${file}.log\n"
        printf "error = ${log_dir}/\$(Cluster).\$(Process).${file}.err\n"
        printf "output = ${log_dir}/\$(Cluster).\$(Process).${file}.out\n"
        printf "Queue\n"
    done

It is good practice to run the script and check whether its output looks as intended.

.. code::

    chmod +x condor_submit_gen.sh
    ./condor_submit_gen.sh

Afterwards, the output of the shell script can be written into a new file to create a .submit
file, or, even easier, piped into ``condor_submit`` to schedule all of Bobs analyses.

.. code::

    ./condor_submit_gen.sh | condor_submit


Prioritization of Jobs
======================
Condor on Medusa is configured to assess user priority when jobs are starting.
The more compute resources consumed by the user, the more their priority is
punished (increased). This "punishment" decays back to normal over the course of
a day or two.

In practice, it works like this:

* Julie submits 10,000 jobs, each ~1 hour long
* A day later, Jimbo submits 10 jobs
* Jimbo's jobs wait in the queue
* As some of Julie's jobs finish, resources are freed up
* Both Julie's and Jimbo's jobs compete for the free resources. Jimbo's win
  because his priority is low (good) and hers is very high (bad).

There is also the ``Priority Factor``. Users who are *not* members of IPSY
have a modifier that punishes them even more. This way, in most cases, the jobs
of IPSY members will be preferred over those of non-IPSY users.

Slots
=====
Medusa is configured to allow a diversity of different job sizes, while
protecting against large jobs swamping the entire cluster — and also encouraging
users to break their analysis into smaller steps.

The slots on Medusa are:

.. code::

  16x    1 cpu,   4 GiB   ( 4.0 GiB/cpu)
  16x    1 cpu,   6 GiB   ( 6.0 GiB/cpu)
  12x    1 cpu,   5 GiB   ( 5.0 GiB/cpu)
   6x   10 cpu,  85 GiB   ( 8.5 GiB/cpu)
   2x   16 cpu, 255 GiB   (15.9 GiB/cpu)
   1x   48 cpu, 190 GiB   ( 3.9 GiB/cpu)
   1x   20 cpu,  95 GiB   ( 4.7 GiB/cpu)
   1x   16 cpu, 415 GiB   (25.9 GiB/cpu)
   1x    8 cpu,  62 GiB   ( 7.7 GiB/cpu)
   1x    4 cpu,  18 GiB   ( 4.5 GiB/cpu)

All slots larger than 1 CPU are partitionable — and thus can be broken into many
smaller slots. To illustrate: there are only 44x 1 CPU slots.  But if 500x [1
CPU × 4 GiB] jobs are submitted, all of the larger slots are broken up into
matching [1 CPU × 4 GiB] slots — resulting in a total of 231 jobs.

The reader may have noticed that there are 232 CPUs, and yet only 231 jobs would
be scheduled. This is because the [48 CPU × 190 GiB] slot (which has a RAM/CPU
ratio < 4 GiB) cannot provide 4 GiB to each CPU; thus, one CPU is left idle.

The loss of 1 CPU for [1 CPU × 4 GiB] jobs is negligible. However, as an
exercise, the reader is encouraged to determine how much of the cluster would
be left idle when submitting [1 CPU × 5 GiB] jobs — and also [2 CPU × 20 GiB].

The "Ideal" Job
===============
The "ideal" job is [1 CPU × 4 GiB] and runs for 10-60 minutes. Of course, not
every analysis/step can be broken down into sub-jobs that match this ideal. But
experience has shown that, with a little effort, the majority of analysis at
IPSY can.

The previous section (about slot sizes) neatly demonstrates why smaller jobs are
good: simply, they are more granular and thus better fit (Tetris style) into the
available compute resources.

The second characteristic, duration, directly affects the turnover of jobs and
how frequently compute resources become available. If 10,000x 1 hour jobs are
submitted, after awhile, a job will be finishing every minute or so (due to
normal variations across the cluster).

Maintaining liquidity (aka job turnover) is critical for user priority to remain
relevant (as discussed in the section Prioritization of Jobs) and ensure the
fair-distribution-of *and* timely-access-to compute resources — rather than
merely rewarding those who submit jobs first.

1,000 jobs lasting 1 hour each is *far* better than 100 jobs lasting 10 hours
each.

Interactive
===========
If you need more CPU or RAM than is available on the head node, you can use
Condor to gain access to an interactive shell on a node — even with a GUI.

.. code::

  condor_submit -interactive your.submit

FSL
===
FSL has been modified to directly support Condor — without the need for a
submit file. When running FSL on the head node, you can set the following
environmental variable to submit FSL computation directly to condor.

.. code::

  FSLPARALLEL=condor

.. class:: todo

  **TODO:** Once compute nodes can submit jobs, this needs to be better
  explained and carefully reworded.

However, ``feat`` does not parallelize the first level analysis. Thus, it is
better to create a ``.submit`` file (or a script which generates one) to queue
each ``feat`` call.

The following shell script is a good starting point to generate such a
``.submit`` file.

.. code::

    #!/bin/sh
    # v2.1

    . /etc/fsl/fsl.sh            # setup FSL environment
    unset FSLPARALLEL            # disable built-in FSL parallelization

    mem=4000                     # expected memory usage
    cpu=1                        # CPU cores needed

    currentdir=$(pwd)            # path to current working directory
    logdir="${currentdir}/log/"  # log path
    fsfdir="${currentdir}/fsf/"  # path to fsf files

    feat_cmd=$(which feat)       # path to the feat command

    [ ! -d "$logdir" ] && mkdir -p "$logdir" # create log dir if it does not exist

    # print header
    printf "Executable = $feat_cmd
    Universe = vanilla
    initialdir = $currentdir
    request_cpus = $cpu
    request_memory = $mem
    getenv = True\n"

    # create a queue with each fsf file found in the current directory
    for fsf in ${fsfdir}/*.fsf ; do
        c_basename=`basename "$fsf"`
        c_stem=${c_basename%.fsf}

        printf "arguments = ${fsf}\n"
        printf "log    = ${logdir}/\$(Cluster).\$(Process).${c_stem}.log\n"
        printf "error  = ${logdir}/\$(Cluster).\$(Process).${c_stem}.err\n"
        printf "output = ${logdir}/\$(Cluster).\$(Process).${c_stem}.out\n"
        printf "Queue\n"
    done

The script assumes that all ``.fsf`` files for each first level analysis are
stored in a directory called ``fsf/`` located under your current directory.

The script will output everything to the screen. This can either be redirected
into a file using ``>``

.. code::

  ./fsf_submit.sh > the.submit
  condor_submit the.submit

or directly to condor_submit using ``|``.

.. code::

  ./fsf_submit.sh | condor_submit

Python
======
The following is an example ``.submit`` file to call a Python script.

.. code::

    Executable = /usr/bin/python
    Universe = vanilla
    initialdir = /home/user_bob/Tasty_Py
    request_cpus = 1
    request_memory = 4000
    getenv = True
    environment = PYTHONPATH=/usr/lib/python2.7

    arguments = /home/user_bob/Tasty_Py/wow.py "arg1" "arg2"
    log    = /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).subj1.log
    error  = /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).subj1.err
    output = /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).subj1.out
    Queue

.. class:: todo

  **TODO:** discuss NiPype

Matlab
======
The following is an example ``.submit`` file to call Matlab

.. code::

  Executable = /usr/bin/matlab
  Universe = vanilla
  initialdir = /home/user_bob/Wicked_Analysis
  request_cpus = 1
  request_memory = 24000
  getenv = True

  arguments = -singleCompThread -r Gravity(1)
  log    = /home/user_bob/Wicked_Analysis/log/$(Cluster).$(Process).subj1.log
  error  = /home/user_bob/Wicked_Analysis/log/$(Cluster).$(Process).subj1.err
  output = /home/user_bob/Wicked_Analysis/log/$(Cluster).$(Process).subj1.out
  Queue

Matlab licensing is per user per machine (10 jobs from 1 user on 10 machines =
10 licenses; 10 jobs from 1 user on 1 machine = 1 license; 10 jobs from 10 users
on 1 machine = 10 licenses). Also note that there are far fewer licenses
available for a given toolbox than for Matlab.

You can check the current license usage by running:

.. code::

    lmutil lmstat -a -c 1984@liclux.urz.uni-magdeburg.de

To accommodate this, restrict your jobs to one or two nodes. If you have a lot
of jobs, it makes sense to choose nodes which have the most CPUs (such as snake7
[64] and snake10 [32]). Or if you have fewer jobs, target the fastest nodes
(snake11).

.. code::

    requirements = Machine == "snake7.local" || Machine == "snake10.local"

By default, Matlab will use all available CPUs. The only effective way to
control Matlab is to use the ``singleCompthread`` option. There is a
`maxNumCompThreads()`_ function, but it is deprecated and is considered
unreliable.

.. _maxNumCompThreads(): https://www.mathworks.com/help/matlab/ref/maxnumcompthreads.html

.. class:: todo

  **TODO:** Discuss Matlab Compiler

OpenBlas
========
OpenBlas automatically scales wide to use all CPUs. For example, to limit it two
CPUs, set the following environmental variable.

.. code::

    OMP_NUM_THREADS=2

DAGMan
======

.. class:: todo

  **TODO:** discuss DAGMan

Intel vs AMD
============
In our cluster, the Intel nodes have the fastest single thread performance. If
you have very few, single CPU jobs and need them to execute as fast as possible,
then restricting your jobs to the nodes with Intel CPUs can be beneficial.

The nodes are configured to advertise their CPU vendor, so it is easy to
constrain according to CPU type. Add the following to your ``.submit`` file.

.. code::

    Requirements = CPUVendor == "INTEL"

Or, to *prefer* Intel CPUs but not *require* them

.. code::

    Rank = CPUVendor == "INTEL"
