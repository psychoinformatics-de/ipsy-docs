Software
########
:order: 560

A wide variety of software is installed across the cluster. The majority are
preconfigured, but some require additional setup by each user before they can be
used.

FSL
***
FSL ships with many commands which conflict with other command names, so *all*
FSL commands are prepended with ``fsl5.0-``.

To configure FSL with defaults and remove the ``fsl5.0-`` prefix, run the
following:

.. code::

  . /etc/fsl/fsl.sh

This needs to be run each time you start a new session on Medusa.  If you'd
rather it be done automatically, add it to your ``.bashrc`` file.

FreeSurfer
**********
FreeSurfer's configuration is setup using something called "environmental
modules."

First, "modules" must be loaded:

.. code::

  . /etc/profile.d/modules.sh

Then, you can query which versions of FreeSurfer are available:

.. code::

  module avail freesurfer

Then, to load version 6.0, run the following:

.. code::

  module load freesurfer/6.0

Now you can use FreeSurfer.

The process needs to be performed each time you start a new session on Medusa.
If you'd rather it be done automatically, add the following lines to your
``.bashrc`` file.

.. code::

  . /etc/profile.d/modules.sh
  module load freesurfer/6.0
