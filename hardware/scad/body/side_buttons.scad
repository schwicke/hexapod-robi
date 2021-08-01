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
          sidepart();
          // switches
          translate([12, 0, 0]) rotate([90, 0, 0]) cylinder(h=50, d=reset_d+0.2, center=true);
          translate([-12, 0, 0]) rotate([90, 0, 0]) cylinder(h=50, d=reset_d+0.2, center=true);
          translate([12, 7, 0]) rotate([90, 0, 0]) cube([18.1, 18.1, 18.1], center=true);
          translate([-12, 7, 0]) rotate([90, 0, 0]) cube([18.1, 18.1, 18.1], center=true);
     }
}

translate([0, -5, hight/2-thickness_top/2]){
     difference(){
          rotate([0, 180, 0]) cube([45, 10, thickness_top], center=true);
          translate([ 0, 0, 0]) nuthole_mX(3);
          translate([ 16, 0, 0]) nuthole_mX(3);
          translate([-16, 0, 0]) nuthole_mX(3);
     }
}

translate([0, -5, -hight/2+thickness_bottom/2]){
     difference(){
          cube([45, 10, thickness_bottom], center=true);
          translate([ 16, 0, 0]) my_screwhole_mX(3);
          translate([-16, 0, 0]) my_screwhole_mX(3);
     }
}
