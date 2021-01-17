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
// global parameters
include <common.scad>;

module breadboard(){
// size 55x164
  translate([0, 154/2, 0])cube([85, 10, thickness], center=true);
  translate([0, -154/2, 0])cube([65, 10, thickness], center=true);
}

module breadboard_carveout(){
  translate([0, 0, thickness/2])cube([55.1, 164.1, 1], center=true);
}

module eurocard_holes(){
  translate([ 90/2-euro_hole_dist,  75-euro_hole_dist, 0])nuthole_mX(3);
  translate([ 90/2-euro_hole_dist, -75+euro_hole_dist, 0])nuthole_mX(3);
  translate([-90/2+euro_hole_dist,  75-euro_hole_dist, 0])nuthole_mX(3);
  translate([-90/2+euro_hole_dist, -75+euro_hole_dist, 0])nuthole_mX(3);
}

module eurocard_holders(){
  translate([ 90/2-euro_hole_dist,  75-euro_hole_dist, 0])cube([12, 12, thickness], center=true);
  translate([ 90/2-euro_hole_dist, -75+euro_hole_dist, 0])cube([12, 12, thickness], center=true);
  translate([-90/2+euro_hole_dist,  75-euro_hole_dist, 0])cube([12, 12, thickness], center=true);
  translate([-90/2+euro_hole_dist, -75+euro_hole_dist, 0])cube([12, 12, thickness], center=true);
  
  translate([ 90/2-euro_hole_dist,  75-euro_hole_dist, 0])spacer_mX(3, euro_spacer_height);
  translate([ 90/2-euro_hole_dist, -75+euro_hole_dist, 0])spacer_mX(3, euro_spacer_height);
  translate([-90/2+euro_hole_dist,  75-euro_hole_dist, 0])spacer_mX(3, euro_spacer_height);
  translate([-90/2+euro_hole_dist, -75+euro_hole_dist, 0])spacer_mX(3, euro_spacer_height);
}

module carveout(){
    cube([39,29,6], center=true);
}


module power_carveout(scale){
  cube([58*scale, 50*scale, 20], center=true);
}

// create the body part
difference(){
  union(){
    difference(){
      bodypart();
      scale([top_size_scaler,top_size_scaler,1.2])bodypart();
      anchors_carveout(xleg, yleg, wleg);
     }
    // add the motor anchors
    anchors(xleg, yleg, wleg);
    // add text
    translate([-18, -103, thickness/2])scale([0.5, 0.5, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("this way up");
    // eurocard holders
    eurocard_holders();
    translate([0, -5, 0])breadboard();
  }
  // add some screwholes
  translate([0, -110, 0])screwhole_mX(3);
  translate([16, -110, 0])screwhole_mX(3);
  translate([-16, -110, 0])screwhole_mX(3);
  translate([0, 110, 0])screwhole_mX(3);
  translate([16, 110, 0])screwhole_mX(3);
  translate([-16, 110, 0])screwhole_mX(3);
  // euro card holders
  eurocard_holes();
  translate([0, -5, 0])breadboard_carveout();
}
