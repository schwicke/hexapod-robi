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
include <../lib/mounts.scad>
include <../lib/bodyhelpers.scad>


module connector_hub(n){
     hub_hole_distance = 2*(n+1)*raster;
     translate([ hub_hole_distance/2, 0., 4.])rotate([0, 180, 0])screwhole_mX_basic(hub_hole_diameter, 40, 1);
     translate([-hub_hole_distance/2, 0., 4.])rotate([0, 180, 0])screwhole_mX_basic(hub_hole_diameter, 40, 1);
     cube([n*hub_x+0.1, hub_y+0.1, 20], center=true);
}

module connector_hub_spacers(n){
     hub_hole_distance = 2*(n+1)*raster;
     translate([ -hub_hole_distance/2, 0, 0])spacer_mX(hub_hole_diameter, hub_spacer_height);
     translate([  hub_hole_distance/2, 0, 0])spacer_mX(hub_hole_diameter, hub_spacer_height);
}

module battery_box(){
     difference(){
          translate([0, 0, batt_z/2+batt_thickness-3.0])cube([batt_x+batt_thickness, batt_y+batt_thickness, batt_z+batt_thickness], center=true);
          translate([0, 0, batt_z/2+3*batt_thickness-6.0])cube([batt_x, batt_y, batt_z+batt_thickness], center=true);
          translate([0, -batt_y/2, batt_z/2+3*batt_thickness-3])cube([batt_x-10, batt_y-10, batt_z+batt_thickness], center=true);
     }
}
// create the body part
xleg = 40*0.95;  // position outer legs in x
yleg = 110*0.9; // position outer legs in y
wleg = 20;       // Angle of the outer legs
module bodypart(){
     difference(){
          union(){
               translate([0, 5, 0])battery_box();
               difference(){
                    scale([0.9,1.,1.]){
                         linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0){
                              resize([180, 230])circle(d=10, $fn=6);
                         }
                    }
                    anchors_carveout(xleg, yleg, wleg);
               }
               // add the motor anchors
               anchors(xleg, yleg, wleg, thickness);
               translate([-18, -103, thickness/2])scale([0.5, 0.5, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("this way up");
          }
          // add some screwholes
          translate([0, -110, 0])nuthole_mX(3);
          translate([16, -110, 0])nuthole_mX(3);
          translate([-16, -110, 0])nuthole_mX(3);
          translate([0, 110, 0])nuthole_mX(3);
          translate([16, 110, 0])nuthole_mX(3);
          translate([-16, 110, 0])nuthole_mX(3);
          // add binder wholes
          //translate([ 0, 0,  0])rotate([0, 0, 90])binder();

          // motor cables binders
          translate([ 60, 30, 0])rotate([0, 0, +18])binder();
          translate([-60, 30, 0])rotate([0, 0, -18])binder();
          translate([ 60,-30, 0])rotate([0, 0, -18])binder();
          translate([-65,-25, 0])rotate([0, 0, +18])binder();

          translate([ 40, 75, 0])rotate([0, 0, +18])binder();
          translate([-40, 75, 0])rotate([0, 0, -18])binder();
          translate([ 40,-75, 0])rotate([0, 0, -18])binder();
          translate([-40,-75, 0])rotate([0, 0, +18])binder();

          // add holes to fix connection hubs
          translate([  0, 95, 0])connector_hub(3);
          translate([-23,-93, 0])rotate([ 0, 0, 90+18])connector_hub(2);
          translate([ 23,-93, 0])rotate([ 0, 0, 90-18])connector_hub(2);
          translate([-65, 0,  0])rotate([ 0, 0, 90])connector_hub(3);
          translate([ 65, 0,  0])rotate([ 0, 0, 90])connector_hub(3);
          
          // add ventilation grid
          translate([11,0,0]){
               for (iy=[-7:7]){
                    for (ix=[-5:1]){
                         translate([10+10.0*ix, iy*10+10.0*0+5*(ix-2*floor(ix/2)), -thickness/2])cylinder(h=4*thickness, r=5, center=true, $fn=6);
                    }
               }
          }
     }
}

difference(){
     union(){
          bodypart();
          translate([-base_mount_pos_x, 0, 0])mount_plate();
          translate([+base_mount_pos_x, 0, 0])mount_plate();
     }
     // drill the wholes for the mount for the next floor
     translate([-base_mount_pos_x, 0, 0])mount_holes();
     translate([+base_mount_pos_x, 0, 0])mount_holes();
}
// add mounts to fix to upper part
