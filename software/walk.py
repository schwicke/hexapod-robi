#!/usr/bin/python3
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
""" PoC move primitives """
import time
#pylint: disable=no-member
from pypot import dynamixel

MOTORS = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
PORT = dynamixel.find_port(MOTORS)

m = dynamixel.io.io.DxlIO(PORT, use_sync_read=False)
#print(m.get_angle_limit(MOTORS))
#print(m.get_control_mode(MOTORS))
#print(m.get_firmware(MOTORS))
#print(m.get_present_temperature(MOTORS))
print(m.get_present_speed(MOTORS))

LEG_MOTOR_SPEED = [50, 50, 50]
LEG_GROUPS = [[1, 3, 5], [2, 4, 6]]

# define positions
LEG_ZERO_POS = [0, -70, -70]
LEG_UP_POS = [None, -80, -50]
LEG_DOWN_POS = [None, -70, -70]
LEG_FORWARD_POS = [10, None, None]
LEG_BACKWARD_POS = [-10, None, None]

def _define_motor_hash(legs, positions):
    """ legs: list of legs, position: list of 3 values  """
    mhash = {}
    for leg in legs:
        for i in range(3):
            motor = 3*(leg-1)+i + 1
            if positions[i] is not None:
                if motor in [10, 13, 16] and i == 0:
                    mhash[motor] = -positions[i]
                else:
                    mhash[motor] = positions[i]
    return mhash

leg_groups_speed = [_define_motor_hash(LEG_GROUPS[0], LEG_MOTOR_SPEED),
                    _define_motor_hash(LEG_GROUPS[1], LEG_MOTOR_SPEED)]
leg_groups_zero = [_define_motor_hash(LEG_GROUPS[0], LEG_ZERO_POS),
                   _define_motor_hash(LEG_GROUPS[1], LEG_ZERO_POS)]
leg_groups_up = [_define_motor_hash(LEG_GROUPS[0], LEG_UP_POS),
                 _define_motor_hash(LEG_GROUPS[1], LEG_UP_POS)]
leg_groups_down = [_define_motor_hash(LEG_GROUPS[0], LEG_DOWN_POS),
                   _define_motor_hash(LEG_GROUPS[1], LEG_DOWN_POS)]
leg_groups_forward = [_define_motor_hash(LEG_GROUPS[0], LEG_FORWARD_POS),
                      _define_motor_hash(LEG_GROUPS[1], LEG_FORWARD_POS)]
leg_groups_backward = [_define_motor_hash(LEG_GROUPS[0], LEG_BACKWARD_POS),
                       _define_motor_hash(LEG_GROUPS[1], LEG_BACKWARD_POS)]

m.set_moving_speed(leg_groups_speed[0])
m.set_moving_speed(leg_groups_speed[1])

m.set_goal_position(leg_groups_zero[0])
m.set_goal_position(leg_groups_zero[1])

print(leg_groups_speed)
print(m.get_moving_speed(MOTORS))

def zero(delay=0.5):
    """ set two groups of legs to zero position """
    m.set_goal_position(leg_groups_zero[0])
    m.set_goal_position(leg_groups_zero[1])

def set_speed(speed=50):
    """ set two groups of legs to zero position """
    leg_groups_speed = [_define_motor_hash(LEG_GROUPS[0], [speed, speed, speed]),
                        _define_motor_hash(LEG_GROUPS[1], [speed, speed, speed])]
    m.set_moving_speed(leg_groups_speed[0])
    m.set_moving_speed(leg_groups_speed[1])

def walk_forward(steps, delay=0.5, speed=50):
    """ walk forward """
    zero(delay)
    for i in range(steps):
        for group in range(2):
            m.set_goal_position(leg_groups_up[group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_backward[1-group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_forward[group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_down[group])
            time.sleep(delay)

def dance(steps, delay=0.5, speed=50):
    """ some dancing but do not move """
    zero(delay)
    for i in range(steps):
        for group in range(2):
            m.set_goal_position(leg_groups_up[group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_backward[group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_forward[group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_down[group])
            time.sleep(delay)

def walk_backward(steps, delay=0.5, speed=50):
    """ go backward by some steps """
    zero(delay)
    for i in range(steps):
        for group in range(2):
            m.set_goal_position(leg_groups_up[group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_forward[1-group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_backward[group])
            time.sleep(delay)
            m.set_goal_position(leg_groups_down[group])
            time.sleep(delay)

set_speed(50)
zero(0.1)
steps = 5
wait = 0.4
speed = 100
time.sleep(3)
walk_forward(steps, wait, speed)
dance(steps, wait, speed)
walk_backward(steps, wait, speed)
zero(0.1)
