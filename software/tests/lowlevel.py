#!/usr/bin/python3
import pypot.dynamixel
ports = pypot.dynamixel.get_available_ports()

if not ports:
    raise IOError('no port found!')

print('ports found', ports)

print('connecting on the first available port:', ports[0])
dxl_io = pypot.dynamixel.DxlIO(ports[0])
#print(dxl_io.scan())
print(dxl_io.get_present_position((12, )))
dxl_io.set_goal_position({12: 30})
print(dxl_io.get_present_position((12, )))
