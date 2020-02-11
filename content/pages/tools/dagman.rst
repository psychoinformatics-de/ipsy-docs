DAGMan
######
:order: 533

DAGMan is a `HTCondor </tools/htcondor>`_ tool that allows multiple jobs to be
organized in workflows. A DAGMan workflow automatically submits jobs in a
particular order, such that certain jobs need to complete before others start
running.

Once you are familiar with how to create, submit, and monitor
`HTCondor jobs </tools/htcondor>`_, creating DAGMan workflows is relatively
easy. The `official documentation`_ describes comprehensively the overall
structure and available scripting of the dag-file.

.. _official documentation: <https://htcondor.readthedocs.io/en/latest/users-manual/dagman-workflows.html>

A simple dag file consists of a list of nodes (which are jobs plus optional pre-
and post-processing scripts). In addition, their relationship can be specified
via ``PARENT JobName CHILD JobName`` structures.

A DAGMan example
****************

A simple use-case for DAGMan is when wanting to run a set of jobs one after
another, without having to submit each job manually once the previous one
finishes (for example, when importing dicoms using ``datalad hirni-import-dcm``
or preprocessing multiple subjects using ``fmriPrep`` in sequence - both of
these do not run well in parallel at the time of writing).

To achieve this two files are needed: a submit-file (e.g.  ``my_job.submit``)
and a dag-file (e.g. ``my_workflow.dag``).

The submit-file is a regular HTCondor submit file, but in addition, it can have
special variables which will be set via the dag file on submission:

.. code::

  #### The submit file - my_job.submit
  # The environment
  universe       = vanilla
  getenv         = True
  request_cpus   = $(req_cpu)
  request_memory = $(req_mem)

  # Execution
  initial_dir    = $ENV(HOME)
  executable     = $ENV(HOME)/my_nature_worthy_analysis.sh

  # Job 1
  #NOTE: 2. & 3. argument are request_cpus and request_memory, respectively
  arguments = "$(subject) $(req_mem) $(req_mem)"
  log       = $ENV(HOME)/logs/fortune_$(Cluster).$(Process).log
  output    = $ENV(HOME)/logs/fortune_$(Cluster).$(Process).out
  error     = $ENV(HOME)/logs/fortune_$(Cluster).$(Process).err
  Queue

In the above script, three additional, non-standard variables are included:
``req_cpu``, ``req_mem``, and ``subject``. The first two are used to dynamically
specify how many resources are needed for the job, as well as to be passed on to
the analysis-script via the ``arguments`` of the job. The variable ``subject``
is only passed on to the analysis script.

In the associated dag-file, these variables can be set for all nodes (using
``VARS ALL_NODES ..``) or for only specific nodes (``VARS JobName ..``). The
example below shows how to set requirements for all jobs; the node names (a.k.a
JobName ``001``, ``002``, and ``003``) are used to dynamically set the subject
numbers.

.. code::

    #### my_workflow.dag
    JOB 001 my_job.submit
    JOB 002 my_job.submit
    JOB 003 my_job.submit

    VARS ALL_NODES req_mem="1000"
    VARS ALL_NODES req_cpu="2"
    VARS ALL_NODES subject="$(JOB)"

    CATEGORY ALL_NODES DummyCategory

    MAXJOBS DummyCategory 1

Finally, it is possible to limit the number of concurrently running jobs for
each category of job. In this example, only one category (``DummyCategory``) is
created and its ``MAXJOBS`` value is set to 1.

Submitting the dag-file using ``condor_submit_dag my_workflow.dag`` will add the
workflow to condor's queue and execute all three jobs one after another, making
sure that only one of them is running at a given time:

.. code::

    -- Schedd: medusa.local : <10.0.0.100:9618?... @ 02/11/20 20:58:05
    OWNER  BATCH_NAME              SUBMITTED   DONE   RUN    IDLE  TOTAL JOB_IDS
    pvavra my_workflow.dag+1898   2/11 19:57      _      1      _      3 1898912.0

    2 jobs; 0 completed, 0 removed, 0 idle, 2 running, 0 held, 0 suspended
