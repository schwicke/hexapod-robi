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
// This is a little plastic bit which is intended to get the holes for the connectors
// at the right position. It's not part of the robot itself, but useful for building it.
//
include <../lib/globals.scad>
include <../lib/nuts_and_screws.scad>
include <../lib/sideparts.scad>

translate([0, 5, 0]){
  difference(){
    union(){
      translate([ screwdist_x/2, -1.5, -screwdist_y/2])rotate([90., 0., 0.])cylinder(h=3, d=4, center=true);
      translate([ screwdist_x/2, -1.5,  screwdist_y/2])rotate([90., 0., 0.])cylinder(h=3, d=4, center=true);
      translate([-screwdist_x/2, -1.5,  screwdist_y/2])rotate([90., 0., 0.])cylinder(h=3, d=4, center=true);
      translate([-screwdist_x/2, -1.5, -screwdist_y/2])rotate([90., 0., 0.])cylinder(h=3, d=4, center=true);
      difference(){
        sidepart();
        // HC SR04 sensor
        translate([halfdist, 0, 0]) rotate([90, 0, 0]) cylinder(h=50, d=diameter, center=true);
        translate([-halfdist, 0, 0]) rotate([90, 0, 0]) cylinder(h=50, d=diameter, center=true);
        translate([0, -7, 0])cube([xsize+0.1, 10, ysize+0.2], center=true);
      }
    }
    translate([ screwdist_x/2, 0,  screwdist_y/2])rotate([90., 0., 0.])nuthole_mX(2);
    translate([-screwdist_x/2, 0,  screwdist_y/2])rotate([90., 0., 0.])nuthole_mX(2);
    translate([ screwdist_x/2, 0, -screwdist_y/2])rotate([90., 0., 0.])nuthole_mX(2);
    translate([-screwdist_x/2, 0, -screwdist_y/2])rotate([90., 0., 0.])nuthole_mX(2);
  }
}

translate([0, -5, hight/2-thickness_top/2]){
     difference(){
          rotate([0, 180, 0]) cube([45, 10, thickness_top], center=true);
          translate([ 16, 0, 0]) nuthole_mX(3);
          translate([-16, 0, 0]) nuthole_mX(3);
          translate([0, -0, 10])cube([15, 15, 30], center=true);
     }
}

translate([0, -5, -hight/2+thickness_bottom/2]){
     difference(){
          cube([45, 10, thickness_bottom], center=true);
          translate([ 16, 0, 0]) my_screwhole_mX(3);
          translate([-16, 0, 0]) my_screwhole_mX(3);
     }
}
