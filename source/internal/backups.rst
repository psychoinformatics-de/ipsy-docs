.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******
Backups
*******

Laptops and Desktops
====================
There is no centralized backup process for user devices. Some people (especially
Mac users) backup their machines using local software (e.g. time machine).
Others use DropBox and/or Unison (to Medusa). Different strokes for different
folks.

Servers
=======
Mudflap does a nightly backup of critical directories (etc, root, srv, etc) of
all (non-compute) servers. These backups are stored in
``/jackknife/<machine.name>/``

Flatbed snapshots its pool daily at 07:00. Those snapshot are sent manually to
mudflap::

    zfs send -vR -I @from jackknife/home@to | ssh -c arcfour128 root@mudflap zfs receive -d trucknuts/jackknife
    zfs send -vR -I @from jackknife/data@to | ssh -c arcfour128 root@mudflap zfs receive -d trucknuts/jackknife
    zfs send -vR -I @from jackknife/archive@to | ssh -c arcfour128 root@mudflap zfs receive -d trucknuts/jackknife
    zfs send -vp -I @from jackknife@to | ssh -c arcfour128 root@mudflap zfs receive -d trucknuts/jackknife

Note that ``jackknife/scratch`` is not sent to mudflap. The explicit cipher for
SSH is because arcfour128 is the fastest cipher available ('none' isn't
available with Debian's ssh package). It's a trusted network, so I'm comfortable
with a weaker cipher.

I also, currently, run the non-daily snapshots manually (until I've written
zfsnap ttlgen)::

    /root/zfsnap/sbin/zfsnap.sh snapshot -rv -a 6w jackknife

To determine which snapshots should be designated as "@from" and "@to", run the
following::

    zfs list -t snapshot -d 1 -r jackknife

I tend to keep 3 days worth of snapshots on flatbed. I ``zfs destroy -rnv``
anything older. On mudflap, I use zfsnap to determine which snapshots have
expired. However, zfsnap makes too many calls and can be a bit slow (but it does
work). So I use it to highlight which ones need to be deleted, and I use the
same ``zfs destroy -rnv``.
