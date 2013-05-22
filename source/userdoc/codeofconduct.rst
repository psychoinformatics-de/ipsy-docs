.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

********************************
How to behave properly on Medusa
********************************

Simply put:
 * play nicely in the sandbox with others
 * sharing is caring

Do not use storage space unless you really need it

  Storage space is a shared resources for all users. Currently
  there are no user quotas to allow for maximum flexibility. Please be
  considerate regarding your disk space usage so as to not cause trouble for other
  users. Take the time to regularly remove obsolete data and temporary files.


Do not use the compute nodes directly

  Simply put: use Condor. While it is possible to log into any of Medusa's
  compute nodes directly via SSH, this functionality is only provided to
  ease troubleshooting efforts -- and nothing else. **Always** submit jobs to the
  :ref:`Condor <condordoc>` system on Medusa. Only by using Condor can the
  optimal and fair distribution of resources and job scheduling be guaranteed.
  Directly executing jobs on nodes is akin to sabotaging other people's work;
  don't do it.


Report strange/faulty behavior

  If you notice something strange while working with Medusa, please take the
  time to report it. If software or hardware is not working properly, it likely
  affects other users too.


Read your email

  Create a ``.forward`` file in your home directory on Medusa containing your email
  email address. Doing so will enable Medusa to send you status reports from Condor,
  error reports, and other message you should pay attention to. Please double check
  the email address to avoid error messages that need to be investigated manually
  by a university sysadmin.

