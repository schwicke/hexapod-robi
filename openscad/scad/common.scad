// thickness in mm
thickness = 4;
// size of power module
power_pos_x = 25;
power_pos_y = 40;
power_spacer_height = 3;
power_converter_scale = 0.7;
// hub space paraemters
hub_hole_diameter = 2;
hub_hole_distance = 3*4.9+hub_hole_diameter+2;
hub_raster = 2.54;
hub_spacer_height = 2;
hub_x = 4.9;
hub_y = 9.9;

// pcb board
pcb_hole_dist = 2.0;
pcb_spacer_height = 3;
pcb_x_size = 40;
pcb_y_size = 60;

// RapsberryPi 4 case dimensions
pi_pos_x = 0;
pi_pos_y = -40;
pi_frame_height = 5;
pi_spacer_height = 2;

// holes for zip binders
binder_dist = 3.5;

// euro PCB board on top
euro_spacer_height = 3;
euro_hole_dist = 4.0;

// scaling the top board
top_size_scaler = 0.8;

// leg definitions
xleg = 40*0.95;  // position outer legs in x
yleg = 110*0.9;  // position outer legs in y
wleg = 20;       // Angle of the outer legs

///////////////////////////////////
// common modules
///////////////////////////////////
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

module simple_screwhole_mX(d){
   height = 40;
   headlength = 0.6*d/2+0.1;
   translate([0, 0, -5*headlength]){
     translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
   }
}

// design bits
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

module spacer_mX(d, height){
  translate([0, 0, (height+thickness)/2]){
    difference(){
      cylinder(h=height, r=d+0.2, center=true, $fn=50);
      cylinder(h=5*height, r=d/2.0+0.1, center=true, $fn=50);
    }
  }
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
 translate([-binder_dist/2, 0, 0])cube([2, 3, 50], center=true);
 translate([ binder_dist/2, 0, 0])cube([2, 3, 50], center=true);
}

module connector_hub(){
  translate([ hub_hole_distance/2, 0, 0])nuthole_mX(hub_hole_diameter);
  translate([-hub_hole_distance/2, 0, 0])nuthole_mX(hub_hole_diameter);
}

module connector_hub_spacers(){
  translate([ -hub_hole_distance/2, 0, 0])spacer_mX(hub_hole_diameter, hub_spacer_height);
  translate([  hub_hole_distance/2, 0, 0])spacer_mX(hub_hole_diameter, hub_spacer_height);
}

