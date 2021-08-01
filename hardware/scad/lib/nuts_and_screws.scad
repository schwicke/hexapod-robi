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
// m3s nuts dimensions
m3s_screwdim = 3; // m3 screws
m3s_delta = 0.4;
m3s_nut_width = 5.4+m3s_delta;
m3s_nut_hight = 2.4+m3s_delta;

module screwhole_mX_basic(d, height, fact){
     headlength = 0.6*d/2+0.1;
     translate([0, 0, headlength/2]){
          translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
          cylinder(h=10*fact*headlength, r=d+0.1, center=true, $fn=50);
     }
}

module screwhole_mX(d, height, fact){
     headlength = 0.6*d/2+0.1;
     translate([0, 2, 0]){
          rotate([90, 0, 0]){
               translate([0, 0, headlength/2]){
                    translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
                    cylinder(h=10*fact*headlength, r=d+0.1, center=true, $fn=50);
               }
          }
     }
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
          cylinder(h=10*headlength, d=e+0.1, center=true, $fn=6);
     }
}

module my_screwhole_mX(d){
     translate([0, 0, thickness])rotate([180, 0, 0])screwhole_mX_basic(d, 40, 1);
}

