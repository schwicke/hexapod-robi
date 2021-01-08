thickness = 150;
switch_x =  13;
switch_z = 20;
raster =  3*2.54;

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
        cube([90.0, 245.0, 31.8],center=true);
        translate([5, 122.5, 8])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("12V DC");
        translate([20, 122.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Motors");
        translate([-15, 122.5, -13])rotate([90, 0, 180])scale([0.25, 0.25, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Pi");
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
    union(){
      difference(){
        sidepart();
        // switches
        translate([10, -20, -9])cube([switch_x+0.2, 50, switch_z+0.2]);
        translate([1.7-(2*switch_x),-20,-9])cube([switch_x+0.2, 50, switch_z+0.2]);
        // power connector
        translate([-5, -20, -4])cube([9.2, 50, 11.2]);
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
