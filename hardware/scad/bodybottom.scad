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

module carveout(){
    cube([39,29,6], center=true);
}

module power_carveout(scale){
  cube([58*scale, 50*scale, 20], center=true);
}

module pcb_carveout(x, y){
  cube([x-1, y-1, 20], center=true);
}

module pcb_board(x, y, text, d, mode){
  translate([-15,0,1])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)text(text);
  cube([x, y, thickness], center=true);
  translate([ x/2-pcb_hole_dist,  y/2-pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
  translate([ x/2-pcb_hole_dist, -y/2+pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
  translate([-x/2+pcb_hole_dist,  y/2-pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
  translate([-x/2+pcb_hole_dist, -y/2+pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
}

module pcb_nuts(x, y, d, mode){
  translate([ x/2-pcb_hole_dist,  y/2-pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
  translate([ x/2-pcb_hole_dist, -y/2+pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
  translate([-x/2+pcb_hole_dist,  y/2-pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
  translate([-x/2+pcb_hole_dist, -y/2+pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
}

module power(scale, text, d, mode){
  translate([-15,0,1])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)text(text);
  difference(){
    cube([59*scale,50*scale,thickness], center=true);
    translate([ 24*scale, 21*scale, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([-24*scale, 21*scale, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([ 24*scale,-21*scale, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([-24*scale,-21*scale, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
  }
  // add spacers
  translate([ 24*scale, 21*scale, 0])spacer_mX(d, power_spacer_height);
  translate([-24*scale, 21*scale, 0])spacer_mX(d, power_spacer_height);
  translate([ 24*scale,-21*scale, 0])spacer_mX(d, power_spacer_height);
  translate([-24*scale,-21*scale, 0])spacer_mX(d, power_spacer_height);
}

module pi_carveout(){
  translate([10,0,0])cube([84,56,8], center=true);
}

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

module pi(){
  pi_frame(pi_frame_height);
  translate([10,0,0]){
    difference(){
      cube([85,56,thickness], center=true);
      translate([ 29, 24.5, 0])screwhole_mX(2.5);
      translate([-29, 24.5, 0])screwhole_mX(2.5);
      translate([ 29,-24.5, 0])screwhole_mX(2.5);
      translate([-29,-24.5, 0])screwhole_mX(2.5);
      // add ventilation grid
      for (iy=[-4:4]){
        for (ix=[-3:1]){
          translate([10+10.0*ix, iy*10+10.0*0+5*ix, 0])cylinder(h=2*thickness, r=5, center=true, $fn=6);
        }
      }
    }
    // add spacers
    translate([ 29, 24.5, 0])spacer_mX(2.5, pi_spacer_height);
    translate([-29, 24.5, 0])spacer_mX(2.5, pi_spacer_height);
    translate([ 29,-24.5, 0])spacer_mX(2.5, pi_spacer_height);
    translate([-29,-24.5, 0])spacer_mX(2.5, pi_spacer_height);
    translate([-50,0,1])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Pi-4");
  }
}

// create the body part
difference(){
  union(){
    difference(){
      scale([0.9,1.,1.]){
        linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0){
          resize([180, 230])circle(d=10, $fn=6);
        }
      }
      anchors_carveout(xleg, yleg, wleg);
      // carve out the bits for the electronics
      // POWER boards and power boards
      translate([power_pos_x, power_pos_y, 0])power_carveout(1);
      //translate([-power_pos_x, power_pos_y, 0])power_carveout(power_converter_scale);
      translate([-power_pos_x-5, power_pos_y, 0])pcb_carveout(pcb_x_size, pcb_y_size);
      //raspi
      translate([pi_pos_x, pi_pos_y, 0])pi_carveout();
     }
    // add text
    translate([-18, -103, thickness/2])scale([0.5, 0.5, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("this way up");
    // add the motor anchors
    anchors(xleg, yleg, wleg);
    // add power and power boards
    translate([power_pos_x, power_pos_y, 0])power(1, "u2d2", 3, 0);
    translate([-power_pos_x-5, power_pos_y, 0])pcb_board(pcb_x_size, pcb_y_size, "pcb", 2.5, 1);
  }
  // add some screwholes
  translate([0, -110, 0])nuthole_mX(3);
  translate([16, -110, 0])nuthole_mX(3);
  translate([-16, -110, 0])nuthole_mX(3);
  translate([0, 110, 0])nuthole_mX(3);
  translate([16, 110, 0])nuthole_mX(3);
  translate([-16, 110, 0])nuthole_mX(3);

  // add binder wholes
  translate([ 0, 0,  0])rotate([0, 0, 90])binder();
  translate([ 15, 0, 0])rotate([0, 0, 90])binder();
  translate([-15, 0, 0])rotate([0, 0, 90])binder();
  translate([ 30, 0, 0])rotate([0, 0, -45])binder();
  translate([-30, 0, 0])rotate([0, 0, -45])binder();
  translate([-50, 0, 0])binder();
  translate([ 50, 0, 0])binder();

  translate([-20, 80, 0])binder();
  translate([  0, 80, 0])binder();
  translate([ 20, 80, 0])binder();

  translate([-20, -80, 0])binder();
  translate([  0, -80, 0])binder();
  translate([ 20, -80, 0])binder();

  // motor cables binders
  translate([ 60, 30, 0])rotate([0, 0, +18])binder();
  translate([-60, 30, 0])rotate([0, 0, -18])binder();
  translate([ 60,-30, 0])rotate([0, 0, -18])binder();
  translate([-65,-25, 0])rotate([0, 0, +18])binder();

  translate([ 40, 75, 0])rotate([0, 0, +18])binder();
  translate([-40, 75, 0])rotate([0, 0, -18])binder();
  translate([ 40,-75, 0])rotate([0, 0, -18])binder();
  translate([-40,-75, 0])rotate([0, 0, +18])binder();

  // Raspi USB binders
  translate([-55,-45, 0])binder();
  translate([-55,-30, 0])binder();
  translate([-55,-15, 0])binder();

  // add holes to fix connection hubs
  translate([  0, 95, 0])connector_hub();
  translate([-23,-93, 0])rotate([ 0, 0, 90+18])connector_hub();
  translate([ 23,-93, 0])rotate([ 0, 0, 90-18])connector_hub();
  translate([-65, 0,  0])rotate([ 0, 0, 90])connector_hub();
  translate([ 65, 0,  0])rotate([ 0, 0, 90])connector_hub();
  //
  translate([-power_pos_x-5, power_pos_y, 0])pcb_nuts(pcb_x_size, pcb_y_size, 2.5, 1);
}
// add raspberry-pi and carve out space for the SD card
translate([pi_pos_x, pi_pos_y, 0]){
  difference(){
    pi();
    pi_sdcard(pi_frame_height);
  }
}
