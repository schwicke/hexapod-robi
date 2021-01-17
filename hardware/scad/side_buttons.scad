//
// This file is part of the hexapod-robi distribution (https://github.com/schwicke/hexapod-robi).
// Copyright (c) 2021 Ulrich Schwickerath
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, version 3.
//
// This program is distributed in the hope that it will be useful, but
// WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
// General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.
//
// side bit adding square holes for buttons (with lights). In the prototype these
// buttons are used to reset the Raspberrypi and the motors, respectively.
// (My kids love to reset the motors as this makes them compliant and the robot collaps ...)
//
include <common.scad>;
include <sidepart.scad>;

difference(){
  sidepart();
  // switches
  translate([12, 5, 0])rotate([90, 0, 0])cylinder(h=50, d=reset_d+0.2, center=true);
  translate([-12, 5, 0])rotate([90, 0, 0])cylinder(h=50, d=reset_d+0.2, center=true);
  translate([12, 12, 0])rotate([90, 0, 0])cube([18.1, 18.1, 18.1], center=true);
  translate([-12, 12, 0])rotate([90, 0, 0])cube([18.1, 18.1, 18.1], center=true);
  // add text
  #translate([5, 7.5, 10])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Controls");
  #translate([20, 7.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Reset Pi");
  #translate([-2, 7.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Reset Motors");
}
