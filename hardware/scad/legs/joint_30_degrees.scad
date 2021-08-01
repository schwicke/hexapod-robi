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
include <../lib/globals.scad>;
include <../lib/nuts_and_screws.scad>;

module baseelement(){
     difference(){
          union(){
               difference(){
                    translate([0, 0, -4])cube([38, 27, 9], center=true);
                    cube([32+0.2, 50, 10], center=true);
               };
          }
          translate([-19.5, -8, -2.5])rotate([0,0,90])screwhole_mX(2, 10, 1);
          translate([-19.5,  8, -2.5])rotate([0,0,90])screwhole_mX(2, 10, 1);
          translate([19.5, -8, -2.5])rotate([0,0,-90])screwhole_mX(2, 10, 1);
          translate([19.5,  8, -2.5])rotate([0,0,-90])screwhole_mX(2, 10, 1);
     }
}

module thing(){
     difference(){
          union(){
               baseelement();
               translate([0,-10.6,-16])rotate([180, 30, 90])baseelement();
               translate([0, 10, -13.1])rotate([-12, 0, 0])cube([27, 4.5, 15], center=true);
          }
     }
}

difference(){
     rotate([282,0,0])thing();
     translate([0.0, 0, -15])cube([200, 200, 4], center=true);
     translate([0,-15,10])cube([15, 30, 12],center=true);
     translate([0,0,0])cube([15, 30, 12],center=true);
     translate([0,-10,-20])cube([15, 10, 30],center=true);
}
