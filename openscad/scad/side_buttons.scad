include <common.scad>;
thickness = 150;
switch_x =  12;
switch_z = 19;
reset_d = 17;

module sidepart(){
  difference(){
    translate([0, -120, 0]){
      xleg = 40*0.95;  // position outer legs in x
      yleg = 110*0.9;  // position outer legs in y
      wleg = 20;       // Angle of the outer legs
      difference(){
        cube([90.0, 245.0, 31.8],center=true);
        translate([5, 122.5, 10])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Controls");
        translate([20, 122.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Reset Pi");
        translate([-2, 122.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Reset Motors");
        union(){
          scale([0.9,1.,1.])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)resize([180, 230])circle(d=10, $fn=6);
        // add the motor anchors
          anchors(xleg, yleg, wleg);
        }
        translate([0, -100, 0])cube([150, 50, thickness], center=true);
      }
    }
  }
}

translate([0, 5, 0]){
  difference(){
    sidepart();
    // switches
    translate([12, 0, 0])rotate([90, 0, 0])cylinder(h=50, d=reset_d+0.2, center=true);
    translate([-12, 0, 0])rotate([90, 0, 0])cylinder(h=50, d=reset_d+0.2, center=true);
    #translate([12, 7, 0])rotate([90, 0, 0])cube([18.1, 18.1, 18.1], center=true);
    #translate([-12, 7, 0])rotate([90, 0, 0])cube([18.1, 18.1, 18.1], center=true);
  }
}

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
