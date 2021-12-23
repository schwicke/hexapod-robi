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
//
hub_hole_diameter = 2;
hub_spacer_height = 2;

hub_y = 5.75+0.2;
hub_x = 7.4+0.2;
dist = 4.5*raster;

module connector_hub(){
  translate([-dist, 0, -5])screwhole_mX_basic(hub_hole_diameter, 10.0, 1.0);
  translate([+dist, 0, -5])screwhole_mX_basic(hub_hole_diameter, 10.0, 1.0);
}

module box(dist){
     length=38;
     width=14;
     height=10;
     thickness=2.5;
     difference(){
          cube([length, width, height], center=true);
          //carve out to create a box
          translate([0, 0, 2.5])cube([length-thickness, width-thickness, height], center=true);
          //carve out for the sensor
          translate([0, hub_y, 4])cube([2*hub_x, 2*hub_y, 4], center=true);
          // connector hole
          #translate([0, -10, 2])rotate([90, 0, 0])cube([hub_x+0.1, hub_y+0.1, 20], center=true);
     }
     translate([-dist, 0, 0])cylinder(h=5, r=3, center=true, $fn=50);
     translate([+dist, 0, 0])cylinder(h=5, r=3, center=true, $fn=50);
}

difference(){
     box(dist);
     connector_hub();
}
