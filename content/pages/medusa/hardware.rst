Hardware
########
:order: 595

Summary
*******
As of February 2019, the cluster comprises 16 nodes with nearly 300 CPU cores
and 2.5 TiB of RAM. Centralized storage features more than 40 TiB of high
performance SSD and 11 TiB of HDD capacity, and is accessed by cluster nodes
via 10Gb Ethernet.

Head Node (Medusa)
******************
* 4x 8-core 2.8 GHz Opteron 6320
* 256 GiB RAM (16x 16GiB DDR3 ECC reg)
* 1x 10Gb NIC

Purchased 2013.12. Supermicro's specs: `A+ Server 2042G-TRF`_.

.. _A+ Server 2042G-TRF: http://www.supermicro.com/aplus/system/2u/2042/as-2042g-trf.cfm

Data Node (Zing)
****************
* 1x 8-core 3.2 GHz `Xeon E5-1660 v4`_
* 96 GiB RAM (6x 16GB DDR4 2133 ECC reg)
* 42 TiB SSD (~29.3 TiB usable) and ~26 TiB HDD (~10.5 TiB usable) storage
* 2x 10Gb bonded NICs

Purchased in 2016.12. Supermicro's specs: `SuperChassis 216BE1C-R920LPB`_ and `Mainboard X10SRL-F`_

.. _Xeon E5-1660 v4: https://ark.intel.com/products/92985/Intel-Xeon-Processor-E5-1660-v4-20M-Cache-3_20-GHz
.. _SuperChassis 216BE1C-R920LPB: http://www.supermicro.com/products/chassis/2U/216/SC216BE1C-R920LPB
.. _Mainboard X10SRL-F: http://www.supermicro.com/products/motherboard/Xeon/C600/X10SRL-F.cfm

Backup Node (Thunk)
*******************
The only server in this list that is not hosted in G01. It is instead across
campus in the G26 data center.

* 2x 6-core 2.4 GHz `Xeon E5645`_
* 96 GiB RAM (12x 8GB DDR3 ECC reg)
* 76.4 TiB HDD (52.1 TiB usable) storage
* 1x 1Gb NIC

Purchased 2011.12. Supermicro's specs: `SuperChassis 836E16-R1200B`_ and `Mainboard X8DTH-iF`_

.. _Xeon E5645: https://ark.intel.com/products/48768/Intel-Xeon-Processor-E5645-12M-Cache-2_40-GHz-5_86-GTs-Intel-QPI
.. _SuperChassis 836E16-R1200B: http://www.supermicro.com/products/chassis/3u/836/sc836e16-r1200.cfm
.. _Mainboard X8DTH-iF: http://www.supermicro.com/products/motherboard/qpi/5500/x8dth-if.cfm

snake1-6
********
* 2x 6-core 2.4 GHz `Xeon E5645`_
* 96 GiB RAM (12x 8 GiB DDR3 ECC reg)
* 1x 1Gb NIC

Purchased 2011.12. Supermicro's specs: `Twinserver 6016TT-TF`_

.. _Twinserver 6016TT-TF: http://www.supermicro.com/products/system/1u/6016/sys-6016tt-tf.cfm

snake7
******
* 4x 16-core 2.4 GHz Opteron 6272
* 256 GiB RAM (32x 8 GiB DDR3 ECC reg)
* 1x 1Gb NIC

Purchased 2012.06. Supermicro's specs: `H8QG6+-F Motherboard`_

.. _H8QG6+-F Motherboard: http://www.supermicro.com/Aplus/motherboard/Opteron6000/SR56x0/H8QG6_-F.cfm

snake8
******
* 1x 4-core 2.67 GHz `i7 920`_
* 18 GiB RAM
* 1x 1Gb NIC

Purchased 2010.03; formerly amras. Supermicro's specs: `RM21706 Chassis`_ and `X8STE Motherboard`_

.. _i7 920: https://ark.intel.com/products/37147/Intel-Core-i7-920-Processor-8M-Cache-2_66-GHz-4_80-GTs-Intel-QPI
.. _RM21706 Chassis: http://www.chenbro.com/en-global/products/RackmountChassis/2U_Chassis/RM21706
.. _X8STE Motherboard: http://www.supermicro.com/products/motherboard/xeon3000/x58/x8ste.cfm

snake9
******
* 1x 8-core 2.0 GHz Opteron 6128
* 64 GiB RAM (8x 8GiB DDR3 ECC Reg)
* 1x 1Gb NIC

Purchased 2010 (estimated); formerly "just laying about" in Toemme's lab. Supermicro's specs: `H8DGU-F Motherboard`_

.. _H8DGU-F Motherboard: http://www.supermicro.com/aplus/motherboard/opteron6100/sr56x0/h8dgu-f.cfm

snake10
*******
* 4x 8-core 2.8 GHz Opteron 6320
* 512 GiB RAM (32x 16GiB DDR3 ECC Reg)
* 1x 1Gb NIC

Purchased 2013.12. Supermicro's specs: `A+ Server 1042G-TF`_

.. _A+ Server 1042G-TF: http://www.supermicro.com/aplus/system/1u/1042/as-1042g-tf.cfm

snake11
*******
* 2x 10-core 2.3 GHz Intel `Xeon E5-2650v3`_
* 96 GiB RAM (6x 16GiB DDR4 ECC Reg)
* 1.2 TB NVMe mounted at /tmp
* 1x 10Gb NIC

Purchased 2015.12. Supermicro's specs: `825TQ-R740LPB Chassis`_ and `X10DRi-T Motherboard`_

.. _Xeon E5-2650v3: https://ark.intel.com/products/81705/Intel-Xeon-Processor-E5-2650-v3-25M-Cache-2_30-GHz
.. _825TQ-R740LPB Chassis: http://www.supermicro.com/products/chassis/2u/825/sc825tq-r740lp.cfm
.. _X10DRi-T Motherboard: http://www.supermicro.com/products/motherboard/xeon/c600/x10dri-t.cfm

snake12
*******
* 4x 8-core 2.6 GHz Opteron 6212
* 512 GiB RAM (32x 16GB DDR3 ECC reg)
* 1x 1Gb NIC

Purchased 2012.12; formerly mudflap. Supermicro's specs: `A+ Server 1042G-TF`_ and `SuperChassis 826E16-R1200LPB`_

.. _A+ Server 1042G-TF: http://www.supermicro.com/aplus/system/1u/1042/as-1042g-tf.cfm
.. _SuperChassis 826E16-R1200LPB: http://www.supermicro.com/products/chassis/2u/826/sc826e16-r1200lp.cfm

Mulder
******
.. class:: todo

  **TODO:** Add Mulder's specs

Networking
**********
An `SG-8860`_ running OpenBSD acts as the router/firewall/etc for the cluster.
All cluster traffic uses one 1Gb connection. All web services use a separate 1Gb
connection. Internally, the data network is 10Gb (though not all hosts have 10Gb
cards). Both the management and DMZ networks are physically separate.

.. _SG-8860: https://store.netgate.com/pfSense/SG-88601U.aspx

Power
*****
We have one zero-U 3-phase PDU (`Raritan PX2-2730`_). It is connected to a red
`IEC_60309`_ power plug. For specifics on which machine is plugged into which
PDU outlet, consult the `rack diagram </medusa/data_center/>`_.

.. _Raritan PX2-2730: http://www.raritan.com/product-selector/pdu-detail/px2-2730
.. _IEC_60309: https://en.wikipedia.org/wiki/IEC_60309

As we have limited battery capacity, only critical equipment is protected by
the UPSs. Both UPSs are monitored by ``zing`` via ``NUT``; the head node
and ``zing`` poll this information; if the main UPS (Eaton) reaches **low
battery**, both Medusa and Zing will shutdown immediately.

* `APC Smart-UPS SC 1000`_

  - age: ~2009
  - protects router and switches

* `Eaton 5PX 2200`_

  - age: 2012.12
  - protects Medusa and Zing

.. _APC Smart-UPS SC 1000: http://www.apc.com/shop/de/de/products/APC-Smart-UPS-SC-1000-VA-230-V-2-U-rackmontiert-Tower/P-SC1000I
.. _Eaton 5PX 2200: http://powerquality.eaton.de/5PX2200iRTN.aspx
