include <common.scad>;
thickness = 150;
switch_x =  12;
switch_z = 19;
reset_d = 17;
include <sidepart.scad>;

translate([0, 5, 0]){sidepart();}

//support 4x
translate([0, -5, 13.4]){
  difference(){
    rotate([0, 180, 0])cube([45, 10, 5], center=true);
    translate([ 0, 0, 0])nuthole_mX(3);
    translate([ 16, 0, 0])nuthole_mX(3);
    translate([-16, 0, 0])nuthole_mX(3);
  }
}
translate([0, -5, -12.4]){
  difference(){
    cube([45, 10, 7], center=true);
    translate([ 16, 0, -1])screwhole_mX(3);
    translate([-16, 0, -1])screwhole_mX(3);
  }
}
