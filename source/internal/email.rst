.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*****
Email 
*****
For standard email information, please refer to the `OvGU email docs`_.

.. _OvGU email docs: http://www.urz.ovgu.de/Unsere+Leistungen/Anwendungen/E_Mail/Konfiguration-p-714.html

SMTP -- Smarthost
=================
Our servers use ``mail.ovgu.de`` as a smarthost for (exim's) outgoing email. mail.ovgu.de
only accepts on-campus unauthenticated SMTP connections if it can do a reverse DNS lookup
of the machine. Thus ``mudflap`` and all ``snakes`` (all behind NAT) must use Medusa to
send email, and cannot use mail.ovgu.de directly.

Mailing Lists
=============
We operate a few mailing lists (hosted by the university):

exppsy@ovgu.de
        Mailing list for the `exppsy group`_.

neuropsy-list@ovgu.de
        Mailing list for the `neuropsy group`_.

biopsy-l@ovgu.de
        Mailing list for the `biopsy group`_.

brazi-l@ovgu
        `Meta mailing list`_ that emails directly to the above three lists.

.. _exppsy group: https://listserv.uni-magdeburg.de/mailman/admin/exppsy/
.. _neuropsy group: https://listserv.uni-magdeburg.de/mailman/admin/neuropsy-list
.. _biopsy group: https://listserv.uni-magdeburg.de/mailman/admin/biopsy-l/
.. _Meta mailing list: https://listserv.uni-magdeburg.de/mailman/admin/brazi-l/

Email Notification on Medusa
============================
Users should have a ``$HOME/.forward`` file containing the email address to which they
wish to have Condor email sent.

