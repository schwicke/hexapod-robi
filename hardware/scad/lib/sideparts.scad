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
include <../lib/bodyhelpers.scad>
switch_x =  12;
switch_z = 19;
reset_d = 17;
thickness_top=5;
thickness_bottom=7;
over_thickness = 150;
hight=space-0.2; // determined by the motor dimensions


module anchor(size){
     anchorbox(size);
}

module sidepart(){
     difference(){
          translate([0, -120, 0]){
               xleg = 40*0.95;  // position outer legs in x
               yleg = 110*0.9;  // position outer legs in y
               wleg = 20;       // Angle of the outer legs
               difference(){
                    cube([90.0, 245.0, hight],center=true);
                    translate([5, 122.5, 10])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("12V DC");
                    translate([20, 122.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Motors");
                    translate([-15, 122.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Pi");
                    union(){
                         scale([0.9,1.,1.])linear_extrude(height=over_thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)resize([180, 230])circle(d=10, $fn=6);
                         // add the motor anchors
                         anchors(xleg, yleg, wleg, over_thickness);
                    }
                    translate([0, -100, 0])cube([150, 50, over_thickness], center=true);
               }
          }
     }
}
