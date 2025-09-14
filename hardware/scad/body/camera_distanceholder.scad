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

//camera module size:
xsize = 14.5+2;
ysize = 25;
thickness = 3;

framesize=5;
// mounting holes distances, 2.2mm diameter each
hdistx=14.5-2;
hdisty=25-4;
// position of first hole
xpos=2;
ypos=2;

translate([0., -ysize/2., -thickness])
  difference(){
    cube([xsize, ysize, thickness], center=false);
    translate([xpos,        ypos, thickness/2])rotate([ 180.0 ,0.0 ,0.0 ])cylinder(h=20, d=2.2, center=true, $fn=50);
    translate([xpos+hdistx, ypos, thickness/2])rotate([ 180.0 ,0.0 ,0.0 ])cylinder(h=20, d=2.2, center=true, $fn=50);
    translate([xpos, ypos+hdisty, thickness/2])rotate([ 180.0 ,0.0 ,0.0 ])cylinder(h=20, d=2.2, center=true, $fn=50);
    translate([xpos+hdistx, ypos+hdisty, thickness/2])rotate([ 180.0 ,0.0 ,0.0 ])cylinder(h=20, d=2.2, center=true, $fn=50);
  }
