include <../lib/globals.scad>;
include <../lib/nuts_and_screws.scad>;

z=50;
rad=6;
fn=150;
module leg(radius){
     cylinder(h=z, r=radius, center=false, $fn=fn);
     sphere(r=radius, $fn=fn);
}

thickness=3;
module half_shell(){
     difference(){
          union(){
               translate([0,0,-13])cylinder(r=rad+2, h=8, $fn=fn);
               difference(){
                    sphere( r=rad+1.2+thickness, $fn=fn);
                    sphere(r=rad+1.2, $fn=fn);
               };
               translate([-rad-5,0,0])cube([7,7,10], center=true);
               translate([+rad+5,0,0])cube([7,7,10], center=true);
          }
          translate([0,0,rad])cube([30,30,10], center=true);
          translate([0,0,-30])leg(rad+0.2);
          translate([0,rad,-5])cube([2.1,2.1,20], center=true);
     }
}

difference(){
     half_shell();
     translate([-rad-5,0,-3])rotate([00,00,30])nuthole_mX(2);
     translate([+rad+5,0,-3])rotate([00,00,30])nuthole_mX(2);
}
