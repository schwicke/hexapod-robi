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

wx = 4*raster+raster/2;
wy = 8*raster+raster/2;
wyp = (wy-m3s_nut_width)/4.0;
module mount(){
     //translate([0., 0., space/2  ])cube([10, 20, space+thickness/2], center=true);
     difference(){
          translate([-wx/2, -wy/2, 0])cube([wx, wy, space+thickness/2]);
          // holes
          translate([0, -wy/4, space+10])cylinder(h=50, r=m3s_screwdim/2+0.1, center=true, $fn=50);
          translate([0, +wy/4, space+10])cylinder(h=50, r=m3s_screwdim/2+0.1, center=true, $fn=50);
          translate([0, -wy/4, 10])cylinder(h=50, r=m3s_screwdim/2+0.1, center=true, $fn=50);
          translate([0, +wy/4, 10])cylinder(h=50, r=m3s_screwdim/2+0.1, center=true, $fn=50);
          // nuts 5.4mm x 2.4mm
          translate([0, +wy/4-m3s_nut_width/4, space-3])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 4*m3s_nut_width, m3s_nut_hight], center=false);
          translate([0, -wy/4+m3s_nut_width/4, space-3])rotate([0,0,180])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 4*m3s_nut_width, m3s_nut_hight], center=false);
          translate([0, +wy/4-m3s_nut_width/4, 5])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 4*m3s_nut_width, m3s_nut_hight], center=false);
          translate([0, -wy/4+m3s_nut_width/4, 5])rotate([0,0,180])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 4*m3s_nut_width, m3s_nut_hight], center=false);

     }
}
mount();
