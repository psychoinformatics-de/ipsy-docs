.. -*- mode: rst; fill-column: 79 -*-
.. ex: set sts=4 ts=4 sw=4 et tw=79:

**************
Hardware setup
**************

Master node
===========

* Supermicro Chassis SC836E16-R1200B

  - High Performance SAS2/6GbS Expander
  - High Efficiency PS and Storage Capacity
  - 1200W high-efficiency (1+1) redundant power supply (Gold Level 93%)
  - 16x 3.5" Hot-swappable SAS / SATA Drive Bays
  - 6Gb/s SAS2 Expander
  - 3x 8cm Hot-swap 4-pin PWM Fans
  - 2x 8cm Rear-exhaust 4-pin PWM Fans

* Supermicro Mainboard X8DTH-iF

  - Intel® Xeon® processor 5600/5500 series, with QPI up to 6.4 GT/s
  - Dual Intel® 5520 (Tylersburg) Chipsets
  - Up to 192GB DDR3 1333/ 1066/ 800MHz ECC Registered DIMM / 48GB Unbuffered DIMM
  - Intel® 82576 Dual-Port Gigabit Ethernet Controller
  - 6x SATA2 (3 Gbps) Ports via ICH10R Controller
  - 7 (x8) PCI-E 2.0 ( in x16 slot)
  - Integrated Matrox G200eW Graphics
  - Integrated IPMI 2.0 with Dedicated LAN

* 2 x Intel Xeon E5645 six-core 2,40GHz

* 12 x 8GB DDR3 ECC reg. (Markenmodule)

* 10 x 2TB SATA2 Festplatte Raid Edition (24x7)

* 2 x 500GB SATA2 Festplatte Raid Edition (24x7)

* LSI Raidcontroller 9260-4i Raidlevel 0, 1, 5, 6, 10, 50 and 60

* Intel Gigabit Serveradapter 10/100/1000

cat /proc/cpuinfo | head -n25::

   processor       : 0
   vendor_id       : GenuineIntel
   cpu family      : 6
   model           : 44
   model name      : Intel(R) Xeon(R) CPU           E5645  @ 2.40GHz
   stepping        : 2
   cpu MHz         : 2399.735
   cache size      : 12288 KB
   physical id     : 0
   siblings        : 12
   core id         : 0
   cpu cores       : 6
   apicid          : 0
   initial apicid  : 0
   fpu             : yes
   fpu_exception   : yes
   cpuid level     : 11
   wp              : yes
   flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt lahf_lm ida arat tpr_shadow vnmi flexpriority ept vpid
   bogomips        : 4799.47
   clflush size    : 64
   cache_alignment : 64
   address sizes   : 40 bits physical, 48 bits virtual
   power management:

free -t -g::

                total       used       free     shared    buffers     cached
   Mem:            94         63         31          0          0         58
   -/+ buffers/cache:          4         90
   Swap:           22          0         22
   Total:         117         63         54


lspci::

   00:00.0 Host bridge: Intel Corporation 5520 I/O Hub to ESI Port (rev 22)
   00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 22)
   00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 3 (rev 22)
   00:05.0 PCI bridge: Intel Corporation 5520/X58 I/O Hub PCI Express Root Port 5 (rev 22)
   00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 22)
   00:0d.0 Host bridge: Intel Corporation Device 343a (rev 22)
   00:0d.1 Host bridge: Intel Corporation Device 343b (rev 22)
   00:0d.2 Host bridge: Intel Corporation Device 343c (rev 22)
   00:0d.3 Host bridge: Intel Corporation Device 343d (rev 22)
   00:0d.4 Host bridge: Intel Corporation 5520/5500/X58 Physical Layer Port 0 (rev 22)
   00:0d.5 Host bridge: Intel Corporation 5520/5500 Physical Layer Port 1 (rev 22)
   00:0d.6 Host bridge: Intel Corporation Device 341a (rev 22)
   00:0e.0 Host bridge: Intel Corporation Device 341c (rev 22)
   00:0e.1 Host bridge: Intel Corporation Device 341d (rev 22)
   00:0e.2 Host bridge: Intel Corporation Device 341e (rev 22)
   00:0e.4 Host bridge: Intel Corporation Device 3439 (rev 22)
   00:13.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub I/OxAPIC Interrupt Controller (rev 22)
   00:14.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub System Management Registers (rev 22)
   00:14.1 PIC: Intel Corporation 5520/5500/X58 I/O Hub GPIO and Scratch Pad Registers (rev 22)
   00:14.2 PIC: Intel Corporation 5520/5500/X58 I/O Hub Control Status and RAS Registers (rev 22)
   00:14.3 PIC: Intel Corporation 5520/5500/X58 I/O Hub Throttle Registers (rev 22)
   00:16.0 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.3 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.4 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.5 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.6 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.7 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:1a.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4
   00:1a.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5
   00:1a.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6
   00:1a.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2
   00:1c.0 PCI bridge: Intel Corporation 82801JI (ICH10 Family) PCI Express Root Port 1
   00:1d.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1
   00:1d.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2
   00:1d.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3
   00:1d.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1
   00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
   00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller
   00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port SATA IDE Controller #1
   00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
   00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port SATA IDE Controller #2
   01:03.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200eW WPCM450 (rev 0a)
   02:00.0 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
   02:00.1 Ethernet controller: Intel Corporation 82575EB Gigabit Network Connection (rev 02)
   04:00.0 RAID bus controller: LSI Logic / Symbios Logic LSI MegaSAS 9260 (rev 05)
   06:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
   06:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)


sudo ifconfig -a::

   bond0     Link encap:Ethernet  HWaddr 00:25:90:2b:8f:48  
             inet addr:10.0.0.254  Bcast:10.0.0.255  Mask:255.255.255.0
             inet6 addr: fe80::225:90ff:fe2b:8f48/64 Scope:Link
             UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metric:1
             RX packets:81170310 errors:0 dropped:0 overruns:0 frame:0
             TX packets:59090567 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:0 
             RX bytes:108979461861 (101.4 GiB)  TX bytes:78321228812 (72.9 GiB)

   eth0      Link encap:Ethernet  HWaddr 00:25:90:2b:8f:48  
             UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
             RX packets:39082933 errors:0 dropped:0 overruns:0 frame:0
             TX packets:28988362 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:1000 
             RX bytes:52116174454 (48.5 GiB)  TX bytes:37994573648 (35.3 GiB)
             Memory:fafe0000-fb000000 

   eth1      Link encap:Ethernet  HWaddr 00:25:90:2b:8f:48  
             UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
             RX packets:42087377 errors:0 dropped:0 overruns:0 frame:0
             TX packets:30102205 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:1000 
             RX bytes:56863287407 (52.9 GiB)  TX bytes:40326655164 (37.5 GiB)
             Memory:faf60000-faf80000 

   eth2      Link encap:Ethernet  HWaddr 00:25:90:62:4a:6a  
             inet addr:10.0.1.254  Bcast:10.0.1.255  Mask:255.255.255.0
             inet6 addr: fe80::225:90ff:fe62:4a6a/64 Scope:Link
             UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
             RX packets:26819 errors:0 dropped:0 overruns:0 frame:0
             TX packets:27309 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:1000 
             RX bytes:4018261 (3.8 MiB)  TX bytes:2563302 (2.4 MiB)
             Memory:fa9e0000-faa00000 

   eth3      Link encap:Ethernet  HWaddr 00:25:90:62:4a:6b  
             inet addr:141.44.17.54  Bcast:141.44.17.255  Mask:255.255.255.0
             inet6 addr: fe80::225:90ff:fe62:4a6b/64 Scope:Link
             UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
             RX packets:37706781 errors:2 dropped:0 overruns:0 frame:1
             TX packets:16141281 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:1000 
             RX bytes:53594271026 (49.9 GiB)  TX bytes:1676533556 (1.5 GiB)
             Memory:fa3e0000-fa400000 

   lo        Link encap:Local Loopback  
             inet addr:127.0.0.1  Mask:255.0.0.0
             inet6 addr: ::1/128 Scope:Host
             UP LOOPBACK RUNNING  MTU:16436  Metric:1
             RX packets:34324154 errors:0 dropped:0 overruns:0 frame:0
             TX packets:34324154 errors:0 dropped:0 overruns:0 carrier:0
             collisions:0 txqueuelen:0 
             RX bytes:14901888498 (13.8 GiB)  TX bytes:14901888498 (13.8 GiB)



Compute node
============

* Supermicro Twinserver 6016TT-TF (incl. Rack-Rails)

  - Intel® Xeon® processor 5600/5500 series, with QPI up to 6.4 GT/s
  - Up to 192GB** DDR3 1333/ 1066/ 800MHz ECC Registered DIMM / 48GB Unbuffered DIMM
  - 1 (x16) PCI-E ( Low Profile)
  - Integrated IPMI 2.0 with KVM and Dedicated LAN
  - Intel® 82576 Dual-Port Gigabit Ethernet Controller
  - 2x Hot-swap SATA Drive Bays
  - 1200W Gold-level High-efficiency Power Supply

* Per each of the six twin-halves

  - 2 x Intel Xeon E5645 six-core 2,40GHz
  - 12 x 8GB DDR3 ECC reg.
  - 1 x 500GB SATA2 Festplatte Raid Edition (24x7)


cat /proc/cpuinfo | head -n24::

   processor       : 0
   vendor_id       : GenuineIntel
   cpu family      : 6
   model           : 44
   model name      : Intel(R) Xeon(R) CPU           E5645  @ 2.40GHz
   stepping        : 2
   cpu MHz         : 2399.608
   cache size      : 12288 KB
   physical id     : 0
   siblings        : 12
   core id         : 0
   cpu cores       : 6
   apicid          : 0
   initial apicid  : 0
   fpu             : yes
   fpu_exception   : yes
   cpuid level     : 11
   wp              : yes
   flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt lahf_lm ida arat tpr_shadow vnmi flexpriority ept vpid
   bogomips        : 4799.21
   clflush size    : 64
   cache_alignment : 64
   address sizes   : 40 bits physical, 48 bits virtual
   power management:

free -g -t::

                total       used       free     shared    buffers     cached
   Mem:            94         19         75          0          0         18
   -/+ buffers/cache:          0         94
   Swap:           23          0         23
   Total:         118         19         99

lspci::

   00:00.0 Host bridge: Intel Corporation 5500 I/O Hub to ESI Port (rev 22)
   00:01.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 1 (rev 22)
   00:03.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 3 (rev 22)
   00:07.0 PCI bridge: Intel Corporation 5520/5500/X58 I/O Hub PCI Express Root Port 7 (rev 22)
   00:13.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub I/OxAPIC Interrupt Controller (rev 22)
   00:14.0 PIC: Intel Corporation 5520/5500/X58 I/O Hub System Management Registers (rev 22)
   00:14.1 PIC: Intel Corporation 5520/5500/X58 I/O Hub GPIO and Scratch Pad Registers (rev 22)
   00:14.2 PIC: Intel Corporation 5520/5500/X58 I/O Hub Control Status and RAS Registers (rev 22)
   00:14.3 PIC: Intel Corporation 5520/5500/X58 I/O Hub Throttle Registers (rev 22)
   00:16.0 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.1 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.2 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.3 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.4 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.5 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.6 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:16.7 System peripheral: Intel Corporation 5520/5500/X58 Chipset QuickData Technology Device (rev 22)
   00:1a.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #4
   00:1a.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #5
   00:1a.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #6
   00:1a.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #2
   00:1d.0 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #1
   00:1d.1 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #2
   00:1d.2 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB UHCI Controller #3
   00:1d.7 USB Controller: Intel Corporation 82801JI (ICH10 Family) USB2 EHCI Controller #1
   00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev 90)
   00:1f.0 ISA bridge: Intel Corporation 82801JIR (ICH10R) LPC Interface Controller
   00:1f.2 IDE interface: Intel Corporation 82801JI (ICH10 Family) 4 port SATA IDE Controller #1
   00:1f.3 SMBus: Intel Corporation 82801JI (ICH10 Family) SMBus Controller
   00:1f.5 IDE interface: Intel Corporation 82801JI (ICH10 Family) 2 port SATA IDE Controller #2
   01:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
   01:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)
   04:01.0 VGA compatible controller: Matrox Graphics, Inc. MGA G200eW WPCM450 (rev 0a)

ifconfig -a::

   bond0     Link encap:Ethernet  Hardware Adresse 00:25:90:49:60:0a  
             inet Adresse:10.0.0.1  Bcast:10.0.0.255  Maske:255.255.255.0
             inet6-Adresse: fe80::225:90ff:fe49:600a/64 Gültigkeitsbereich:Verbindung
             UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metrik:1
             RX packets:11443122 errors:0 dropped:0 overruns:0 frame:0
             TX packets:17601420 errors:0 dropped:0 overruns:0 carrier:0
             Kollisionen:0 Sendewarteschlangenlänge:0 
             RX bytes:11995686766 (11.1 GiB)  TX bytes:24995208187 (23.2 GiB)

   eth0      Link encap:Ethernet  Hardware Adresse 00:25:90:49:60:0a  
             UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metrik:1
             RX packets:912252 errors:0 dropped:0 overruns:0 frame:0
             TX packets:13011379 errors:0 dropped:0 overruns:0 carrier:0
             Kollisionen:0 Sendewarteschlangenlänge:1000 
             RX bytes:102265279 (97.5 MiB)  TX bytes:18587843837 (17.3 GiB)
             Speicher:fbd60000-fbd80000 

   eth1      Link encap:Ethernet  Hardware Adresse 00:25:90:49:60:0a  
             UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metrik:1
             RX packets:10530870 errors:0 dropped:0 overruns:0 frame:0
             TX packets:4590041 errors:0 dropped:0 overruns:0 carrier:0
             Kollisionen:0 Sendewarteschlangenlänge:1000 
             RX bytes:11893421487 (11.0 GiB)  TX bytes:6407364350 (5.9 GiB)
             Speicher:fbde0000-fbe00000 

   lo        Link encap:Lokale Schleife  
             inet Adresse:127.0.0.1  Maske:255.0.0.0
             inet6-Adresse: ::1/128 Gültigkeitsbereich:Maschine
             UP LOOPBACK RUNNING  MTU:16436  Metrik:1
             RX packets:3709 errors:0 dropped:0 overruns:0 frame:0
             TX packets:3709 errors:0 dropped:0 overruns:0 carrier:0
             Kollisionen:0 Sendewarteschlangenlänge:0 
             RX bytes:1077983 (1.0 MiB)  TX bytes:1077983 (1.0 MiB)

Network
=======

* 19“ 1HE Switch HP V1910-48G

  - 48 x 10/100/1000 Ports
  - with link-aggregation setup for bonded GBit ethernet between master and
    compute nodes

* 19“ 1HE Switch HP1700-24

  - 24 x 10/100 Ports
  - for management LAN/IPMI


Stress test
===========

CPU
---

After an initial setup I ran a stress test using a cluster-wide searchlight
analysis. That means 24 Python processes running at 100% load per machine, on
each of the 6 compute nodes. After a cluster-wide average machine load of 24 for
15 minutes the CPU temperature did not get to 35C on any node. No change of the
picture at the 30 min mark.
