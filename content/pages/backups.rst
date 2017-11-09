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
Thunk does a nightly backup of critical directories (etc, root, srv, etc) of
all (non-compute) servers. These backups are stored in
``/batcave/infra/<machine.name>/``

Zing snapshots its pools daily. Those snapshot are sent manually to thunk, but
soon will be automated. Note that ``zing/scratch`` is not sent to thunk.

I also, currently, run the non-daily snapshots manually (until I've written
zfsnap ttlgen)::

    zfsnap snapshot -v -a 6w zippy clunky -r zippy/data zippy/home zippy/project clunky/archive clunky/raw

I tend to keep a week's worth of snapshots on zing. I ``zfs destroy -rnv``
anything older. On mudflap, I use zfsnap to determine which snapshots have
expired. However, zfsnap makes too many calls and can be a bit slow (but it does
work). So I use it to highlight which ones need to be deleted, and I use the
same ``zfs destroy -rnv``.
