.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

*******************
Pollmann Eyetracker
*******************

The Pollmann lab uses PsychToolbox heavily, but is now beginning to use PsychoPy
more.

Hardware
========

An nVidia GPU with a lot of VRAM was selected because of the number of textures
which they store in the GPU to quickly rotate and redraw.

Software
========

The base setup is the standard Linux `behavioral setup <behavioral_setup>`_.
Follow that guide, and then continue with the following.

Repositories
------------

I added the `SR-Research Linux Repo`_, which is incredibly outdated.

* deb http://download.sr-support.com/x64 /

.. _SR-Research Linux Repo: https://www.sr-support.com/showthread.php?16-EyeLink-Developers-Kit-for-Linux-%28Linux-Display-Software%29

Install
-------

First, a bit of background: All we want is ``pylink``, which should be simple,
but **Everybody Lies**.

SR-Research *says* that pylink is included in their Linux packages, but it
isn't. Furthermore, while PsychoPy does support Eyelink Trackers (thanks to the
iohub merge), that support relies on pylink; thus pylink is still needed.
PsychoPy also mentions that they bundle pylink, but it turns out that's only for
standalone builds. Grumble...

So, long story short, that's why we need to install and setup pylink in such an
idiotic manner.

As mentioned above, the eyelink repo is ancient, and their EDF utility depends
on Java6, which has long since been dropped.

Rather than add sid and pin appropriately, I usually elect to just download the
needed packages and install them manually.

* `openjdk-6-jre`_
* `openjdk-6-jre-headless`_
* `openjdk-6-jre-lib`_

.. _openjdk-6-jre: http://debian.mirror.lrz.de/debian/pool/main/o/openjdk-6/openjdk-6-jre_6b35-1.13.7-1_amd64.deb
.. _openjdk-6-jre-headless: http://debian.mirror.lrz.de/debian/pool/main/o/openjdk-6/openjdk-6-jre-headless_6b35-1.13.7-1_amd64.deb
.. _openjdk-6-jre-lib: http://debian.mirror.lrz.de/debian/pool/main/o/openjdk-6/openjdk-6-jre-lib_6b35-1.13.7-1_all.deb

Now that the deps are satisfied, Install all of the eyelink stuff.

* ``apt-get install eyelink*``

Now it's time for pylink.

* download pylink4python2.7_linux_x64.tar.gz from the `SR Forums`_
* ``tar xvf pylink4python2.7_linux_x64.tar.gz``
* ``mv pylink4python2.7_linux_x64/pylink2.7 /usr/local/lib/python2.7/dist-packages/pylink``
* While not exactly kosher, this brute-force fix works for now. It fits right in
  with this mess.
  ``ln -s /usr/lib/x86_64-linux-gnu/libSDL_gfx.so /usr/lib/x86_64-linux-gnu/libSDL_gfx.so.13``

.. _SR Forums: https://www.sr-support.com/showthread.php?14-Pylink

Setup
-----

Eye Tracker
~~~~~~~~~~~

Communication with the eye tracker is done via a direct statically defined
Ethernet connection. For convenience, setup a network profile for DHCP and
another for talking with the eye tracker.

In the network panel of Gnome-Shell Settings, choose "wired" and add a profile
* One should be DHCP. Configure appropriately
* The other should be "Eyelink"

  * Address: 100.1.1.2
  * Netmask: 255.255.255.0
  * Gateway: 100.1.1.1

Monitors
~~~~~~~~

The screen supports 120 Hz, but 60 seems to be the default. It is easily set
using::

    xrandr --size 1920x1080 --rate 120

I tried *many* different ways of setting it permanently, and it turns out that
Gnome-Shell has an idiotic bug where it re-sets the refresh rate to 60 Hz (so no
.xinitrc, .nvidia-settings-rc, etc). So, the easiest way is to edit
``~/.config/monitors.xml`` and set the rate there.

Testing
-------

Get the eye tracker up and running, make you're connected via the network cable,
and activate the "Eyelink" network profile.

In an iPython shell, run

.. code-block:: python

  import pylink
  et = pylink.EyeLink("100.1.1.1")
  et.getTrackerVersionString()

If that works, everything is configured correctly.
