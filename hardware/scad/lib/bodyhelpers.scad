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
// wrap screwhole: need to turn them here

include <../lib/globals.scad>
include <../lib/nuts_and_screws.scad>

module carveout(){
     cube([39,29,6], center=true);
}

module anchor(size){
     translate([0, -5, 0]){
          difference(){
               translate([ 0, 5, 0]) anchorbox(size);
               translate([ 0, 2,  0]) cylinder(h=20, d=8.1, center=true, $fn=200);
               translate([ 8, 2, 0]) my_screwhole_mX(2);
               translate([-8, 2, 0]) my_screwhole_mX(2);
               translate([ 0, 10, 0]) my_screwhole_mX(2);
               translate([ 0, -6, 0]) my_screwhole_mX(2);
          }
     }
}

module anchors(x, y, w, size){
     w1 = w;
     w2 = 180-w1;
     translate([ 80,0, 0]) rotate([0, 0, 90]) anchor(size);
     translate([-80,0, 0]) rotate([0, 0, -90]) anchor(size);
     translate([ x, y, 0]) rotate([0, 0, w1+90]) anchor(size);
     translate([-x,-y, 0]) rotate([0, 0, w1-90]) anchor(size);
     translate([ x,-y, 0]) rotate([0, 0, w2+270]) anchor(size);
     translate([-x, y, 0]) rotate([0, 0, w2+90]) anchor(size);
}


module anchors_carveout(x, y, w){
     w1 = w;
     w2 = 180-w1;
     translate([ 80, 0, 0]) rotate([0, 0, 90]) carveout();
     translate([-80, 0, 0]) rotate([0, 0, -90]) carveout();
     translate([ x, y, 0]) rotate([0, 0, w1+90]) carveout();
     translate([-x,-y, 0]) rotate([0, 0, w1-90]) carveout();
     translate([ x,-y, 0]) rotate([0, 0, w2+270]) carveout();
     translate([-x, y, 0]) rotate([0, 0, w2+90]) carveout();
}

module spacer_mX(d, height){
     translate([0, 0, (height+thickness)/2]){
          difference(){
               cylinder(h=height, r=d+0.2, center=true, $fn=50);
               cylinder(h=5*height, r=d/2.0+0.1, center=true, $fn=50);
          }
     }
}

module binder(){
     translate([-binder_dist/2, 0, 0]) cube([2, 3, 50], center=true);
     translate([ binder_dist/2, 0, 0]) cube([2, 3, 50], center=true);
}

module etages(alpha){
  union(){
    #rotate([alpha, 0, 0])translate([-60, 35,  1])my_screwhole_mX(3);
    #rotate([alpha, 0, 0])translate([ 60, 35,  1])my_screwhole_mX(3);
    #rotate([alpha, 0, 0])translate([-60, -35, 1])my_screwhole_mX(3);
    #rotate([alpha, 0, 0])translate([ 60, -35, 1])my_screwhole_mX(3);
  }
}
