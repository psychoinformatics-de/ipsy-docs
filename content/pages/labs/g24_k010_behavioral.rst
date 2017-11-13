G24-K010: Behavioral
********************

Shared among IPSY.

Hardware
========

* 3 Linux machines
* 2 Windows machines

Linux
=====

PsychToolbox is currently dominant, but there has been an increased trend
towards using PsychoPy.

Install Debian Jessie with a typical base install.
  * non-free enabled
  * no backports
  * Gnome Desktop environment

``aptitude show ipsy-behavioral-lab`` is best way to determine what is
installed, but as a quick overview:

* Matlab and Octave
* Psychtoolbox
* PsychoPy

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

Presentation is the tool of choice for Windows systems. Download, install, and
activate from their website. Usually the latest version is what's wanted, but
it's good to check with those who will be using it.

Matlab and PsychToolbox are sometimes needed as well.
