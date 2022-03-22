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

#pylint: disable=no-member
"""PoC: stand up and relax again"""
import time
from contextlib import closing
import pypot.robot
from hexapod_config import spider_config

with closing(pypot.robot.from_config(spider_config)) as robot:
    print("init done. Programming zero")
    for m in robot.leg1:
        m.compliant = False
        m.goto_position(0.0, 2.0, wait=False)
    for m in robot.leg2:
        m.compliant = False
        m.goto_position(0.0, 2.0, wait=False)
    for m in robot.leg3:
        m.compliant = False
        m.goto_position(0.0, 2.0, wait=False)
    for m in robot.leg4:
        m.compliant = False
        m.goto_position(0.0, 2.0, wait=False)
    for m in robot.leg5:
        m.compliant = False
        m.goto_position(0.0, 2.0, wait=False)
    for m in robot.leg6:
        m.compliant = False
        m.goto_position(0.0, 2.0, wait=True)
    print("zero done")
    time.sleep(60)
    print("Making compliant")
    for m in robot.leg1:
        m.compliant = True
    for m in robot.leg2:
        m.compliant = True
    for m in robot.leg3:
        m.compliant = True
    for m in robot.leg4:
        m.compliant = True
    for m in robot.leg5:
        m.compliant = True
    for m in robot.leg6:
        m.compliant = True
print("Done")
