Medusa
######
:order: 200

Medusa [#name]_ is a small computational cluster used for neuroscience research
by a hardy cohort of scientists at the `Institute of Psychology II`_ at the
`Otto-von-Guericke University of Magdeburg`_.

Maintained by Alex Waite, Medusa is tailored to the analysis needs of psychology
researchers — running `Debian Linux`_ with additional research software provided
by `NeuroDebian`_

When you first use Medusa, you will use one machine: the head node. However,
Medusa is a collection of servers, with many dedicated computational nodes. In
order to use Medusa to its full potential, you will need to become familiar with
our job scheduler, `Condor <{filename}medusa/condor.rst>`_.

.. _Institute of Psychology II: http://www.ipsy.ovgu.de/en/institute_of_psychology.html
.. _Otto-von-Guericke University of Magdeburg: http://www.ovgu.de
.. _Debian Linux: https://www.debian.org
.. _NeuroDebian: http://neuro.debian.net

-----

.. [#name] Medusa, the monster from Greek mythology, had living snakes in place
   of her hair. The head node of the cluster is called "medusa" and each compute
   node is a "snake" (e.g. ``snake1``, ``snake2``, etc).
