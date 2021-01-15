#!/usr/bin/python3
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
