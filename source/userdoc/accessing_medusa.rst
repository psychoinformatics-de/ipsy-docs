.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

****************
Accessing Medusa
****************
The are a few different ways to connect to Medusa.

Command Line
============
The simplest and easiest way to connect to Medusa is via SSH -- to access the 
command line interface (CLI). On OS X or Linux, login to Medusa by executing
the following in your Terminal::

  me@somewhere:~$ ssh -X me@medusa.ovgu.de

And now you're on Medusa.

It is important to have a good understanding of how to use the command line interface.

.. todo: Find good CLI tutorial.

Once you're comfortable with the CLI, a persistent session can be helpful; both
`screen`_ and `byobu`_ are installed on Medusa for your convenience.

.. _screen: http://www.gnu.org/software/screen/
.. _byobu: https://launchpad.net/byobu

The ``-X`` option passed to SSH allows you to launch graphical applications on Medusa
and have them appear on your local computer. While convenient, this method is *very*
sensitive to latency (not bandwidth) and thus will work well only on campus.

Desktop Session
===============
Some users prefer a persistent graphical session on Medusa. A VNC server is used
for this purpose. To setup VNC, you first need to set a VNC password (this password is
stored in clear text, so do not use a precious password such as your medusa login, email, etc):

.. code-block:: bash

   me@medusa:/tmp$ vncpasswd 
   Password:
   Verify:

and then start the server

.. code-block:: bash

   me@medusa:~$ vncserver

   New 'medusa:1 (me)' desktop is medusa:1

   Starting applications specified in /home/me/.vnc/xstartup
   Log file is /home/me/.vnc/medusa:1.log

Now you can log into the VNC session from a remote machine using any of a variety of VNC
clients. On Linux, connecting with a client could look like this:

.. code-block:: bash

   me@laptop ~ % vncviewer -via medusa.ovgu.de :1

   VNC Viewer Free Edition 4.1.1 for X - built Mar 10 2010 21:40:13
   Copyright (C) 2002-2005 RealVNC Ltd.
   See http://www.realvnc.com for information on VNC.

   Wed Dec 28 15:55:28 2011
    CConn:       connected to host localhost port 5599
    CConnection: Server supports RFB protocol version 3.8
    CConnection: Using RFB protocol version 3.8
   Password: 

This command will ask for two passwords: first) your SSH password and second) the VNC
password you set. The default desktop is XFCE, and it is highly recommended to use a solid
color for the desktop background. This saves bandwidth and offers significant speed improvements.

