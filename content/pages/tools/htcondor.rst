HTCondor
########
:order: 545

HTCondor (also known as condor) is a job scheduler. It is powerful, but
conceptually quite simple. Condor:

* runs the jobs you tell it to
* finds places to run those jobs
* makes sure everyone has fair access to resources

There are two aspects when teaching people how to use Condor:

1) Using Condor itself (useful commands, the ``.submit`` file). This is
   **relatively easy**, and is what this document focuses on.
2) Understanding the problems your scripts are trying to solve, and how to
   break those up into conceptually discrete steps and units. Put another way:
   how to not use the cluster like one big laptop and instead like thousands
   of tiny desktops. For many people, this is the **not so easy** part.

A Simple Sample
***************
Let's keep things simple. You want to run the command ``fortune`` using condor.
Just one job. Here's how we do so:

1) create a file called ``fortune.submit`` defining your job:

   .. code::

     # The environment
     universe       = vanilla
     getenv         = True
     request_cpus   = 1
     request_memory = 1G

     # Execution
     initial_dir    = $ENV(HOME)
     executable     = /usr/games/fortune

     # Job
     log            = $ENV(HOME)/logs/fortune_$(Cluster).$(Process).log
     output         = $ENV(HOME)/logs/fortune_$(Cluster).$(Process).out
     error          = $ENV(HOME)/logs/fortune_$(Cluster).$(Process).err
     Queue

2) create a folder for the logs:

   .. code::

     mkdir ~/logs

3) submit the job to condor

   .. code::

     condor_submit fortune.submit

4) watch the queue (the job will move from IDLE, to RUN, and then then will
   disappear, meaning it has finished).

   .. code::

     condor_q

5) read the output file containing your fortune

   .. code::

     cat ~/logs/fortune_*.out


Anatomy of .submit
******************
To accomplish more than the simple example above, you'll need to understand the
anatomy of a submit file.

A ``.submit`` file describes the jobs (commands and their arguments) that condor
will run, the environment they will run in, and the needed hardware resources
(RAM, CPU).

This example defines two jobs, and this time with an argument. One job outputs
the calendar for 1985 and the second job for 1986.

.. code::

  # The environment
  universe       = vanilla
  getenv         = True
  request_cpus   = 1
  request_memory = 1G

  # Execution
  initial_dir    = $ENV(HOME)
  executable     = /usr/bin/ncal

  # Logs
  log            = $ENV(HOME)/logs/$(Cluster).$(Process).log
  output         = $ENV(HOME)/logs/$(Cluster).$(Process).out
  error          = $ENV(HOME)/logs/$(Cluster).$(Process).err

  # Job 1
  arguments = "1985"
  Queue

  # Job 2
  arguments = "1986"
  Queue

Breaking this into sections:

*
   .. code::

     universe = vanilla
     getenv   = True

   The first two lines you likely will never need to change. ``universe``
   declares the *type* of Condor environment used, and ``getenv`` tells Condor
   to copy environmental variables from your execution environment to the
   compute nodes.  Unless you know what you're doing, keep these lines
   unchanged.

*
   .. code::

     request_cpus   = 1
     request_memory = 1G

   Often people don't know how much RAM their job will consume. In that case,
   make an educated guess, and then submit a single job. When it completes,
   check its ``.log`` file.  It contains information about the memory usage of
   the job.

*
   .. code::

     initial_dir = $ENV(HOME)

   This is the directory that Condor will ``cd`` to when starting your job. All
   paths are relative to this starting directory (unless they are absolute
   paths, i.e. starting with a ``/``). In this case, it is your user's home
   folder.

*
   .. code::

     executable = /usr/bin/ncal

   Next comes the ``executable``. It is common for users to simply enter the
   command name. This is often wrong. Re-read the description above for
   ``initial_dir``, and you will see that if ``executable`` is set to ``ncal``,
   it would try to run ``/$HOME/ncal``. This *is* usually what you want when
   you're executing a script you've written, but it's not what you want when
   executing a system utility. In that case, use an absolute path.

*
   .. code::

     # Logs
     log       = $ENV(HOME)/logs/$(Cluster).$(Process).log
     output    = $ENV(HOME)/logs/$(Cluster).$(Process).out
     error     = $ENV(HOME)/logs/$(Cluster).$(Process).err

   The log files store information about the job. The ``$(Cluster)`` and
   ``$(Process)`` macros supply the job ID, and are used here to create unique
   log files for each job.

   * ``log``: for information about the condor job (duration, memory usage, the
     machine it ran on, etc)
   * ``output``: anything the job writes to stdout
   * ``error``: anything the job writes to stderr

*
   .. code::

     # Job 1
     arguments = "1985"
     Queue

   The ``arguments`` are what is passed to the ``executable``.

   Then comes ``Queue``. This means "submit a job". The state of all variables
   up to this point will be submitted as a job. We will soon see, with the
   second job, how this is powerful.
*
   .. code::

     # Job 2
     arguments = "1986"
     Queue

   The ``arguments`` variable is overwritten, and then we ``Queue`` another job.
   It's as simple as that. In this case, jobs 1 and 2 are identical except for
   their arguments.

   You may wonder how the log files are unique for each job if we havn't
   redefined them. This is because we're using condor macros to refer to the job
   ID. That being said, it is quite common to redefine the log files for each
   job, containing more human-useful information.


Generating a .submit
********************
Condor's strength is not running one job at a time. It's strength is running
thousands of jobs at a time, and no one in their right mind writes such submit
files by hand. A simple script is used to generate them.

We'll do a repeat of the above jobs, but this time outputing calendars for the
last ~1,000 years.

.. code::

  #!/bin/sh
  # v3.0

  logs_dir=~/logs
  # create the logs dir if it doesn't exist
  [ ! -d "$logs_dir" ] && mkdir -p "$logs_dir"

  # print the .submit header
  printf "# The environment
  universe       = vanilla
  getenv         = True
  request_cpus   = 1
  request_memory = 1G

  # Execution
  initial_dir    = \$ENV(HOME)
  executable     = /usr/bin/ncal
  \n"

  # create a job for each subject file
  for year in $(seq 1000 1999); do
      printf "arguments = ${year}\n"
      printf "log       = ${logs_dir}/y${year}_\$(Cluster).\$(Process).log\n"
      printf "output    = ${logs_dir}/y${year}_\$(Cluster).\$(Process).out\n"
      printf "error     = ${logs_dir}/y${year}_\$(Cluster).\$(Process).err\n"
      printf "Queue\n\n"
  done

Let's run the script and make sure that the output looks sane (if it fails with
"permission denied", you probably forgot to mark it as executable by using
``chmod +x``).

.. code::

  ./ncal_submit_gen.sh

If everything looks good, then it's time to submit the jobs directly to condor.

.. code::

  ./ncal_submit_gen.sh | condor_submit

And you just submitted 1,000 jobs to condor.


Useful Commands
***************
List all slots (available and used) and their size
  .. code::

    condor_status

Submit a job/job cluster
  .. code::

    condor_submit <file.submit>

To gain access to an interactive shell on a node — even with a GUI.
  .. code::

    condor_submit -interactive <file.submit>

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

User statistics, priority, and priority factor
  .. code::

    condor_userprio --allusers

For those who are more familiar with Sun's GridEngine, Condor provides ``condor_qsub``.
  .. code::

    condor_qsub


Documentation
*************
The `official Condor documentation`_ is long, but comprehensive. If you have
questions, their docs are a great resource. Pay special attention to the
sections on `Submitting a Job`_ and `Managing a Job`_.

.. _official Condor documentation: https://htcondor.readthedocs.io/en/v8_8_5/
.. _Submitting a Job: https://htcondor.readthedocs.io/en/v8_8_5/users-manual/submitting-a-job.html
.. _Managing a Job: https://htcondor.readthedocs.io/en/v8_8_5/users-manual/managing-a-job.html
