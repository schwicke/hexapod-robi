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

z=50;
rad=6;
fn=150;
module leg(radius){
     cylinder(h=z, r=radius, center=false, $fn=fn);
     sphere(r=radius, $fn=fn);
}

thickness=3;
module half_shell(){
     difference(){
          union(){
               translate([0,0,-13])cylinder(r=rad+2, h=8, $fn=fn);
               difference(){
                    sphere( r=rad+1.2+thickness, $fn=fn);
                    sphere(r=rad+1.2, $fn=fn);
               };
               translate([-rad-5,0,0])cube([7,7,10], center=true);
               translate([+rad+5,0,0])cube([7,7,10], center=true);
          }
          translate([0,0,rad])cube([30,30,10], center=true);
          translate([0,0,-30])leg(rad+0.2);
          translate([0,rad,-5])cube([2.1,2.1,20], center=true);
     }
}

difference(){
     half_shell();
     translate([-rad-5,0,-3])rotate([00,00,30])nuthole_mX(2);
     translate([+rad+5,0,-3])rotate([00,00,30])nuthole_mX(2);
}
