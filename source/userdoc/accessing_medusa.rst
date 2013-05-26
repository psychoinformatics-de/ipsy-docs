.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

***************
Getting Started
***************

EMail setup
===========

Condor can -- conveniently -- notify you via email. But to do that, Condor needs
to know what your email address is. To set that up, create a ``.forward`` file
in your home directory containing the email address that you want your messages
delivered to.


.. _vnc_session:

Desktop Session
===============

Many users want a persistent desktop session on the cluster in
which they can test analysis, submit jobs, and examine results. It is
recommended to use a VNC server for this purpose. For a minimal setup, simply
set a VNC password (this password should not be identical to the main login
password and not precious, like the Google one):

.. code-block:: sh

   perseus@medusa:/tmp$ vncpasswd 
   Password:
   Verify:

and start a server

.. code-block:: sh

   perseus@medusa:~$ vncserver

   New 'medusa:1 (perseus)' desktop is medusa:1

   Starting applications specified in /home/perseus/.vnc/xstartup
   Log file is /home/perseus/.vnc/medusa:1.log

Now it should be possible to log into the VNC session from a remote machine
using a VNC client/viewer. This could look like this:

.. code-block:: sh

   perseus@laptop ~ % vncviewer -via medusa.ovgu.de :1

   VNC Viewer Free Edition 4.1.1 for X - built Mar 10 2010 21:40:13
   Copyright (C) 2002-2005 RealVNC Ltd.
   See http://www.realvnc.com for information on VNC.

   Wed Dec 28 15:55:28 2011
    CConn:       connected to host localhost port 5599
    CConnection: Server supports RFB protocol version 3.8
    CConnection: Using RFB protocol version 3.8
   Password: 

If password-based SSH authentication is used this command will ask for two
passwords: first the SSH password and next the VNC password. By default users
will be served with a slim XFCE desktop. It is highly recommended to disable
any kind of background image and use a solid color (e.g. black) for the desktop
background. this will save bandwidth and offers significant speed improvements.

For advanced users it is possible to customize the desktop session with a
startup script like this one:

.. code-block:: sh

   perseus@medusa:~$ cat << EOT > .vnc/xstartup
   > #!/bin/sh
   > vncconfig -iconic &
   > xfce4-session &
   > EOT
   perseus@medusa:~$ chmod +x .vnc/xstartup


Persistent terminal sessions
============================

For many tasks, VNC is not necessary and a terminal session is enough,
or even better -- for example on slow network connections. For this case, Medusa
has both ``screen`` and ``byobu`` avialable. ``byobu`` especially is
recommended for beginners:

* http://www.gnu.org/software/screen/
* https://launchpad.net/byobu
