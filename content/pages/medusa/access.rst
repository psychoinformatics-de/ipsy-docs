Accessing
#########
:order: 230

Command Line
************
The easiest and most reliable way of connecting to Medusa is via
`SSH </tools/ssh/>`_.

Connecting is as simple as running the following in your terminal:

.. code::

  ssh username@medusa.ovgu.de

.. class:: note

  **NOTE:** Users with unstable internet connections will likely find
  `tmux </tools/tmux/>`_ to be a helpful tool.

Graphical
*********
There are multiple methods of connecting to Medusa graphically.

**X Forwarding**
  Graphical programs run on the remote server can be displayed locally using
  `SSH's X Forwarding </tools/ssh/#x%20forwarding>`_. Do note that X Forwarding
  is very sensitive to latency, so it is only practical to use when on the OvGU
  campus.

  .. code::

    ssh -X username@medusa.ovgu.de

**Sixel**
  `Sixel </tools/sixel/>`_ is mostly a toy right now. But it is quite convenient
  in the few situations where there is support (image and NIfTI previews).

**VNC**
  VNC is for users who prefer a more familiar desktop experience or need to use
  graphical programs while off-campus. VNC is a multi-step process and not as
  easy as straight SSH.

  First, SSH into Medusa (explained above). Then setup your VNC password. You
  only need to do this once. The password is stored **unencrypted** in a text
  file, so do not use a valuable password (such as for Medusa, email, etc).

  .. code::

    me@medusa:~$ vncpasswd
    Password:
    Verify:

  Next, start the VNC server.

  .. code::

    me@medusa:~$ vncserver

    New 'medusa:9 (me)' desktop is medusa:9

    Starting applications specified in /home/me/.vnc/xstartup
    Log file is /home/me/.vnc/medusa:9.log

  Note the number ``9`` in ``medusa:9``. Yours will likely be different. Take
  note of your number, as it references *your* VNC session and will be used
  later.

  The VNC server runs until it is terminated by you (or a reboot of Medusa). If
  you close your client/disconnect, it will continue to run. If you "log out" in
  the session, it will terminate the server.

  **Linux**
    Open a terminal and run the following:

    .. code::

      vncviewer -via medusa.ovgu.de :9

    Note the ``:9``. Make sure that this is *your* number from above.  This
    command will first ask that you authenticate to Medusa, and then it will ask
    for the VNC password you set before.

  **macOS**
    macOS has a VNC client built-in, but it isn't SSH aware. So a SSH tunnel
    needs to be setup first.

    .. code::

      ssh -f -L 5909:127.0.0.1:5909 username@medusa.ovgu.de sleep 60

    Then you can use VNC.

    .. code::

      open vnc://127.0.0.1:5909

    Note the number "5909" in both commands. It should be 5900 + the ``number``
    noted above. Make sure that it is *your* number.

    .. class:: todo

      **TODO**: write a simple shell script that can be ``curl``-ed into the user's path.

  **Windows**
    Windows lacks a built-in VNC viewer, so you will need `TightVNC Java
    Viewer`_. Be sure to download the **TightVNC Java Viewer**; it is not the
    first link on their download page. You will also need Java installed in
    order to run it.

    Launch the viewer and enter the following information:

    * Remote Host: 127.0.0.1
    * Port: 5900 + your unique session number (e.g. 5909)
    * Check "Use SSH Tunneling"
    * SSH server: medusa.ovgu.de
    * SSH port: 22
    * SSH User: <your username>

    Note the port number: "5909". It should be 5900 + the ``number`` we
    noted above. Make sure that it is *your* number.

    Upon connecting, you will first be asked to authenticate to Medusa; then it
    will ask for the VNC password you set before.

  .. class:: todo

    **TODO**: Move most of this VNC info to ``tools/VNC``. Or avoid the entire
    mess by migrating to HTTP-based VNC (like Guacamole).

  .. _TightVNC Java Viewer: http://www.tightvnc.com/download.php
