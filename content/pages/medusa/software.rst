Software
########
:order: 250

A wide variety of software is installed across the cluster (AFNI, FSL,
FreeSurfer, Octave, Python, R, Matlab, etc). The majority of software is
configured to work out-of-the-box, but some software requires additional setup
by each user before they can be used.

AFNI
****
AFNI ships with commands which are named the same as commands from other
packages, so to enable AFNI, run the following:

.. code::

  source /etc/afni/afni.sh

This needs to be run each time you start a new session on the cluster. If you
prefer that it be run automatically, you can add it to your ``.zshrc`` file.

.. class:: note

  **NOTE:** The following commands are known to have conflicts: ``whirlgif``
  (FSL, wims), ``gifti_test`` (FreeSurfer), ``gifti_tool`` (FreeSurfer),
  ``nifti1_test`` (Niftilib), ``nifti_stats`` (Niftilib), ``nifti_tool``
  (Niftilib), and ``whereami`` (whereami).

ANTs
****
ANTs' configuration is setup using something called "environmental modules."

First, "modules" must be loaded:

.. code::

  source /etc/profile.d/modules.sh

Then, to load version 2.2.0, run the following:

.. code::

  module load ants/2.2.0

Now you can use ANTs.

The process needs to be performed each time you start a new session on the
cluster. If you'd rather it be done automatically, add the following lines to
your ``.zshrc`` file.

.. code::

  source /etc/profile.d/modules.sh
  module load ants/2.2.0

.. class:: note

  **NOTE:** There are no *known* namespace conflicts with other commands, so it
  should be safe to add the above lines to your ``.zshrc``.

FreeSurfer
**********
FreeSurfer's configuration is setup using something called "environmental
modules."

First, "modules" must be loaded:

.. code::

  source /etc/profile.d/modules.sh

Then, you can query which versions of FreeSurfer are available:

.. code::

  module avail freesurfer

Then, to load version 6.0, run the following:

.. code::

  module load freesurfer/6.0

Now you can use FreeSurfer.

The process needs to be performed each time you start a new session on the
cluster. If you'd rather it be done automatically, add the following lines to
your ``.zshrc`` file.

.. code::

  source /etc/profile.d/modules.sh
  module load freesurfer/6.0

.. class:: note

  **NOTE:** The following commands are known to have conflicts: ``gifti_test``
  (AFNI), ``gifti_tool`` (AFNI), and ``dsh`` (dsh).

FSL
***
FSL ships with commands which are named the same as commands from other
packages, so *all* FSL commands are prepended with ``fsl5.0-``.

To configure FSL with defaults and remove the ``fsl5.0-`` prefix, run the
following:

.. code::

  source /etc/fsl/fsl.sh

This needs to be run each time you start a new session on the cluster. If you
prefer that it be run automatically, you can add it to your ``.zshrc`` file.

.. class:: note

  **NOTE:** The following commands are known to have conflicts: ``whirlgif``
  (AFNI) and ``cluster`` (graphviz).

MATLAB
******
Multiple versions of Matlab are installed on the cluster. Because of this, there
is no single ``matlab`` command. Instead, each version is suffixed with its
version number (for example ``matlab94``).

This suffixing is also applied to ``mex``, ``mbuild``, ``lmutil``, and ``mcc``.

You can check the current license usage by running:

.. code::

    lmutil96 lmstat -a -c 1984@liclux.urz.uni-magdeburg.de

Python
******
Python 2.7 and 3.5 are installed on the cluster — along with a wide variety
of modules that are available to ``import``.

If you need a python module that is not yet installed and think it is of
interest and utility to other cluster users, just ask Alex to deploy it on the
cluster. Alternatively, you can `install it in a virtualenv
</tools/python/#virtual-environments>`_.

R
**
R 3.3 is installed on the cluster — along with a wide variety of packages from
CRAN that are available via the ``library()`` command.

If you need an R package that is not yet installed (and there is a Debian
package for it), just ask Alex to deploy it on the cluster. Alternatively, you
can `install it from CRAN </tools/r/#cran>`_.
