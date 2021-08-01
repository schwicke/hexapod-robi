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
