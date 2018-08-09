G24-K013: Soundproof
####################
:order: 540

This lab is operated by the Pollmann Lab.

For questions, problems, or scheduling, contact `Mikaella Sarrou`_.

.. _Mikaella Sarrou: https://lsf.ovgu.de/qislsf/rds?state=verpublish&status=init&vmfile=no&moduleCall=webInfo&publishConfFile=webInfoPerson&publishSubDir=personal&keep=y&purge=y&personal.pid=10651

Overview
********
The lab has one soundproof lab for eye tracking experiments. It is also equipped
with a KVM matrix, which allows for nearly complete flexibility over which
computer (EEG recorder, Eye Tracker, Presentation Machine, or researcher
supplied Laptop) displays to any screen — and routes both audio and USB.

Software
********
The Presentation Computer runs Debian Jessie (8) with Matlab (2012b), PsychoPy,
and Psychtoolbox installed. It has been configured to match the
timing/configuration requirements of both PsychoPy and Psychtoolbox.

Eye Tracker
***********
SR Research EyeLink 1000

.. class:: todo

  **TODO:** discuss camera speed, mount, etc

Communication with the eye tracker is done via the yellow Ethernet cable. The
Presentation computer is already setup. If you need to communicate using your
laptop, use the following settings to configure your NIC:

* Address: 100.1.1.2
* Netmask: 255.255.255.0
* Gateway: 100.1.1.1

Speakers
********
A portable, USB-rechargable, battery operated speaker is available.

KVM Matrix
**********
The Gefen EXT-DVIKVM-444DL KVM Matrix (`datasheet`_; `manual`_) is the key piece
that makes it possible to use all the computers, screens, USB peripherals, and
audio devices — in all the needed combinations. It is also a DVI amplifier,
enabling reliable signal for the longer cable runs into the EEG cabin.

The matrix can connect to 4 computers (1x DVI; 1x USB; 1x 3.5mm audio) and
4 control stations (1x screen; 1x keyboard; 1x speakers/headphones).

Any control station can connect to any computer — and even *multiple* control
stations can be connected to the same computer.

To demonstrate how this is useful, the following is a common experiment
workflow:

Eye Tracker is displayed inside the cabin:
  to run the calibration
Presentation Machine (or Researcher's Laptop) is displayed inside the cabin:
  to display the actual experiment

Each control station has a Perixx keyboard (Periboard 409) that has 2 additional
USB ports. One is used for a mouse; the other can be used by other USB response
devices (joystick, etc). These are all routed, via the Matrix, to the
appropriate computer.

.. _datasheet: http://resources.corebrands.com/products/EXT-DVIKVM-444DL/pdf_EXT-DVIKVM-444DL_Datasheet.pdf
.. _manual: http://resources.corebrands.com/products/EXT-DVIKVM-444DL/pdf_EXT-DVIKVM-444DL_Manual.pdf

Monitors
********
The colored dots on the monitors match the Gefen matrix remote.

Presentation Monitor (Green/Input #1)
  iiyama G-MASTER `GB2488HSU-B2`_

Eye Tracking Monitor (Brown/Input #2)
  Requires a 4:3 ratio monitor

In-Cabin Monitor (Red/Input #4)
  iiyama ProLite `GB2488HSU-B1`_

The In-Cabin Monitor is wall mounted with an adjustable arm and swivel. This
allows the monitor height and depth to be adjusted for experiments which
require different visual-fields.

A laser distance meter and level is available (on the shelf near the doorway) to
verify that the screen is positioned correctly.

.. class:: todo

  **TODO:** explain refresh rate vs resolution and matrix

.. _GB2488HSU-B1: https://iiyama.com/gb_en/products/prolite_gb2488hsu-b1/
.. _GB2488HSU-B2: https://iiyama.com/gl_en/products/g-master-gb2488hsu/460,g-master-gb2488hsu-b2.pdf

Peripherals
***********
The following peripherals are available:

* 8-button, USB `Cedrus RB-830`_ Response Pad
* 5-button, 25-pin serial Psychology Software Tools `200A Response Box`_
* 6-button, 25-pin serial Cedrus RB-600 Response Box

.. _Cedrus RB-830: https://www.cedrus.com/support/rbx30/
.. _200A Response Box: https://pstnet.com/products/serial-response-box/
