Medusa
******

Medusa is a small computational cluster for IPSY.

Maintained by Alex Waite, medusa runs `NeuroDebian`_ and is tailored to the
analysis needs of psychology researchers.

Primary interface is head node; limited; idenitical as possibel to compute
nodes. use condor for that.


The compute nodes are kept as identical as possible when it comes to software
and configuration. They are meant to only be used via Condor; SSH access is
allowed only to ease troubleshooting of Condor jobs.



.. _NeuroDebian: neuro.debian.net
