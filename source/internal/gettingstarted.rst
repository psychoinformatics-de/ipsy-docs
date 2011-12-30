.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

***************
Getting Started
***************

Desktop Session
===============

Most user would want to have a persistent desktop session on the cluster on
which they can test analysis, submit jobs and look at results. It is
recommended to use a VNC server for this purpose. For a minimal setup, simply
set a VNC password (this password should not be identical to the main login
password and not a precious, like the Google one):

.. code-block:: sh

   mih@medusa:/tmp$ vncpasswd 
   Password:
   Verify:

and start a server

.. code-block:: sh

   mih@medusa:~$ vncserver

   New 'medusa:1 (mih)' desktop is medusa:1

   Starting applications specified in /home/mih/.vnc/xstartup
   Log file is /home/mih/.vnc/medusa:1.log

Now it should be possible to log into the VNC session from a remote machine
using a VNC client/viewer. This could look like this:

.. code-block:: sh

   michael@meiner ~ % vncviewer -via medusa.ovgu.de :1

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

   mih@medusa:~$ cat << EOT > .vnc/xstartup
   > #!/bin/sh
   > vncconfig -iconic &
   > xfce4-session &
   > EOT
   mih@medusa:~$ chmod +x .vnc/xstartup

