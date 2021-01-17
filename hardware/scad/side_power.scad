include <common.scad>;
thickness = 150;
switch_x =  13;
switch_z = 20;
raster =  3*2.54;

include <sidepart.scad>;

translate([0, 5, 0]){
  difference(){
    union(){
      difference(){
        sidepart();
        // switches
        translate([10, -20, -9])cube([switch_x+0.2, 50, switch_z+0.2]);
        translate([1.7-(2*switch_x),-20,-9])cube([switch_x+0.2, 50, switch_z+0.2]);
        // power connector
        translate([-5, -20, -4])cube([9.2, 50, 11.2]);
	// add some text
        # translate([5, 2.5, 8])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("12V DC");
        #translate([20, 2.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Motors");
        #translate([-15, 2.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Pi");
      }
    }
    translate([0, -5, 2])cube([17, 10.1, 15], center=true);
  }
}

//support 4x
translate([0, -5, 14.4]){
  difference(){
    rotate([0, 180, 0])cube([47, 10, 3], center=true);
    translate([ 0, 0, 0])nuthole_mX(3);
    translate([ 16, 0, 0])nuthole_mX(3);
    translate([-16, 0, 0])nuthole_mX(3);
    translate([ raster, 0, 5])screwhole_mX(3);
    translate([-raster, 0, 5])screwhole_mX(3);
  }
}
translate([0, -5, -12.4]){
  difference(){
    union(){
      cube([47, 10, 7], center=true);
      translate([0, 0, 5]){
        difference(){
          cube([20, 10, 4], center=true);
          cube([10, 10.1, 4.6], center=true);
        }
      }
    }
    translate([ 16, 0, -1])screwhole_mX(3);
    translate([-16, 0, -1])screwhole_mX(3);
    translate([ raster, 0, 2])nuthole_mX(2);
    translate([-raster, 0, 2])nuthole_mX(2);
  }
}
