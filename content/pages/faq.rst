Frequently Asked Questions
##########################
:order: 900

Backup Policy
*************
For the cluster and all servers, `backups are performed daily </medusa/data/#backups>`_.

For laptops and desktops, there is no centralized backup process. It is your
responsibility to come up with a solution that meets your needs.

As examples, some users:

* backup their machines to an external hard drive (e.g. Time Machine)
* sync with DropBox/Google Drive
* simply don't keep important data on their laptops

Software Licensing
******************
`Martin Krippl`_ is responsible for IPSY proprietary software licensing. He's
the one to talk to if you need Office, EndNote, Matlab, SPSS, etc.

.. _Martin Krippl: https://lsf.ovgu.de/qislsf/rds?state=verpublish&status=init&vmfile=no&moduleCall=webInfo&publishConfFile=webInfoPerson&publishSubDir=personal&personal.pid=2471

Hardware Recommendations
************************
**Nico Marek** can help you if you have questions about the fit of a given
hardware solution or need help coming up with the specs for a new hardware
purchase.

Once determined, you will need to work with the secretary responsible for your
lab. They can best guide you through the purchasing process and inform you of
any strings that may be attached with the available funds.

Updating Website Content
************************
The websites for IPSY and most of its labs use OvGU's official Content
Management System. Information about how to update content in their system can
be found at `cms.ovgu.de`_.

If the content you want to add doesn't need to be on the main website, then
perhaps your `personal webspace on kumo`_ would be a good fit.

.. _cms.ovgu.de: https://www.cms.ovgu.de/
.. _personal webspace on kumo: /services/hosted/#webspace

Transferring Data
*****************
There are numerous methods to share/publish/exchange data with others.

"Small" (< 5 GB)
  Use your `personal webspace </services/hosted/#webspace>`_ on Kumo.

Larger, One-time Transfers
  A dedicated account (``ferry``) is used on Medusa to exchange larger
  collections of data with non-Medusa users. ``rsync`` is *highly* recommended.
  If you need this setup, ask **Nico Marek**.

Publishing Datasets
  Many large datasets are available for public consumption on psydata.ovgu.de
  (AKA Mulder). Data are published both via an rsync daemon and on a web server.
  http://psydata.ovgu.de
