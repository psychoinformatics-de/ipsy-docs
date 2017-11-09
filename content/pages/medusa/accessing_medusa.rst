****************
Accessing Medusa
****************
The are a few different ways to connect to Medusa, depending on your OS (Linux,
Windows, OS X) and what you need (command line, GUI, persistent GUI).

For ease, this is broken down by method, then OS.

Command Line (with support for graphical programs)
==================================================
The simplest and easiest way to connect to Medusa is via SSH -- to access the
command line interface (CLI).

It is important to have a good understanding of how to use the CLI. The
`Command Line Crash Course`_ is a decent tutorial (though I do think flash
cards are a bit excessive). The point of these tutorials is to become
comfortable with CLI basics. Everything else you can learn as you go along.

.. _Command Line Crash Course: https://learnpythonthehardway.org/book/appendixa.html

*Linux and OS X*
    Just run the following in your terminal and authenticate with your username
    and password. The ``-X`` option allows you to launch graphical applications
    on Medusa and have them appear on your local computer. While convenient,
    this method is sensitive to network latency (not bandwidth) and thus will
    work well only on campus. If you need to use graphical applications
    off-campus, or desire a persistent desktop session, then VNC (explained
    below) is better.

    .. code-block:: bash

        me@somewhere:~$ ssh -X me@medusa.ovgu.de

    If you run OS X 10.8 or later, then you will need to download and install
    `XQuartz`_.

.. _XQuartz: http://xquartz.macosforge.org

*Windows*
    To simply connect to medusa over SSH with no graphical applications,
    `PuTTY`_ is simplest. Starting PuTTY opens a window. Enter 'medusa.ovgu.de'
    as the host and select 'SSH' as the login protocol. Click 'open' to
    establish a secure connection. Enter your username and password, and you're
    ready to go.

    If you want to use graphical applications on medusa from Windows, then you
    should use `Xming`_. Download the archive and extract it to a folder.
    Double click on "Start Xming+PuTTY.bat". This will start Xming in the
    background. Then, look in in your system tray (next to the clock in the
    lower right corner). Right click on the black "X" and choose "Connect to
    medusa...". Authenticate with your username and password, and you're ready
    to go.

    Please note, graphical applications over Xming are sensitive to network
    latency (not bandwidth) and thus will work well only on campus. If you need
    to use graphical applications off-campus, or desire a persistent desktop
    session, then VNC (explained below) is better.

.. _PuTTY: http://the.earth.li/~sgtatham/putty/latest/x86/putty.exe
.. _Xming: ../_static/Xming-IPSY.zip

Desktop Session (VNC)
=====================
Some users prefer a persistent graphical session or have higher-latency
connections. VNC is better suited to this purpose. Setting up VNC is a
multi-step process, so it is not quite as straight-forward as the previous
methods.

First, and for all platforms, SSH into medusa (as explained above) and make
sure you have a VNC password set. This password is stored in clear text, so do
not use a precious password (such as your medusa login, email, etc):

Because the VNC server is persistent, you only need to do these first steps
(vncpasswd and vncserver) once (or until medusa needs to be restarted, which is
usually about twice a year).

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

Note the number "9" after "medusa:". Yours will likely be different. This is a
unique number referencing *your* VNC session and will be used later.

Now you're ready to connect to your VNC session.

*Linux*
    Open a terminal and run the following:

    .. code-block:: bash

        me@laptop ~ % vncviewer -via medusa.ovgu.de :9

    Note the ":9". Make sure that this is *your* number from above.
    This command will first ask that you authenticate to medusa, and then it
    will ask for the VNC password you set before.

*OS X and Windows*
    The `TightVNC Java Viewer`_ is a decent, SSH aware, standalone VNC client.
    Download the client, run it, and then use the following information to
    connect:

    * Remote Host: 127.0.0.1
    * Port: 5900 + your unique session number (e.g. 5909)
    * Check "Use SSH Tunneling"
    * SSH server: medusa.ovgu.de
    * SSH port: 22
    * SSH User: <your username>

    Note the port number. This should be 5900 + *your* number from before. For
    example: 5909.
    You will first be asked to authenticate to medusa, and then it will ask for
    the VNC password you set before.

.. _TightVNC Java Viewer: http://www.tightvnc.com/download.php

Note
----
The portable Xmin and PuTTY combo is kindly assembled and shared by the Spinal
Cord Research Centre of Manitoba, Canada.

