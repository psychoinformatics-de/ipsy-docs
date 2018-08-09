Condor
######
:order: 530

Medusa uses HTCondor (aka: Condor) to schedule computational jobs across the
cluster. While Condor has many features, one only needs to know a few core
commands to begin using it effectively.

Useful Commands
***************
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
*************
The `official Condor documentation`_ is long, but comprehensive. If you have
questions, their docs are a great resource. Pay special attention to sections
2.4, 2.5, and 2.6 of the chapter entitled `Condor User Guide`_.

.. _official Condor documentation: http://research.cs.wisc.edu/htcondor/manual/v8.4/
.. _Condor User Guide: http://research.cs.wisc.edu/htcondor/manual/v8.4/2_Users_Manual.html

The .submit File
****************
A ``.submit`` file describes the jobs (commands and their arguments) that condor
will run, the environment they will run in, and the needed hardware resources
(RAM, CPU). We'll start with a short, functioning example, and then each part
will be explained.

.. code::

  # The environment
  universe       = vanilla
  getenv         = True
  request_cpus   = 1
  request_memory = 4000

  # Execution
  initial_dir    = /home/user_bob/
  executable     = hello_world.sh

  # Job 1
  arguments = "arg1" "arg2"
  log       = /home/user_bob/logs/$(Cluster).$(Process).log
  output    = /home/user_bob/logs/$(Cluster).$(Process).out
  error     = /home/user_bob/logs/$(Cluster).$(Process).err
  Queue

  # Job 2
  arguments = "arg1" "arg2"
  log       = /home/user_bob/logs/$(Cluster).$(Process).log
  output    = /home/user_bob/logs/$(Cluster).$(Process).out
  error     = /home/user_bob/logs/$(Cluster).$(Process).err
  Queue

The first two lines you likely will never need to change. ``universe`` declares
the *type* of condor environment used, and ``getenv`` tells condor to copy
environmental variables from your execution environment to the compute nodes.
Unless you *really* know what you're doing, we recommend keeping these lines
unchanged.

.. code::

  universe = vanilla
  getenv   = True

Declaring resource needs is straightforward; though do note that
``request_memory`` is in MB.

If you are unsure about how much memory to request: make an educated guess,
submit one job, and then check its ``.log`` file, which will contain information
about memory usage while the job was running.

.. code::

  request_cpus   = 1
  request_memory = 4000

``initial_dir`` is the directory that condor will ``cd`` to when starting your
job. If you're using relative paths in your ``.submit`` or in scripts executed
by your job, those paths are relative to this starting directory.

.. code::

  initial_dir = /home/user_bob

Declaring the ``executable`` (the program or script to be run) and the arguments
to be passed to it (such as feature flags, subject data, etc) is also
straightforward.

.. code::

  executable = hello_world.sh
  arguments = "arg1" "arg2"

Condor can generate three different types of logs per job. The **log** file
contains information about the job — such as duration, memory usage, the
node it ran on, etc. Any output that the executable prints will be recorded in
the **output** (stdout) and **error** (stderr) files.

The ``$(Cluster)`` and ``$(Process)`` macros supply the job ID, and are used
here to create unique log files for each job.

.. code::

  log    = /home/user_bob/log/$(Cluster).$(Process).log
  output = /home/user_bob/log/$(Cluster).$(Process).out
  error  = /home/user_bob/log/$(Cluster).$(Process).err

The last line tells condor to schedule a job using the current state of all
attributes thus far defined:

.. code::

  Queue

Then, you can change (or add) any attributes (though usually just ``arguments``,
``log``, ``output``, and ``error``) and then add ``Queue`` again. This way, you
can easily define thousands of similar jobs.

.. class:: todo

  **TODO:** Use a simple system utility as the executable, so that this example
  runs out-of-the-box with no need to write a hello_world.sh.

Generating a .submit File
*************************
Writing ``.submit`` files by hand is painful, error-prone, and does not scale —
and the entire purpose of cluster computing is scale. Thus, normal operation is
to have a script generate your ``.submit`` file for you.

The following example shell script does the following:

* creates a folder for log files
* prints to the screen the contents for a .submit file, including:

  * the condor environment
  * the amount of CPU and RAM needed
  * the script to run (analysis.py)
  * loops over all subject csv files, scheduling one job for each file and
    defining unique log files for each

.. code::

  #!/bin/sh

  main_dir=/home/user_bob/tasty_Py
  log_dir=${main_dir}/logs
  subjects_dir=${main_dir}/inputs

  # check if the subjects directory exists; otherwise exit
  [ ! -d "$input_dir" ] && echo "subject dir '$subjects_dir' not found. Exiting" && exit 1

  # create the logs dir if it doesn't exist
  [ ! -d "$log_dir" ] && mkdir -p "$log_dir"

  # print the .submit header
  printf \
  "universe = vanilla
  getenv = True
  request_cpus = 1                                 # CPU cores needed
  request_memory = 4000                            # memory usage in MB

  initial_dir=${main_dir}
  executable=${main_dir}/code/analysis.py
  \n"

  # create a job for each subject file
  for file in ${subjects_dir}/sub*.csv ; do
      subject=${file##*/}
      printf "arguments = ${file}\n"
      printf "log    = ${log_dir}/\$(Cluster).\$(Process).${subject}.log\n"
      printf "output = ${log_dir}/\$(Cluster).\$(Process).${subject}.out\n"
      printf "error  = ${log_dir}/\$(Cluster).\$(Process).${subject}.err\n"
      printf "Queue\n\n"
  done

First, run the script and make sure that the output looks sane (if it fails with
"permission denied", you probably forgot to mark it as executable by using
``chmod +x``).

.. code::

  ./condor_submit_gen.sh

If everything looks good, then it's time to submit the jobs to condor. The
script's output can be redirected into a file using ``>``

.. code::

  ./condor_submit_gen.sh > the.submit
  condor_submit the.submit

or directly to ``condor_submit`` by using ``|``.

.. code::

  ./condor_submit_gen.sh | condor_submit

Prioritization of Jobs
**********************
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
*****
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
***************
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
***********
If you need more CPU or RAM than is available on the head node, you can use
Condor to gain access to an interactive shell on a node — even with a GUI.

.. code::

  condor_submit -interactive your.submit

FSL
***
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
  # v2.2

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
  printf "universe = vanilla
  getenv = True
  request_cpus = $cpu
  request_memory = $mem
  initialdir = $currentdir
  executable = $feat_cmd\n"

  # create a queue with each fsf file found in the current directory
  for fsf in ${fsfdir}/*.fsf ; do
      c_basename=`basename "$fsf"`
      c_stem=${c_basename%.fsf}

      printf "arguments = ${fsf}\n"
      printf "log    = ${logdir}/\$(Cluster).\$(Process).${c_stem}.log\n"
      printf "output = ${logdir}/\$(Cluster).\$(Process).${c_stem}.out\n"
      printf "error  = ${logdir}/\$(Cluster).\$(Process).${c_stem}.err\n"
      printf "Queue\n"
  done

The script assumes that all ``.fsf`` files for each first level analysis are
stored in a directory called ``fsf/`` located under your current directory.

The script will output everything to the screen, which can be piped right into
``condor_submit``.

.. code::

  ./fsf_submit.sh | condor_submit

Python
******
The following is an example ``.submit`` file to call a Python script.

.. code::

  universe = vanilla
  getenv = True
  environment = PYTHONPATH=/usr/lib/python2.7
  request_cpus = 1
  request_memory = 4000

  initialdir = /home/user_bob/Tasty_Py
  executable = /usr/bin/python

  arguments = /home/user_bob/Tasty_Py/wow.py "arg1" "arg2"
  log    = /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).subj1.log
  output = /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).subj1.out
  error  = /home/user_bob/Tasty_Py/log/$(Cluster).$(Process).subj1.err
  Queue

.. class:: todo

  **TODO:** discuss NiPype

Matlab
******
The following is an example ``.submit`` file to call Matlab

.. code::

  universe = vanilla
  getenv = True
  request_cpus = 1
  request_memory = 8000

  initialdir = /home/user_bob/Wicked_Analysis
  executable = /usr/bin/matlab

  arguments = -singleCompThread -r Gravity(1)
  log    = /home/user_bob/Wicked_Analysis/log/$(Cluster).$(Process).subj1.log
  output = /home/user_bob/Wicked_Analysis/log/$(Cluster).$(Process).subj1.out
  error  = /home/user_bob/Wicked_Analysis/log/$(Cluster).$(Process).subj1.err
  Queue

By default, Matlab will use all available CPUs. The only effective way to
control Matlab is to use the ``-singleCompthread`` option. There is a
`maxNumCompThreads()`_ function, but it is deprecated and is considered
unreliable.

.. class:: note

  **NOTE:** With the increase in the number of available campus toolbox
  licenses, it is no longer necessary to restrict Matlab jobs to specific
  compute nodes.

.. class:: todo

  **TODO:** Discuss Matlab Compiler

.. _maxNumCompThreads(): https://www.mathworks.com/help/matlab/ref/maxnumcompthreads.html

OpenBlas
********
OpenBlas automatically scales up to use all the CPUs on a system. For example,
to limit it two CPUs, set the following environmental variable.

.. code::

  OMP_NUM_THREADS=2

DAGMan
******

.. class:: todo

  **TODO:** discuss DAGMan

Intel vs AMD
************
Our cluster's Intel nodes have the fastest single thread performance. If you
have very few, single CPU jobs and need them to execute as fast as possible,
then restricting your jobs to the nodes with Intel CPUs can be beneficial.

The nodes are configured to advertise their CPU vendor, so it is easy to
constrain according to CPU type. Add the following to your ``.submit`` file.

.. code::

  Requirements = CPUVendor == "INTEL"

Or, to *prefer* Intel CPUs but not *require* them

.. code::

  Rank = CPUVendor == "INTEL"
