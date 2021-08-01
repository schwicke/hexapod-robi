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

// helpers to create several floors on the robot
include <../lib/globals.scad>

// ensure that we have a solid base to put the screws in
module mount_plate(){
     wx = 4*raster+raster/2;
     wy = 8*raster+raster/2;
     wyp = (wy-m3s_nut_width)/4.0;
     translate([-wx/2, -wy/2, -thickness/2])cube([wx, wy, thickness]);
}

// drill the holes ... to be used in a difference() directive
module mount_holes(){
     wx = 4*raster+raster/2;
     wy = 8*raster+raster/2;
     wyp = (wy-m3s_nut_width)/4.0;     
     translate([0, -wy/4, -6])screwhole_mX_basic(3, 50, 1);
     translate([0, +wy/4, -6])screwhole_mX_basic(3, 50, 1);
}
