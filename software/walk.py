#!/usr/bin/python3
import sys
import time
#pylint: disable=no-member
from pypot import dynamixel
motors = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18]
port = dynamixel.find_port(motors)
m = dynamixel.io.io.DxlIO(port, use_sync_read=False)
#print(m.get_angle_limit(motors))
#print(m.get_control_mode(motors))
#print(m.get_firmware(motors))
#print(m.get_present_temperature(motors))
print(m.get_present_speed(motors))

leg_motor_speed = [50, 50, 50]
leg_groups = [[1, 3, 5],[2, 4, 6]]

# define positions
leg_zero_pos = [0, -70, -70]
leg_up_pos = [None, -80, -50]
leg_down_pos = [None, -70, -70]
leg_forward_pos = [20, None, None]
leg_backward_pos = [-20, None, None]

def _define_motor_hash(legs, positions):
    """ legs: list of legs, position: list of 3 values  """
    hash = {}
    for leg in legs:
        for i in range(3):
            m = 3*(leg-1)+i + 1
            if positions[i] is not None:
                if m in [10, 13, 16] and i == 0:
                    hash[m] = -positions[i]
                else:
                    hash[m] = positions[i]
    return hash

leg_groups_speed = [_define_motor_hash(leg_groups[0], leg_motor_speed),
                    _define_motor_hash(leg_groups[1], leg_motor_speed)]
leg_groups_zero = [_define_motor_hash(leg_groups[0], leg_zero_pos),
                   _define_motor_hash(leg_groups[1], leg_zero_pos)]
leg_groups_up = [_define_motor_hash(leg_groups[0], leg_up_pos),
                   _define_motor_hash(leg_groups[1], leg_up_pos)]
leg_groups_down = [_define_motor_hash(leg_groups[0], leg_down_pos),
                   _define_motor_hash(leg_groups[1], leg_down_pos)]
leg_groups_forward = [_define_motor_hash(leg_groups[0], leg_forward_pos),
                   _define_motor_hash(leg_groups[1], leg_forward_pos)]
leg_groups_backward = [_define_motor_hash(leg_groups[0], leg_backward_pos),
                   _define_motor_hash(leg_groups[1], leg_backward_pos)]

m.set_moving_speed(leg_groups_speed[0])
m.set_moving_speed(leg_groups_speed[1])

m.set_goal_position(leg_groups_zero[0])
m.set_goal_position(leg_groups_zero[1])

print(leg_groups_speed)
print(m.get_moving_speed(motors))

def zero(delay=0.5):
    m.set_goal_position(leg_groups_zero[0])
    m.set_goal_position(leg_groups_zero[1])

def set_speed(speed=50):
    leg_groups_speed = [_define_motor_hash(leg_groups[0], [speed, speed, speed]),
                        _define_motor_hash(leg_groups[1], [speed, speed, speed])]
    m.set_moving_speed(leg_groups_speed[0])
    m.set_moving_speed(leg_groups_speed[1])
    
def walk(steps, delay=0.5, speed=50):
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
            
set_speed(100)
zero(0.1)
time.sleep(1)
walk(7, 0.1, speed=100)
zero(0.1)
