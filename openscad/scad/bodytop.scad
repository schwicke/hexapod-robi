// global parameters
thickness = 4;
power_pos_x = 25;
power_pos_y = 40;
euro_spacer_height = 3;
euro_hole_dist = 4.0;
power_converter_scale = 0.7;
hub_hole_diameter = 2;
hub_hole_distance = 3*4.9+hub_hole_diameter+2;
hub_spacer_height = 2;
top_size_scaler = 0.8;

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
module breadboard(){
// size 55x164
  translate([0, 154/2, 0])cube([85, 10, thickness], center=true);
  translate([0, -154/2, 0])cube([65, 10, thickness], center=true);
}

module breadboard_carveout(){
  translate([0, 0, thickness/2])cube([55.1, 164.1, 1], center=true);
}

module eurocard_holes(){
  translate([ 90/2-euro_hole_dist,  75-euro_hole_dist, 0])nuthole_mX(3);
  translate([ 90/2-euro_hole_dist, -75+euro_hole_dist, 0])nuthole_mX(3);
  translate([-90/2+euro_hole_dist,  75-euro_hole_dist, 0])nuthole_mX(3);
  translate([-90/2+euro_hole_dist, -75+euro_hole_dist, 0])nuthole_mX(3);
}


module eurocard_holders(){
  translate([ 90/2-euro_hole_dist,  75-euro_hole_dist, 0])cube([12, 12, thickness], center=true);
  translate([ 90/2-euro_hole_dist, -75+euro_hole_dist, 0])cube([12, 12, thickness], center=true);
  translate([-90/2+euro_hole_dist,  75-euro_hole_dist, 0])cube([12, 12, thickness], center=true);
  translate([-90/2+euro_hole_dist, -75+euro_hole_dist, 0])cube([12, 12, thickness], center=true);
  
  translate([ 90/2-euro_hole_dist,  75-euro_hole_dist, 0])spacer_mX(3, euro_spacer_height);
  translate([ 90/2-euro_hole_dist, -75+euro_hole_dist, 0])spacer_mX(3, euro_spacer_height);
  translate([-90/2+euro_hole_dist,  75-euro_hole_dist, 0])spacer_mX(3, euro_spacer_height);
  translate([-90/2+euro_hole_dist, -75+euro_hole_dist, 0])spacer_mX(3, euro_spacer_height);
}

module carveout(){
    cube([39,29,6], center=true);
}

module anchor(){
  difference(){
    cube([40,30,thickness],center=true);
    translate([0,-20,0])cube([20.1,40.1,6],center=true);
    translate([ 8,     3.5,   0])screwhole_mX(2);
    translate([-8,     3.5,   0])screwhole_mX(2);
    translate([-13.5, -2.5,   0])screwhole_mX(2);
    translate([-13.5, -10.5,  0])screwhole_mX(2);
    translate([ 13.5, -2.5,   0])screwhole_mX(2);
    translate([ 13.5, -10.5,  0])screwhole_mX(2);
  }  
}

module power_carveout(scale){
  cube([58*scale, 50*scale, 20], center=true);
}

module spacer_mX(d, height){
  translate([0, 0, (height+thickness)/2]){
    difference(){
      cylinder(h=height, r=d+0.2, center=true, $fn=50);
      cylinder(h=5*height, r=d/2.0+0.1, center=true, $fn=50);
    }
  }
}


module anchors_carveout(x, y, w){
  w1 = w;
  w2 = 180-w1;
  translate([80,0,0])rotate([0,0,90])carveout();
  translate([-80,0,0])rotate([0,0,-90])carveout();
  translate([ x, y, 0])rotate([0,0,w1+90])carveout();
  translate([-x,-y, 0])rotate([0,0,w1-90])carveout();
  translate([ x,-y, 0])rotate([0,0,w2+270])carveout();
  translate([-x, y, 0])rotate([0,0,w2+90])carveout();
}

module anchors(x, y, w){
  w1 = w;
  w2 = 180-w1;
  translate([ 80,0, 0])rotate([0,0,90])anchor();
  translate([-80,0, 0])rotate([0,0,-90])anchor();
  translate([ x, y, 0])rotate([0,0,w1+90])anchor();
  translate([-x,-y, 0])rotate([0,0,w1-90])anchor();
  translate([ x,-y, 0])rotate([0,0,w2+270])anchor();
  translate([-x, y, 0])rotate([0,0,w2+90])anchor();
}

module binder(){
 translate([-1.5, 0, 0])cube([2, 3, 50], center=true);
 translate([ 1.5, 0, 0])cube([2, 3, 50], center=true);
}

module connector_hub(){
  translate([ hub_hole_distance/2, 0, 0])nuthole_mX(hub_hole_diameter);
  translate([-hub_hole_distance/2, 0, 0])nuthole_mX(hub_hole_diameter);
}

module connector_hub_spacers(){
  translate([ -hub_hole_distance/2, 0, 0])spacer_mX(hub_hole_diameter, hub_spacer_height);
  translate([  hub_hole_distance/2, 0, 0])spacer_mX(hub_hole_diameter, hub_spacer_height);
}

// create the body part
xleg = 40*0.95;  // position outer legs in x
yleg = 110*0.9;  // position outer legs in y
wleg = 20;       // Angle of the outer legs
difference(){
  union(){
    difference(){
      scale([0.9,1.,1.]){
        linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0){
          resize([180, 230])circle(d=10, $fn=6);
        }
      }
      scale([0.9*top_size_scaler,0.95*top_size_scaler,1.]){
        linear_extrude(height=thickness+3, center=true, convexity=0, twist=0, slices=10, scale=1.0){
          resize([180, 230])circle(d=10, $fn=6);
        }
      }
      anchors_carveout(xleg, yleg, wleg);
     }
    // add the motor anchors
    anchors(xleg, yleg, wleg);
    // add text
    translate([-18, -103, thickness/2])scale([0.5, 0.5, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("this way up");
    // eurocard holders
    eurocard_holders();
    translate([0, -5, 0])breadboard();
  }
  // add some screwholes
  translate([0, -110, 0])screwhole_mX(3);
  translate([16, -110, 0])screwhole_mX(3);
  translate([-16, -110, 0])screwhole_mX(3);
  translate([0, 110, 0])screwhole_mX(3);
  translate([16, 110, 0])screwhole_mX(3);
  translate([-16, 110, 0])screwhole_mX(3);
  // euro card holders
  eurocard_holes();
  translate([0, -5, 0])breadboard_carveout();
}
