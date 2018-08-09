Code of Conduct
###############
:order: 505

..

  Sharing is caring. |br|
  —Wise Person

Medusa is a shared resource, and thus should be used with awareness and empathy
for the work of others. Specific points to pay attention to are:

Use Condor for analysis
  The head node is meant for interactive use and quick computations. Users
  should use no more than 1 or 2 cores at a time. Anything more than that
  actively interferes with other people's work.  `Condor
  <{filename}condor.rst>`_ should be used for all non-trivial computation — and
  will give you results faster than just using the head node.

Be mindful of your storage space
  Treat storage space as if it's a finite resource (pro-tip: it is).
  Take the time to regularly remove obsolete data and temporary files.
  Temporary/easily-regeneratable data should be stored in a ``scratch/``
  directory. More information is available in the
  `Data Documentation <{filename}data.rst>`_.

Report anything strange/faulty
  If you notice something broken (or even just strange) while working with
  Medusa, take the time to report it to Alex or Michael. If something isn't
  right, it likely affects others too.

.. |br| raw:: html

  <br />
