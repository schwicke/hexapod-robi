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
               difference(){
                    sidepart();
                    // switches
                    translate([10, -20, -9])cube([switch_x+0.4, 50, switch_z+0.5]);
                    translate([1.7-(2*switch_x),-20,-9])cube([switch_x+0.4, 50, switch_z+0.5]);
                    translate([-switch_x/2,-20,-9])cube([switch_x+0.4, 50, switch_z+0.5]);
               }
          }
     }
}

translate([0, -5, hight/2-thickness_top/2]){
     difference(){
          rotate([0, 180, 0]) cube([47, 10, thickness_top], center=true);
          //translate([ 0, 0, 0])nuthole_mX(3);
          translate([  0, 0, 0]) nuthole_mX(3);
          translate([ 16, 0, 0]) nuthole_mX(3);
          translate([-16, 0, 0]) nuthole_mX(3);
          translate([ 3*raster, 0, 5]) my_screwhole_mX(3);
          translate([-3*raster, 0, 5]) my_screwhole_mX(3);
     }
}

translate([0, -5, -hight/2+thickness_bottom/2]){
     difference(){
          union(){
               cube([47, 10, thickness_bottom], center=true);
               translate([0, 0, 5]){
                    difference(){
                         cube([20, 10, 4], center=true);
                         cube([10, 10.1, 4.6], center=true);
                    }
               }
          }
          translate([  0, 0, 0])rotate([ 180.0 ,0.0 ,0.0 ])nuthole_mX(3);
          translate([ 16, 0, 0])rotate([ 180.0 ,0.0 ,0.0 ])nuthole_mX(3);
          translate([-16, 0, 0])rotate([ 180.0 ,0.0 ,0.0 ])nuthole_mX(3);
          translate([ 3*raster, 0, 2]) nuthole_mX(2);
          translate([-3*raster, 0, 2]) nuthole_mX(2);
     }
}
