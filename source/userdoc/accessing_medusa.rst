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

It is important to have a good understanding of how to use the CLI. The
`Command Line Crash Course`_ is a decent tutorial (you don't have to follow everything
he says; I think flash cards is a bit excessive). The point of these tutorials
is to learn the basics can become comfortable with the CLI. Everything else you can
learn as you go along.

.. _Command Line Crash Course: http://cli.learncodethehardway.org/book/

Once you're comfortable with the CLI, a persistent session can be helpful; both
`screen`_ and `byobu`_ are installed on Medusa for your convenience.

.. _screen: https://www.gnu.org/software/screen/manual/screen.html
.. _byobu: http://byobu.co/documentation.html

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

   New 'medusa:9 (me)' desktop is medusa:9

   Starting applications specified in /home/me/.vnc/xstartup
   Log file is /home/me/.vnc/medusa:9.log

Note the number 9 after "medusa:". This is a unique number referencing your VNC
session. Note how it is used in the below example.

Now you can log into the VNC session from a remote machine using any of a
variety of VNC clients. On Linux, connecting with a client could look like this:

.. code-block:: bash

   me@laptop ~ % vncviewer -via medusa.ovgu.de :9

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

Accessing Medusa from a Windows Machine
=======================================
There are several methods to connect to Medusa from a Windows machine, however they are not
well tested as it is much more convenient to work from a \*nix OS.

TightVNC
--------
It is also possible to use VNC (as described above) with Windows. Download the
`TightVNC Java Viewer`_, start the VNC server as described above, and then
TightVNC can be used as a client to connect.

 * Remote Host: 127.0.0.1
 * Port: 5900 + your unique session number (e.g. 5909)
 * Check "Use SSH Tunneling"
 * SSH server: medusa.ovgu.de
 * SSH port: 22
 * SSH User: <your username>

When connecting, you will first be prompted for your SSH password, and then you
will be prompted for your VNC password.

.. _TightVNC Java Viewer: http://www.tightvnc.com/download.php

PuTTY and Xming
---------------
`PuTTY`_ is a useful open source SSH client for Windows. With this tool, it is
possible to connect to medusa with the basic command line interface (terminal).
When starting PuTTY, it opens a graphical user interface (GUI). Enter
'medusa.ovgu.de' as the host and select 'SSH' as the login protocol. Click 'open'
to establish a secure connection. This connection allows you run commands for the CLI (see above).

However, it is not possible to launch graphical applications on Medusa and use
them on your local computer even if you enable X forwarding in the PuTTY GUI
because Windows does not support X. The `Xming`_ project is an attempt to port X
to Windows and *should* work in combination with PuTTY as detailed on `this webpage`_
(see also `Xming PortablePuTTY`_).

.. _PuTTY: http://www.chiark.greenend.org.uk/~sgtatham/putty/
.. _Xming: http://www.straightrunning.com/XmingNotes/
.. _this webpage: http://www.geo.mtu.edu/geoschem/docs/putty_install.html
.. _Xming PortablePuTTY: http://www.straightrunning.com/XmingNotes/portable.php

NeuroDebian and VirtualBox
--------------------------
NeuroDebian offers a `virtual machine`_ that can run via `VirtualBox`_. A complete
Debian environment can then run as a guest system on your computer. This method allows
you to connect to medusa the UNIXy way as described above.

.. _virtual machine: http://neuro.debian.net/vm.html
.. _VirtualBox: https://www.virtualbox.org

Although more demanding of CPU, RAM, and disk space than other methods, using
the NeuroDebian VM is arguably the most convenient method of working on Medusa
graphically from a Windows machine.
