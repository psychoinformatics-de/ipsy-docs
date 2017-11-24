Transferring Data
*****************
:order: 050

There are numerous methods to share/publish/exchange data with others.

Small Files (< 2 GiB)
  Every IPSY user has a ``public_html/`` folder in their home directory on
  ``kumo.ovgu.de``. Any files placed in that folder will be made available at
  ``http://kumo.ovgu.de/~<username>/``.
Larger, One-time Transfers
  A dedicated account (with a temporary password) on medusa to exchange larger
  collections of data with non-medusa users. ``rsync`` is *highly* recommended,
  as it checksums every file transferred, guaranteeing that nothing was
  corrupted during the transfer.
  Windows users (who do not have access to ``rsync``) can use `WinSCP`_ instead;
  however, WinSCP does not support checksumming.
Publishing Datasets
  Many large datasets are available for public consumption on
  ``psydata.ovgu.de``. Data are shared via an rsync daemon and HTTP.
  http://psydata.ovgu.de

.. _WinSCP: https://winscp.net/eng/download.php
