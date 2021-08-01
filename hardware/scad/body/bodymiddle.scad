// global parameters
thickness = 4;
raster =  2.54;
euro_spacer_height = 3;
euro_hole_dist = 4.0;
top_size_scaler = 0.8;

// electronics
power_pos_x = 25;
power_pos_y = 40;
power_spacer_height = 3;
power_converter_scale = 0.7;
//
// pi case dimensions
pi_pos_x = 0;
pi_pos_y = -40;
pi_frame_height = 5;
pi_spacer_height = 2;
// Ethernet 13x11 mm
// hdmi 8x4mm
// usb-c 10x4mm
// aux out d=7mm
pcb_hole_dist = 2.0;
pcb_spacer_height = 3;
pcb_x_size = 40;
pcb_y_size = 60;

// battery dimenasions - for stagging stuff
// battery box dimensions
batt_x = 50;
batt_y = 160;
batt_z = 25;
batt_thickness = 3;
// supports
delta = 0.4;
m3s_nut_width=5.4+delta;
m3s_nut_hight=2.4+delta;
screwdim=3; // m3 screws

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

module carveout(){
    cube([39,29,6], center=true);
}

//module anchor(){
//  difference(){
//    cube([40,30,thickness],center=true);
//    translate([0,-20,0])cube([20.1,40.1,6],center=true);
//    translate([ 8,     3.5,   0])screwhole_mX(2);
//    translate([-8,     3.5,   0])screwhole_mX(2);
//    translate([-13.5, -2.5,   0])screwhole_mX(2);
//    translate([-13.5, -10.5,  0])screwhole_mX(2);
//    translate([ 13.5, -2.5,   0])screwhole_mX(2);
//    translate([ 13.5, -10.5,  0])screwhole_mX(2);
//  }  
//}
module anchor(){
     translate([0, -5, 0])difference(){
          translate([0,5,0])cube([40,30,thickness],center=true);
          translate([ 0, 2,  0])cylinder(h=20, d=8.1, center=true, $fn=200);
          translate([ 8, 2, 0])screwhole_mX(2);
          translate([-8, 2, 0])screwhole_mX(2);
          translate([0,  10, 0])screwhole_mX(2);
          translate([0, -6, 0])screwhole_mX(2);
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

module pcb_carveout(x, y){
  cube([x-1, y-1, 20], center=true);
}


module power_carveout(scale){
  cube([58*scale, 50*scale, 20], center=true);
}

module pcb_spacers(x, y, d, mode){
     // spacers
     translate([ x/2-pcb_hole_dist,  y/2-pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
     translate([ x/2-pcb_hole_dist, -y/2+pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
     translate([-x/2+pcb_hole_dist,  y/2-pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
     translate([-x/2+pcb_hole_dist, -y/2+pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
}

module pcb_holes(x, y, d, mode){
     translate([ x/2-pcb_hole_dist,  y/2-pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
     translate([ x/2-pcb_hole_dist, -y/2+pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
     translate([-x/2+pcb_hole_dist,  y/2-pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
     translate([-x/2+pcb_hole_dist, -y/2+pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
}

module power_spacers(scale, d, mode){
     // add spacers
     translate([ 24*scale, 21*scale, 0])spacer_mX(d, power_spacer_height);
     translate([-24*scale, 21*scale, 0])spacer_mX(d, power_spacer_height);
     translate([ 24*scale,-21*scale, 0])spacer_mX(d, power_spacer_height);
     translate([-24*scale,-21*scale, 0])spacer_mX(d, power_spacer_height);
}

module power_holes(scale, d, mode){
     translate([ 24*scale, 21*scale, 0]) rotate([0,180,0]) if (mode==0) screwhole_mX(d); else nuthole_mX(d);
     translate([-24*scale, 21*scale, 0]) rotate([0,180,0]) if (mode==0) screwhole_mX(d); else nuthole_mX(d);
     translate([ 24*scale,-21*scale, 0]) rotate([0,180,0]) if (mode==0) screwhole_mX(d); else nuthole_mX(d);
     translate([-24*scale,-21*scale, 0]) rotate([0,180,0]) if (mode==0) screwhole_mX(d); else nuthole_mX(d);
}

module pi_carveout(){
  translate([10,0,0])cube([84,56,8], center=true);
}

module pi_sdcard(min_size){
  translate([44,0,0])cube([2*thickness, 20, 10*min_size], center=true);
}

module pi_frame(height){
  h1 = thickness;
  h2 = height;
  
  translate([0, 0, (h1+h2)/2-0.1]){
    difference(){
      cube([88.5, 59.5, h2], center=true);
      cube([85.3, 56.3, h2+0.1], center=true);
      // carve out the holes for connectors
      translate([-42.5, 28-9, 7.25])cube([20, 13, 15], center=true);//USB1
      translate([-42.5, 28-27, 7.25])cube([20, 13, 15], center=true);//USB1
      translate([-42.5, 28-45.75, 5.5])cube([20, 13, 11], center=true);//ethernet
      translate([42.5-26, 28, 2])cube([8, 20, 4], center=true);//hdmi1
      translate([42.5-26-13.5, 28, 2])cube([8, 20, 4], center=true);//hdmi2
      translate([42.5-11.2, 28, 2])cube([10, 20, 4], center=true);//usbc
      translate([42.5-26-13.5-7-7.5, 28, 2])rotate([90, 0, 0])cylinder(h=20, d=7, $fn=50, center=true);
    }
  }
}

module pi(){
     pi_frame(pi_frame_height);
     difference(){
          union(){
               translate([0, -25, 0])cube([105, 10, thickness], center=true);
               translate([0,  25, 0])cube([125, 10, thickness], center=true);
               translate([45,  0, 0])cube([5, 40, thickness], center=true);
               translate([-45,  0, 0])cube([5, 40, thickness], center=true);
          }
          translate([ 29, 24.5, 0])screwhole_mX(2.5);
          translate([-29, 24.5, 0])screwhole_mX(2.5);
          translate([ 29,-24.5, 0])screwhole_mX(2.5);
          translate([-29,-24.5, 0])screwhole_mX(2.5);
     }
     // add spacers
     translate([ 29, 24.5, 0])spacer_mX(2.5, pi_spacer_height);
     translate([-29, 24.5, 0])spacer_mX(2.5, pi_spacer_height);
     translate([ 29,-24.5, 0])spacer_mX(2.5, pi_spacer_height);
     translate([-29,-24.5, 0])spacer_mX(2.5, pi_spacer_height);
}

module mount(){
     //translate([0., 0., space/2  ])cube([10, 20, space+thickness/2], center=true);
     wx = 4*raster+raster/2;
     wy = 8*raster+raster/2;
     wyp = (wy-m3s_nut_width)/4.0;
     screwdim=3; // m3 screws
     headlength = 0.6*screwdim/2+0.1;
     difference(){
          union(){
               translate([-wx/2, -wy/2, -thickness/2])cube([wx, wy, thickness]);
               translate([0,  15, 0])cube([125, 10, thickness], center=true);
          }
          // screw holes to mount on previous layer
          translate([0, -wy/4, 0.])screwhole_mX(3);
          translate([0, +wy/4, 0.])screwhole_mX(3);
     }
}

// create the body part
module bodymiddle(){
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
               //eurocard_holders();
               //translate([0, -5, 0])breadboard();
          }
          // add some screwholes
          translate([0, -110, 0])screwhole_mX(3);
          translate([16, -110, 0])screwhole_mX(3);
          translate([-16, -110, 0])screwhole_mX(3);
          translate([0, 110, 0])screwhole_mX(3);
          translate([16, 110, 0])screwhole_mX(3);
          translate([-16, 110, 0])screwhole_mX(3);
     }
     // add raspberrypie
     translate([pi_pos_x, pi_pos_y, 0]){
          difference(){
               pi();
               pi_sdcard(pi_frame_height);
          }
     }
     // mount connectors
     pos_x = batt_x/2+2*batt_thickness;
     translate([-pos_x, 0, 0])mount();
     translate([+pos_x, 0, 0])mount();
     // supports and spacers for u2d2 and power converters
     translate([0,0,0])cube([20, 5, 0], center=true);
     translate([-power_pos_x-5, power_pos_y, 0])pcb_spacers(pcb_x_size, pcb_y_size, 2.5, 1);
     translate([power_pos_x, power_pos_y, 0])power_spacers(1, 3, 0);
     
}

difference(){
     union(){
          bodymiddle();
          translate([2*power_pos_x-1.5, power_pos_y, 0.0])cube([10, 50, thickness], center=true);
          translate([0.5, power_pos_y, 0.0])cube([10, 110, thickness], center=true);
          translate([-12, power_pos_y, 0.0])cube([10, 110, thickness], center=true);
          translate([-pcb_x_size-8, power_pos_y-7, 0.0])cube([10, 90, thickness], center=true);
     }
     translate([-power_pos_x-5, power_pos_y, 0])pcb_holes(pcb_x_size, pcb_y_size, 2.5, 1);
     translate([power_pos_x, power_pos_y, 0])power_holes(1, 3, 0);
}
