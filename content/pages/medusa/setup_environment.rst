.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**********************
Setup your Environment
**********************
There are many things you can do to customize your environment on Medusa; too
many to list here -- or anywhere. But here are a few things to note.

Email setup
===========
Occasionally medusa has reason to email you. Condor's job notifications can be
sent via email and are especially convenient. Periodically, status updates and
system info is emailed to all users.

To setup your account for email forwarding, just run the following on medusa::

  me@medusa:~$ printf '<your.email@address.com' > ~/.forward

Make sure that the email address is correct, otherwise the Medusa Admins will
get angry calls from the University IT guys.
