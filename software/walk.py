#!/usr/bin/python3
""" sample script to make it walk """
#
# This file is part of the hexapod-robi distribution (https://github.com/schwicke/hexapod-robi).
# Copyright (c) 2021 Ulrich Schwickerath
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

import sys
import time
#pylint: disable=no-member
from pypot import dynamixel

ALL_MOTORS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
MOTOR = dynamixel.io.io.DxlIO(dynamixel.find_port(ALL_MOTORS), use_sync_read=False)

#print(m.get_angle_limit(MOTORS))
#print(m.get_control_mode(MOTORS))
#print(m.get_firmware(MOTORS))
#print(m.get_present_temperature(MOTORS))
print(MOTOR.get_present_speed(ALL_MOTORS))

LEG_MOTOR_SPEED = [50, 50, 50]
LEG_GROUPS = [[1, 3, 5], [2, 4, 6]]

# define positions
LEG_ZERO_POS = [0, 0, 0]
LEG_UP_POS = [None, 80, 80]
LEG_DOWN_POS = [None, 0, 0]
LEG_FORWARD_POS = [0, None, None]
LEG_BACKWARD_POS = [-30, None, None]
LEG_SIT_POS = [0, -55, 50]

def _define_motor_hash(legs, positions):
    """ legs: list of legs, position: list of 3 values  """
    res_hash = {}
    for leg in legs:
        for i in range(3):
            mindex = 3*(leg-1)+i + 1
            if positions[i] is not None:
                if mindex in [10, 13, 16] and i == 0:
                    res_hash[mindex] = -positions[i]
                else:
                    res_hash[mindex] = positions[i]
    return hash

LEG_GROUPS_SPEED = [_define_motor_hash(LEG_GROUPS[0], LEG_MOTOR_SPEED),
                    _define_motor_hash(LEG_GROUPS[1], LEG_MOTOR_SPEED)]
LEG_GROUPS_ZERO = [_define_motor_hash(LEG_GROUPS[0], LEG_ZERO_POS),
                   _define_motor_hash(LEG_GROUPS[1], LEG_ZERO_POS)]
LEG_GROUPS_UP = [_define_motor_hash(LEG_GROUPS[0], LEG_UP_POS),
                 _define_motor_hash(LEG_GROUPS[1], LEG_UP_POS)]
LEG_GROUPS_DOWN = [_define_motor_hash(LEG_GROUPS[0], LEG_DOWN_POS),
                   _define_motor_hash(LEG_GROUPS[1], LEG_DOWN_POS)]
LEG_GROUPS_FORWARD = [_define_motor_hash(LEG_GROUPS[0], LEG_FORWARD_POS),
                      _define_motor_hash(LEG_GROUPS[1], LEG_FORWARD_POS)]
LEG_GROUPS_BACKWARD = [_define_motor_hash(LEG_GROUPS[0], LEG_BACKWARD_POS),
                       _define_motor_hash(LEG_GROUPS[1], LEG_BACKWARD_POS)]
LEG_GROUPS_SIT = [_define_motor_hash(LEG_GROUPS[0], LEG_SIT_POS),
                  _define_motor_hash(LEG_GROUPS[1], LEG_SIT_POS)]

MOTOR.set_moving_SPEED(LEG_GROUPS_SPEED[0])
MOTOR.set_moving_SPEED(LEG_GROUPS_SPEED[1])

MOTOR.set_goal_position(LEG_GROUPS_ZERO[0])
MOTOR.set_goal_position(LEG_GROUPS_ZERO[1])

print(LEG_GROUPS_SPEED)
print(MOTOR.get_moving_SPEED(ALL_MOTORS))

def zero():
    """ set all MOTORS to zero """
    MOTOR.set_goal_position(LEG_GROUPS_ZERO[0])
    MOTOR.set_goal_position(LEG_GROUPS_ZERO[1])

def set_speed(speed=50):
    """ set the motor speed for all groups """
    leg_groups_speed = [_define_motor_hash(LEG_GROUPS[0], [speed, speed, speed]),
                        _define_motor_hash(LEG_GROUPS[1], [speed, speed, speed])]
    MOTOR.set_moving_speed(leg_groups_speed[0])
    MOTOR.set_moving_speed(leg_groups_speed[1])

def walk_forward(steps, delay=0.5, speed=50):
    """ walk forward by the defined number of steps """
    set_speed(speed)
    zero()
    for i in range(steps):
        print("Step forward number: %d", i)
        for group in range(2):
            MOTOR.set_goal_position(LEG_GROUPS_UP[group])
            time.sleep(delay)
            MOTOR.set_goal_position(LEG_GROUPS_BACKWARD[1-group])
            time.sleep(delay)
            MOTOR.set_goal_position(LEG_GROUPS_FORWARD[group])
            time.sleep(delay)
            MOTOR.set_goal_position(LEG_GROUPS_DOWN[group])
            time.sleep(delay)

def walk_backward(steps, delay=0.5, speed=50):#
    """ walk backward by the defined number of steps """
    set_speed(speed)
    zero()
    for i in range(steps):
        print("Step backward number: %d", i)
        for group in range(2):
            MOTOR.set_goal_position(LEG_GROUPS_UP[group])
            time.sleep(delay)
            MOTOR.set_goal_position(LEG_GROUPS_FORWARD[1-group])
            time.sleep(delay)
            MOTOR.set_goal_position(LEG_GROUPS_BACKWARD[group])
            time.sleep(delay)
            MOTOR.set_goal_position(LEG_GROUPS_DOWN[group])
            time.sleep(delay)

def main():
    """ main entry point """
    set_speed(80)
    zero()
    steps = 5
    wait = 0.15
    speed = 130
    time.sleep(1)
    walk_backward(steps, wait, speed)
    #walk_forward(steps,  wait, speed)
    set_speed(30)
    MOTOR.set_goal_position(LEG_GROUPS_SIT[1])
    MOTOR.set_goal_position(LEG_GROUPS_SIT[0])
    #zero()

if __name__ == '__main__':
    sys.exit(main())
