include <../lib/globals.scad>;
include <../lib/nuts_and_screws.scad>;
//
hub_hole_diameter = 2;
hub_spacer_height = 2;

hub_y = 5.75+0.2;
hub_x = 7.4+0.2;
dist = 4.5*raster;

module connector_hub(){
  translate([-dist, 0, -5])screwhole_mX_basic(hub_hole_diameter, 10.0, 1.0);
  translate([+dist, 0, -5])screwhole_mX_basic(hub_hole_diameter, 10.0, 1.0);
}

module box(dist){
     length=38;
     width=14;
     height=10;
     thickness=2.5;
     difference(){
          cube([length, width, height], center=true);
          // connector hole
          cube([hub_x+0.1, hub_y+0.1, 20], center=true);
          //carve out to create a box
          translate([0, 0, 2.5])cube([length-thickness, width-thickness, height], center=true);
          //carve out to connect the sensor
          translate([0, hub_y, 4])cube([2*hub_x, 2*hub_y, 4], center=true);
     }
     translate([-dist, 0, 0])cylinder(h=5, r=3, center=true, $fn=50);
     translate([+dist, 0, 0])cylinder(h=5, r=3, center=true, $fn=50);
}

difference(){
     box(dist);
     connector_hub();
}
