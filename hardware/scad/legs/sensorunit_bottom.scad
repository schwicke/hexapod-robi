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
module leg(){
     cylinder(h=z, r=rad, center=false, $fn=fn);
     sphere(r=rad, $fn=fn);
}

translate([0,0,-z])leg();

difference(){
     sphere(r=rad+1, $fn=fn);
     translate([0,0,rad])cube([20,20,10], center=true);
}
translate([rad-0.2,0,-8.5-3.5+4])cube([2.,2.,14], center=true);
