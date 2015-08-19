.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

****************
Behavioral Setup
****************

This is the standard configuration for behavioral computers in IPSY. It's
divided into three sections: hardware, Linux, and Windows.

Hardware
========

We tend to prefer Intel CPUs around an i3 or i5. While few tasks are CPU
intensive, some are. And Intel is reliable and performant.

RAM is usually around 8GB to give us extra head-room in case it's needed.

GPUs are either Intel, due to the excellent GPU support on Linux, or nVidia
with >= 2GB of VRAM for when the tasks are GPU intensive.

The systems are often Lenovo. They still have decent warranties and tend to
have sane hardware with sane Linux support.

Linux
=====

PsychToolbox is currently dominant, but there has been an increased trend
towards using PsychoPy.

Install Debian Jessie with a typical base install.
  * non-free enabled
  * no backports
  * Gnome Desktop environment

Repositories
------------

I added the following repositories:

* kumo

  * deb http://kumo.ovgu.de/debian jessie main
  * deb-src http://kumo.ovgu.de/debian jessier main
* NeuroDebian

  * deb http://neurodebian.ovgu.de/debian jessie main contrib non-free
  * deb-src http://neurodebian.ovgu.de/debian jessie main contrib non-free
  * deb http://neurodebian.ovgu.de/debian jessie main contrib non-free
  * deb-src http://neurodebian.ovgu.de/debian jessie main contrib non-free

Install
-------

It's as simple as installing ``ipsy-behavioral-lab``. That will pull in all
needed dependencies.

``aptitude show ipsy-behavioral-lab`` is best way to determine what is
installed, but as a quick overview:

* Matlab and Octave
* Psychtoolbox (for both Matlab and Octave)
* PsychoPy
* ipsy-common (to bring in a lot of basic, nice utilities)

Also, if there's an nVidia card, follow `Debian's nVidia directions`_.

.. _Debian's nVidia directions: https://wiki.debian.org/NvidiaGraphicsDrivers#Debian_8_.22Jessie.22

Setup
-----

Most things are setup automatically. For the rest:

* PsychToolbox

  * Add ``/usr/share/psychtoolbox`` to the matlab path
  * Run PsychLinuxConfiguration

* PsychoPy

  * Until the package gets fixed, to get the demos to work (the iohub ones at
    least), you must make the folder writeable: ``chmod -R o+w
    /usr/lib/python2.7/dist-packages/psychopy/demos/coder/iohub/``
* Matlab

  * If Matlab is to be used without network access, then a stand-alone license
    is needed.

Testing
-------

* PsychToolbox

  * ScreenTest
  * CheckFrameTiming
  * VBLSyncTest
  * PerceptualVBLSyncTest
* Psychopy

  * benchmark (at Psychopy startup)

Windows
=======

I won't do a full write-up on Windows now. But here are some quick points:

Install
-------

A typical Windows 7 base install. We don't have any experience with Windows 8 or
newer yet.

Presentation is the tool of choice for Windows systems. Download, install, and
activate from their website. Usually the latest version is what's wanted, but
it's good to check with those who will be using it.

Matlab and PsychToolbox are sometimes needed as well.

Setup
-----

On behavioral system, timing is less of a hyper-concern. Removing unneeded
packages and services is a good thing. But stripping down the services (which
are disconcertingly interwoven) to the point of nearly breaking the system
isn't needed, and can be reserved for EEG setups, etc.

Use your best judgement.

