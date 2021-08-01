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
hub_hole_diameter = 2;
hub_spacer_height = 2;
hub_raster =  2.54;
hub_x = 4.9;
hub_y = 9.9;

module screwhole_mX(d){
   height = 40;
   headlength = 0.6*d/2+0.1;
   translate([0, 0, height/2-10*headlength])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
}

module nuthole_mX(d){
   s = (d==2) ? 4: (d==2.5)? 5: (d==3) ? 5.5: 0.0;
   if (s==0){
     echo ("Nut size not supported");
   }
   e = s/sin(60.0);
   height = 40;
   headlength = 0.6*d/2+0.1;
   translate([0, 0, -5*headlength]){
     translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
     translate([0, 0, -1.5])cylinder(h=10*headlength, d=e+0.1, center=true, $fn=6);
   }
}

module connector_hub(n, mode){
  hub_hole_distance = 2*(n+1)*hub_raster;
  translate([ hub_hole_distance/2, 0, 0])if (mode==0) screwhole_mX(hub_hole_diameter); else nuthole_mX(hub_hole_diameter);
  translate([-hub_hole_distance/2, 0, 0])if (mode==0) screwhole_mX(hub_hole_diameter); else nuthole_mX(hub_hole_diameter);
}

module box(n){
  h1 = 6;
  h2 = 4;
  t1 = 4.0;
  t2 = 1.52;
  z1 = (h1+h2)/2-t1;
  z2 = (h1+h2)/2-t2;
  difference(){
    cube([hub_raster*2*(n+1)+7, 20, h1], center=true);
    translate([0, 0, z1])cube([n*hub_x+hub_raster/2+0.1, hub_y+hub_raster/2+0.1, h2], center=true);
    translate([0, 0, z2])cube([40, hub_y+hub_raster/2+0.1, h2], center=true);
    connector_hub(n, 1);
  }
}
// boxes
translate([0, 0, 0])box(2);
translate([0, 30, 0])box(2);
translate([0, -30, 0])box(3);
translate([30, 30, 0])box(3);
translate([30, -30, 0])box(3);
