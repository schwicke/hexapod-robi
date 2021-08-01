thickness = 150;
switch_x =  12;
switch_z = 19;
reset_d = 17;
space = 42.2;
thickness_top=5;
thickness_bottom=7;
//hight=space+thickness_top+thickness_bottom;
hight=space; // determined by the motor dimensions
module screwhole_mX(d){
   height = 40;
   headlength = 0.6*d/2+0.1;
   rotate([180, 0, 0]){
     translate([0, 0, -5*headlength]){
       translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
       cylinder(h=10*headlength, r=d+0.1, center=true, $fn=50);
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

module anchor(){
     cube([40,30,thickness],center=true);
}

module anchors(x, y, w){
  w1 = w;
  w2 = 180-w1;
  translate([ x, y, 0])rotate([0,0,w1+90])anchor();
  translate([-x,-y, 0])rotate([0,0,w1-90])anchor();
  translate([ x,-y, 0])rotate([0,0,w2+270])anchor();
  translate([-x, y, 0])rotate([0,0,w2+90])anchor();
}


module sidepart(){
  difference(){
    translate([0, -120, 0]){
      xleg = 40*0.95;  // position outer legs in x
      yleg = 110*0.9;  // position outer legs in y
      wleg = 20;       // Angle of the outer legs
      difference(){
        //cube([90.0, 245.0, 31.8],center=true);
        cube([90.0, 245.0, hight],center=true);
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
    //translate([0, 14, 0])cube([50, 30, thickness], center=true);
  }
}

translate([0, 5, 0]){
  difference(){
    sidepart();
    // switches
    translate([12, 0, 0])rotate([90, 0, 0])cylinder(h=50, d=reset_d+0.2, center=true);
    translate([-12, 0, 0])rotate([90, 0, 0])cylinder(h=50, d=reset_d+0.2, center=true);
    translate([12, 7, 0])rotate([90, 0, 0])cube([18.1, 18.1, 18.1], center=true);
    translate([-12, 7, 0])rotate([90, 0, 0])cube([18.1, 18.1, 18.1], center=true);
  }
}

//support 4x
translate([0, -5, hight/2-thickness_top/2]){
  difference(){
    rotate([0, 180, 0])cube([45, 10, thickness_top], center=true);
    translate([ 0, 0, 0])nuthole_mX(3);
    translate([ 16, 0, 0])nuthole_mX(3);
    translate([-16, 0, 0])nuthole_mX(3);
  }
}
translate([0, -5, -hight/2+thickness_bottom/2]){
  difference(){
    cube([45, 10, thickness_bottom], center=true);
    translate([ 16, 0, -1])screwhole_mX(3);
    translate([-16, 0, -1])screwhole_mX(3);
  }
}
