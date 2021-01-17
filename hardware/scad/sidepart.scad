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
thickness = 150;
switch_x =  13;
switch_z = 20;
raster =  3*2.54;
reset_d = 17;

module sidepart_basic(){
  difference(){
    translate([0, -120, 0]){
      xleg = 40*0.95;  // position outer legs in x
      yleg = 110*0.9;  // position outer legs in y
      wleg = 20;       // Angle of the outer legs
      difference(){
        cube([90.0, 245.0, 31.8],center=true);
        union(){
          scale([0.9,1.,1.])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)resize([180, 230])circle(d=10, $fn=6);
        // add the motor anchors
          anchors(xleg, yleg, wleg);
        }
        translate([0, -100, 0])cube([150, 50, thickness], center=true);
      }
    }
  }
}

module sidepart(){
  translate([0, 5, 0]){sidepart_basic();}

  //support 4x
  translate([0, -5, 13.4]){
    difference(){
      rotate([0, 180, 0])cube([45, 10, 5], center=true);
      translate([ 0, 0, 0])nuthole_mX(3);
      translate([ 16, 0, 0])nuthole_mX(3);
      translate([-16, 0, 0])nuthole_mX(3);
    }
  }
  translate([0, -5, -12.4]){
    difference(){
      cube([45, 10, 7], center=true);
      translate([ 16, 0, -1])screwhole_mX(3);
      translate([-16, 0, -1])screwhole_mX(3);
    }
  }
}