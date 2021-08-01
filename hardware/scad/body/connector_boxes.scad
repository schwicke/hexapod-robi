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

module connector_hub(n){
     hub_hole_distance = 2*(n+1)*raster;
     translate([ hub_hole_distance/2, 0, -1])rotate([0, 0, 180])nuthole_mX(hub_hole_diameter);
     translate([-hub_hole_distance/2, 0, -1])rotate([0, 0, 180])nuthole_mX(hub_hole_diameter);
}

module box(n){
     h1 = 6;
     h2 = 4;
     t1 = 4.0;
     t2 = 1.52;
     z1 = (h1+h2)/2-t1;
     z2 = (h1+h2)/2-t2;
     difference(){
          cube([raster*2*(n+1)+7, 20, h1], center=true);
          translate([0, 0, z1])cube([n*hub_x+raster/2+0.1, hub_y+raster/2+0.1, h2], center=true);
          translate([0, 0, z2])cube([40, hub_y+raster/2+0.1, h2], center=true);
          connector_hub(n);
     }
}
// all boxes
translate([0, 0, 0])box(2);
translate([0, 30, 0])box(2);
translate([0, -30, 0])box(3);
translate([30, 30, 0])box(3);
translate([30, -30, 0])box(3);
