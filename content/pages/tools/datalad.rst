DataLad
#######
:order: 535

DataLad is a data management tool to share, search, obtain, extend, and version
data.

Beware that the underlying ``git annex`` calls (e.g. when calling
``datalad save``) can be very CPU-intense once a dataset contains many files
(e.g. a typical fMRI dataset). Thus, it is important to work on such datasets
via an `interactive job </medusa/htcondor#The interactive job>`_.


Resources
*********

* The `DataLad Handbook`_ is the most comprehensive effort to document DataLad.
  However, it is still very much a work in progress as currently the content
  changes almost daily.
* `DataLad Docs`_

.. _DataLad Handbook: http://handbook.datalad.org/en/latest/index.html
.. _DataLad Docs: http://docs.datalad.org/en/latest/#

Common Workflows
****************
.. class:: todo

  **TODO:** Provide examples of a common IPSY workflows.
