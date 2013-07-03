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

Accessing Medusa from a Windows Machine
=======================================
If you are for some reason bound to use Windows for your work, but you want to access Medusa, there are several possibilities to do so (not all of them are tested yet thouroughfully, since it is recommended to use a Unix based OS for your work).

PuTTY and Xming
---------------
PuTTY (http://www.chiark.greenend.org.uk/~sgtatham/putty/) is a useful open source SSH client that also runs on Windows machines. With this tool it is possible to connect to medusa with the basic command line interface (terminal). When starting PuTTY it opens a graphical user interface (GUI). You have to enter 'medusa.ovgu.de' as host and select 'SSH' as login protocol and then press open to establish a secure connection. This connection allows you run commands for the CLI (see above).

However, it is not possible to launch graphical applications on Medusa and use them on your local computer even if you enable X forwarding in the PuTTY GUI, because a native Windows system is not capable of interpreting the X commands. For this purpose it is necessary to install an X server such as Xming (http://www.straightrunning.com/XmingNotes/). Xming should work in combination with PuTTY as described on this webpage: http://www.geo.mtu.edu/geoschem/docs/putty_install.html (see also http://www.straightrunning.com/XmingNotes/portable.php).


TighVNC
-------

As described above for Unix OS, it is also possible to use the VNC server to open a graphical session on Medusa. TightVNC (http://www.tightvnc.com/) is a free VNC client that runs on Wndows machines. First it is necessary to set up and start the VNC server as described above, and then TightVNC can be used as client to connect to Medusa as described above.


NeuroDebian and VirtualBox
--------------------------

NeuroDebian offers a virtual machine (http://neuro.debian.net/vm.html) that can be used on windows host machines with VirtualBox (https://www.virtualbox.org). This allows to run a complete Linux OS (Debian) as guest system on a windows computer. With this it is possible to connect to Medusa as described above, ideally with a terminal runnng ssh.

The VirtualBox allows to share folders between host and guest system, thus it is possible to access files on the local  with Windows and Linux at the same time. Installing krusader ('sudo aptitude install krusader') gives a convenient file manager that enables to easily transfer files between Medusa and the local machine. For this, select in krusader the  'Tools' menu and then 'New Net Connection ...'. Use 'fish' as protocol and enter 'medusa.ovgu.de' in the host field. After the connection is established, you can created a bookmark by klicking on the star next to the filepath.

Though demanding quite a lot of disk space, using NeuroDebian on a Windows machine might be the most convenient way to connect to Medusa. Especially, because it provides a complete Linux environment that can be used to familarize oneself with Linux, and thus might help to realize, that Linux is the superior OS for scientific work.