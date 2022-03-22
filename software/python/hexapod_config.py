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

spider_config = {
    "controllers": {
        "u2d2_1":{
            'port': '/dev/ttyUSB0',
            'sync_read': False,
            'attached_motors': ['leg1', 'leg2', 'leg3', 'leg4', 'leg5', 'leg6'],
            'protocol': 1
        }
    },
    "motors": {
        "motor_1": {
            "id": 1,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_2": {
            "id": 2,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_3": {
            "id": 3,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_4": {
            "id": 4,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_5": {
            "id": 5,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_6": {
            "id": 6,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_7": {
            "id": 7,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_8": {
            "id": 8,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_9": {
            "id": 9,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_10": {
            "id": 10,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_11": {
            "id": 11,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_12": {
            "id": 12,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_13": {
            "id": 13,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_14": {
            "id": 14,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_15": {
            "id": 15,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_16": {
            "id": 16,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_17": {
            "id": 17,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        },
        "motor_18": {
            "id": 18,
            "type": "AX-12",
            "offset": 0.0,
            "orientation": "direct",
            "angle_limit": [
                -150,
                150
            ]
        }
    },
    "motorgroups": {
        'leg1': ['motor_1', 'motor_2', 'motor_3'],
        'leg2': ['motor_4', 'motor_5', 'motor_6'],
        'leg3': ['motor_7', 'motor_8', 'motor_9'],
        'leg4': ['motor_10', 'motor_11', 'motor_12'],
        'leg5': ['motor_13', 'motor_14', 'motor_15'],
        'leg6': ['motor_16', 'motor_17', 'motor_18']
    }
}
