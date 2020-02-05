Code of Conduct
***************
:order: 220

..

  Sharing is caring. |br|
  —Wise Person

Medusa is a shared resource, and therefore should be used with awareness
and empathy for the work of others. Specific points to pay attention to are:

Use Condor for analysis
  All computational jobs are to be submitted to the HTCondor queue. The head
  node is meant for interactive use and quick computations, otherwise it
  negatively affects other people's work.  HTCondor Job descriptions should
  be accurate, and users should make an honest intellectual effort to adapt
  their jobs to the mythical `"ideal job" </medusa/htcondor/#the "ideal" job>`_.

Be mindful of your storage space
  Treat storage space as if it's a finite resource (pro-tip: it is).
  Take the time to regularly remove obsolete data and temporary files.
  Temporary/easily-regeneratable data should be stored in a ``scratch/``
  directory. More information is available in the
  `Data Documentation </medusa/data/>`_.

Report anything strange/faulty
  If you notice something broken (or even just strange) while working on the
  cluster, take the time to report it to Alex or Nico. If something isn't right,
  it likely affects others too.

.. |br| raw:: html

   <br />
