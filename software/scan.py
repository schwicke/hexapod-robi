#!/usr/bin/python3
import pypot.dynamixel
devices = (pypot.dynamixel.get_available_ports())

for device in devices:
    print("Scanning device %s" % device)
    dxl_io = pypot.dynamixel.DxlIO(device)
    try:
        scan = dxl_io.scan()
        print("ids: %s" % str(scan))
    except Exception as error:
        print("Got an errory while scanning %s" % str(device))
