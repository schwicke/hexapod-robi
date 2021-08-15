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
//
// all distances are in mm
//

// Define some globals used at various places
raster=2.54;

// motor height
space = 42.0;

// wall thickness
thickness = 4;

// battery box
batt_thickness = 3;
batt_x = 50;
batt_y = 160;
batt_z = 25;

// binder distance
binder_dist = 3.5;

// mount position base
base_mount_pos_x = batt_x/2+2*batt_thickness+1.5;

// dimensions for hubs for motor cabling
hub_hole_diameter = 2;
hub_spacer_height = 2;
hub_x = 4.9;
hub_y = 9.9;

module anchorbox(size){
     cube([40, 30, size],center=true);
}
