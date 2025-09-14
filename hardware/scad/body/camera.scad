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
include <../lib/sideparts.scad>
//camera module size:
xsize = 23.862;
ysize=25;

modx = 14.5;
framesize=5;
// mounting holes distances, 2.2mm diameter each
hdistx=14.5-2;
hdisty=25-2-2;
// m3 nuthole distance
deltanut3 = 16;
// position of first hole
xpos=5;
ypos=deltanut3;
// cable
capwidth=18;

difference(){
  union(){
  translate([0., -(3*deltanut3+framesize)/2, -thickness])difference(){
    cube([xsize+framesize, 3*deltanut3+framesize, thickness], center=false);
    #translate([xpos,        ypos, thickness/2])rotate([ 0.0 ,0.0 ,0.0 ])nuthole_mX(2);
    translate([xpos+hdistx, ypos, thickness/2])rotate([ 0.0 ,0.0 ,0.0 ])nuthole_mX(2);
    translate([xpos, ypos+hdisty, thickness/2])rotate([ 0.0 ,0.0 ,0.0 ])nuthole_mX(2);
    translate([xpos+hdistx, ypos+hdisty, thickness/2])rotate([ 0.0 ,0.0 ,0.0 ])nuthole_mX(2);
  }
  difference(){
    translate([ysize-0.1, -(3*deltanut3+framesize)/2, 0])rotate([0., 90., 0.])cube([ysize+framesize, 3*deltanut3+framesize, thickness], center=false);
    mynull = 0;
    translate([ysize, mynull-deltanut3, -ysize]) rotate([0., -90., 0.])my_screwhole_mX(3);
    translate([ysize, mynull, -ysize])           rotate([0., -90., 0.])my_screwhole_mX(3);
    translate([ysize, mynull+deltanut3, -ysize]) rotate([0., -90., 0.])my_screwhole_mX(3);
  }
  }
  translate([xsize-4,-capwidth/2,2])rotate([0,90,0])cube([10, capwidth, 10], center=false);
}
