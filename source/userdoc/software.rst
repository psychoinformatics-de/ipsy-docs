.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

.. _softwaredoc:

******************
Software on Medusa
******************

This section has information on Medusa-specific aspects of software installed
on the cluster.


Freesurfer
==========

Freesurfer is installed in ``/opt/freesurfer/<VERSION>``. At the time of this
writing it is version 5.1.0. To be able to use Freesurfer a few configuration
steps are required. Users need to point to the installation directory of the
desired Freesurfer version by setting the ``FREESURFER_HOME`` environment
variable and sourcing the Freesurfer shell configuration like this::

  perseus@medusa ~ % export FREESURFER_HOME=/opt/freesurfer/5.1.0
  perseus@medusa ~ % . ${FREESURFER_HOME}/SetUpFreeSurfer.sh
  -------- freesurfer-Linux-centos4_x86_64-stable-pub-v5.1.0 --------
  Setting up environment for FreeSurfer/FS-FAST (and FSL)
  FREESURFER_HOME   /opt/freesurfer/5.1.0
  FSFAST_HOME       /opt/freesurfer/5.1.0/fsfast
  FSF_OUTPUT_FORMAT nii.gz
  SUBJECTS_DIR      /opt/freesurfer/5.1.0/subjects
  INFO: /home/mih/matlab/startup.m does not exist ... creating
  MNI_DIR           /opt/freesurfer/5.1.0/mni

More details on Freesurfer configuration can be found in the `Freesurfer Wiki
<http://surfer.nmr.mgh.harvard.edu/fswiki/SetupConfiguration>`_.
