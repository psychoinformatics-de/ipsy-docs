.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

********************************
How to behave properly on Medusa
********************************


Do not use storage space unless you really need it

  The storage space on Medusa is a shared resources for all users. Currently
  there are no user quotas to allow for a maximum of flexibility. Please be
  considerate regarding your disk space usage to not cause trouble for other
  users. Take the time to regularly remove obsolete data, and temporary files.


Do not use the compute nodes directly

  It is possible to log into all of Medusa's compute nodes directly via SSH.
  This functionality is provided to allow for easy investigation of problems
  and troubleshooting. Do not use this mechanism to run CPU or memory intensive
  processes on compute nodes. **Always** submit such job to the :ref:`Condor
  <condordoc>` system on Medusa. Only by using Condor optimal and fair resource
  distribution and job scheduling can be guaranteed. Directly executing jobs on
  nodes sabotages this system and threatens the stability of the cluster as
  well as negatively affects reliability and performs of other user's jobs.


Report strange/faulty behavior

  If you notice something strange while working with Medusa, please take the
  time to report it. If software or hardware is not working properly it might
  also affect other users. Please report problem to avoid waste of time and
  money.


Read your email

  Create a ``.forward`` file on your home directory on Medusa that contains the
  email address you want to have Medusa sent emails to you to. Medusa might sent
  status reports from Condor, error reports and other message you should pay
  attention to. Please double check the email address to avoid error messages
  that need to be investigated manually by a university sysadmin.

