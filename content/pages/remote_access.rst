***********************************
Accessing the OvGU Network Remotely
***********************************

Most of the time, there is no need for any fancy network setup. But sometimes,
users must be part of OvGU's network in order to access resources. Licensing
servers (Matlab, SPSS, etc) and journal access are the most common reasons.

VPN
===

VPN makes you a member of the OvGU network, and your computer will receive an
OvGU IP address. However, a few networks (usually mobile) specifically block VPN
traffic and offer/extort to "allow" VPN traffic via an upgrade in service/cost.

Windows and Linux
-----------------
OvGU has `VPN instructions`_ available.

OS X
----
OS X has built-in support for Cisco VPN, and it behaves far better than the
official Cisco client that the URZ recommends.

To setup VPN on OS X:

  * Go to `System Preferences` -> `Network`
  * Click the `+` symbol in the lower-left corner

    - Interface: "VPN"
    - VPN Type: "Cisco IPSec"
    - Service Name: "OvGU VPN" (or whatever you want to name it)
  * Back in the main network window

    - Server Address: "vpn.ovgu.de"
    - Account Name: <your ovgu account> (the same one to authenticate for email)
  * Click on `Authentication Settings`

    - Shared Secret: "vpn1"
    - Group Name: "vpn1"

You can also check `Show VPN status in menu bar` to make it more convenient to
connect and disconnect from VPN.

.. _VPN instructions: http://www.urz.ovgu.de/Unsere+Leistungen/Datennetz/Extern/VPN%40Home.html

SSH Tunneling
=============

This method is more flexible, but that also makes it more complex. While VPN
makes your computer a member of the OvGU network, this method specifically
forwards selected ports through medusa (which is on the OvGU network); thus
making it possible to access specific OvGU services.

.. note: This is untested, but should work
