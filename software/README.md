# Software
The software found in this repository is at a PoC level.
## Sensors
This directory contains a library and some tests to read out the robots sensors

## Python
In this folder, you can find some basic Python scripts for motor control
### scan.py
This tool simply scans the bus and returns the ids of the motors it found. There should be 3x6 so 18 of them.
### zero_position.py
This tool simply sets all motors to their zero position. In effect, the robot will stand up.
### walk.py
The walk.py script is a bit more complex. It implements some logic which allows the robot to move a few steps forward and backward.
