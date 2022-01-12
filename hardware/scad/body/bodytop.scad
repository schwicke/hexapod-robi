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
include <../lib/bodyhelpers.scad>

// global parameters
top_size_scaler = 0.8;

// pi case dimensions
pi_pos_x = 0;
pi_pos_y = -60;
pi_frame_height = 5;
pi_spacer_height = 2;
pi_holespace_x = 29.0;
pi_holespace_y = 24.5;
pi_displace_x = 10;
// Ethernet 13x11 mm
// hdmi 8x4mm
// usb-c 10x4mm
// aux out d=7mm

// electronics
power_pos_x = 25;
power_pos_y = 58;
power_spacer_height = 3;
power_converter_scale = 0.7;
//
pcb_hole_dist = 2.0;
pcb_spacer_height = 3;
pcb_x_size = 40;
pcb_y_size = 60;

// battery dimenasions - for stagging stuff
// battery box dimensions
batt_x = 50;
batt_y = 160;
batt_z = 25;
batt_thickness = 3;

module pi_sdcard(min_size){
  translate([44,0,0])cube([2*thickness, 20, 10*min_size], center=true);
}

module pi_frame(height){
  h1 = thickness;
  h2 = height;

  translate([0, 0, (h1+h2)/2-0.1]){
    difference(){
      cube([88.5, 59.5, h2], center=true);
      cube([85.3, 56.3, h2+0.1], center=true);
      // carve out the holes for connectors
      translate([-42.5, 28-9, 7.25])cube([20, 13, 15], center=true);//USB1
      translate([-42.5, 28-27, 7.25])cube([20, 13, 15], center=true);//USB1
      translate([-42.5, 28-45.75, 5.5])cube([20, 13, 11], center=true);//ethernet
      translate([42.5-26, 28, 2])cube([8, 20, 4], center=true);//hdmi1
      translate([42.5-26-13.5, 28, 2])cube([8, 20, 4], center=true);//hdmi2
      translate([42.5-11.2, 28, 2])cube([10, 20, 4], center=true);//usbc
      translate([42.5-26-13.5-7-7.5, 28, 2])rotate([90, 0, 0])cylinder(h=20, d=7, $fn=50, center=true);
    }
  }
}

module pi_screwholes(){
  translate([pi_pos_x, pi_pos_y, 0])rotate([0, 0, 180])union(){
    translate([+ pi_holespace_x+pi_displace_x, + pi_holespace_y, 5])my_screwhole_mX(2.5);
    translate([- pi_holespace_x+pi_displace_x, + pi_holespace_y, 5])my_screwhole_mX(2.5);
    translate([+ pi_holespace_x+pi_displace_x, - pi_holespace_y, 5])my_screwhole_mX(2.5);
    translate([- pi_holespace_x+pi_displace_x, - pi_holespace_y, 5])my_screwhole_mX(2.5);
  }
}

module pi(){
  pi_frame(pi_frame_height);
  difference(){
    union(){
      translate([0, -25, 0])cube([115, 10, thickness], center=true);
      translate([0,  25, 0])cube([90, 10, thickness], center=true);
      translate([45,  0, 0])cube([5, 40, thickness], center=true);
      translate([-45,  0, 0])cube([5, 40, thickness], center=true);
    }
  }
  // add spacers
  translate([ pi_holespace_x+pi_displace_x, pi_holespace_y, 0])spacer_mX(2.5, pi_spacer_height);
  translate([-pi_holespace_x+pi_displace_x, pi_holespace_y, 0])spacer_mX(2.5, pi_spacer_height);
  translate([ pi_holespace_x+pi_displace_x,-pi_holespace_y, 0])spacer_mX(2.5, pi_spacer_height);
  translate([-pi_holespace_x+pi_displace_x,-pi_holespace_y, 0])spacer_mX(2.5, pi_spacer_height);
}

// create the body part
module bodytop(){
  xleg = 40*0.95;  // position outer legs in x
  yleg = 110*0.9;  // position outer legs in y
  wleg = 20;       // Angle of the outer legs
  difference(){
    union(){
      difference(){
        scale([0.9,1.,1.]){
          linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0){
            resize([180, 230])circle(d=10, $fn=6);
          }
        }
        scale([0.9*top_size_scaler,0.95*top_size_scaler,1.]){
            linear_extrude(height=thickness+3, center=true, convexity=0, twist=0, slices=10, scale=1.0){
            resize([180, 230])circle(d=10, $fn=6);
          }
        }
      }
    }
    // add some screwholes
    translate([0, -110, 1])my_screwhole_mX(3);
    translate([16, -110, 1])my_screwhole_mX(3);
    translate([-16, -110, 1])my_screwhole_mX(3);
    translate([0, 110, 1])my_screwhole_mX(3);
    translate([16, 110, 1])my_screwhole_mX(3);
    translate([-16, 110, 1])my_screwhole_mX(3);
  }
  // add raspberrypie
  translate([pi_pos_x, pi_pos_y, 0]){
    rotate([0, 0, 180])
      difference(){
      pi();
      pi_sdcard(pi_frame_height);
    }
  }
}

difference(){
  union(){
    bodytop();
  }
  // drill holes for screws through all of it
  pi_screwholes();
  etages(0);
}
