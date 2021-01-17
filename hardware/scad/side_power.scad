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
// side part with holes for switches and a 12V power supply plug
//
include <common.scad>;
include <sidepart.scad>;

difference(){
  union(){
    difference(){
      sidepart();
      // switches
      translate([10, -15, -9])cube([switch_x+0.2, 50, switch_z+0.2]);
      translate([1.7-(2*switch_x),-15,-9])cube([switch_x+0.2, 50, switch_z+0.2]);
      // power connector
      translate([-5, -15, -4])cube([9.2, 50, 11.2]);
      // add some text
      # translate([5, 7.5, 8])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("12V DC");
      #translate([20, 7.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Motors");
      #translate([-15, 7.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Pi");
    }
  }
  translate([0, 0, 2])cube([17, 10.1, 15], center=true);
}
// this we may be able to do better though ...
translate([0, -5, -12.4]){
  difference(){
    union(){
      cube([47, 10, 7], center=true);
      translate([0, 0, 5]){
        difference(){
          cube([20, 10, 4], center=true);
          cube([10, 10.1, 4.6], center=true);
        }
      }
    }
    translate([ 16, 0, -1])screwhole_mX(3);
    translate([-16, 0, -1])screwhole_mX(3);
    translate([ raster, 0, 2])nuthole_mX(2);
    translate([-raster, 0, 2])nuthole_mX(2);
  }
}
