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

dist = 4.5*raster;

module baseelement(){
     difference(){
       union(){
         difference(){
         translate([0, 0, -4])cube([38, 25, 9], center=true);
         cube([32+0.2, 50, 9], center=true);
         };
       }
       translate([-19, -8, -2])rotate([0,0,90])screwhole_mX(2, 10, 1.0);
       translate([-19,  8, -2])rotate([0,0,90])screwhole_mX(2, 10, 1.0);
       translate([19, -8, -2])rotate([0,0,-90])screwhole_mX(2, 10, 1.0);
       translate([19,  8, -2])rotate([0,0,-90])screwhole_mX(2, 10, 1.0);
  }
}
z=50;
rad=6;
fn=150;
module leg(){
     cylinder(h=z, r=rad, center=false, $fn=fn);
     sphere(r=rad, $fn=fn);
}

thickness=3;


module tiltedthing(){
     union(){
          translate([0,-5,10])rotate([30,0,0])baseelement();
          translate([0,-0.9,-3])cube([38,22,3], center=true);
          translate([0,8.55,3])cube([38,3,12], center=true);
     }
}

difference(){
     tiltedthing();
     translate([-rad-5,0,2.5])rotate([90,0,0])screwhole_mX(2, 20, 2.0);
     translate([+rad+5,0,2.5])rotate([90,0,0])screwhole_mX(2, 20, 2.0);
     rotate([0,0,180])translate([0,0,-4.6])cylinder(r=rad+1.0,h=1.5,center=true,$fn=fn);
     rotate([0,0,180])translate([0,0,-3.8])cylinder(r=5.1,h=1.1, center=true, $fn=fn);
     rotate([0,0,180])translate([0,-rad,-4.1])cube([7,12,1.1], center=true);
     translate([-dist,8.5,2])rotate([-90,0,0])nuthole_mX(2);
     translate([+dist,8.5,2])rotate([-90,0,0])nuthole_mX(2);

}
