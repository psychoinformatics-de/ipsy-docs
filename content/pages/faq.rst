Frequently Asked Questions
**************************

What About Backups?
-------------------
Backups are performed daily on Medusa.

For laptops and desktops, there is no centralized backup process. It is your
responsibility to come up with a solution that meets your needs.

As examples, some users...
* sync a folder to their account on medusa
* backup their machines to an external hard drive (i.e. Time Machine)
* sync with DropBox/Google Drive
* just don't have important data on their machines

How Can I Setup an Email Client?
--------------------------------
The URZ has `email instructions`_ available.

.. _email instructions: http://www.urz.ovgu.de/Unsere+Leistungen/Anwendungen/E_Mail/Konfiguration-p-714.html

How Can I VPN into OVGU's Network?
----------------------------------
The URZ has `VPN instructions`_ available.

On macOS, the built-in Cisco VPN is more convenient than the official Cisco
client that the URZ recommends.

  * Go to `System Preferences` -> `Network`
  * Click the `+` symbol in the lower-left corner

    - Interface: "VPN"
    - VPN Type: "Cisco IPSec"
    - Service Name: "OvGU VPN"
  * Back in the main network window

    - Server Address: "vpn.ovgu.de"
    - Account Name: <your ovgu account> (the same one to authenticate for email)
  * Click on `Authentication Settings`

    - Shared Secret: "vpn1"
    - Group Name: "vpn1"

You can also check `Show VPN status in menu bar` to make it more convenient to
connect and disconnect from VPN.

.. _VPN instructions: http://www.urz.ovgu.de/Unsere+Leistungen/Datennetz/Extern/VPN%40Home.html
