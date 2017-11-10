G24-K0??: Soundproof
********************

Pollmann lab

Hardware
========

* Eye tracking
* matrix
* cabin

Software
========


Contact Point
=============


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

Gnome-Shell
~~~~~~~~~~~

The upper-left Activities hot-corner needs to be disabled for mouse driven
experiments. To do so, install the `No Topleft Hot Corner`_ Gnome Extension.

.. _No Topleft Hot Corner: https://extensions.gnome.org/extension/118/no-topleft-hot-corner/
