.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

***********************
Sharing Data Externally
***********************

So, you want to share data with other people, and you want to know the
best/easiest way to do so.

As is always the case, it depends on what you're trying to do.

  * We have an http server on kumo.ovgu.de. Each user has a public_html/ folder
    in their home folder on kumo. That folder points to

      `http://kumo.ovgu.de/~<username>/`

    Sharing a couple gigs of data there is no problem, but beyond that is
    problematic as space is limited on this server.
  * For larger, one time transfers (20+ GB), we tend to setup a dedicated SSH
    account for the remote user. They then use rsync to copy the data, which
    puts everyone's mind at ease because rsync checksums (and guarantees
    everything is downloaded correctly) unlike HTTP.
  * When publishing large datasets, we have a server called mulder that shares
    over a dedicated rsync daemon and http. But the http interface is mostly for
    a few select files, or (more likely) for git-annex (which handles
    checksumming) to sync against.

If you need the last option or aren't quite sure which method is best for you,
contact Alex.

