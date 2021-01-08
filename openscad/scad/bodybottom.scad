// global parameters
thickness = 4;
power_pos_x = 25;
power_pos_y = 40;
power_spacer_height = 3;
power_converter_scale = 0.7;
// pi case dimensions
pi_pos_x = 0;
pi_pos_y = -40;
pi_frame_height = 5;
pi_spacer_height = 2;
// Ethernet 13x11 mm
// hdmi 8x4mm
// usb-c 10x4mm
// aux out d=7mm
hub_hole_diameter = 2;
hub_raster = 2.54;
hub_spacer_height = 2;
hub_x = 4.9;
hub_y = 9.9;
//
pcb_hole_dist = 2.0;
pcb_spacer_height = 3;
pcb_x_size = 40;
pcb_y_size = 60;
//
binder_dist = 3.5;
module simple_screwhole_mX(d){
   height = 40;
   headlength = 0.6*d/2+0.1;
   translate([0, 0, -5*headlength]){
     translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
     //cylinder(h=10*headlength, r=d+0.1, center=true, $fn=50);
   }
}

module screwhole_mX(d){
   height = 40;
   headlength = 0.6*d/2+0.1;
   translate([0, 0, -5*headlength]){
     translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
     cylinder(h=10*headlength, r=d+0.1, center=true, $fn=50);
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

module spacer_mX(d, height){
  translate([0, 0, (height+thickness)/2]){
    difference(){
      cylinder(h=height, r=d+0.2, center=true, $fn=50);
      cylinder(h=5*height, r=d/2.0+0.1, center=true, $fn=50);
    }
  }
}

module power_carveout(scale){
  cube([58*scale, 50*scale, 20], center=true);
}

module pcb_carveout(x, y){
  cube([x-1, y-1, 20], center=true);
}

module pcb_board(x, y, text, d, mode){
  translate([-15,0,1])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)text(text);
  difference(){
    cube([x, y, thickness], center=true);
    translate([ x/2-pcb_hole_dist,  y/2-pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([ x/2-pcb_hole_dist, -y/2+pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([-x/2+pcb_hole_dist,  y/2-pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([-x/2+pcb_hole_dist, -y/2+pcb_hole_dist, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
  }
  translate([ x/2-pcb_hole_dist,  y/2-pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
  translate([ x/2-pcb_hole_dist, -y/2+pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
  translate([-x/2+pcb_hole_dist,  y/2-pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
  translate([-x/2+pcb_hole_dist, -y/2+pcb_hole_dist, 0])spacer_mX(d, pcb_spacer_height);
}

module power(scale, text, d, mode){
  translate([-15,0,1])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)text(text);
  difference(){
    cube([59*scale,50*scale,thickness], center=true);
    translate([ 24*scale, 21*scale, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([-24*scale, 21*scale, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([ 24*scale,-21*scale, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
    translate([-24*scale,-21*scale, 0])if (mode==0) screwhole_mX(d); else nuthole_mX(d);
  }
  // add spacers
  translate([ 24*scale, 21*scale, 0])spacer_mX(d, power_spacer_height);
  translate([-24*scale, 21*scale, 0])spacer_mX(d, power_spacer_height);
  translate([ 24*scale,-21*scale, 0])spacer_mX(d, power_spacer_height);
  translate([-24*scale,-21*scale, 0])spacer_mX(d, power_spacer_height);
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
  translate([10,0,0]){
    difference(){
      cube([85,56,thickness], center=true);
      translate([ 29, 24.5, 0])screwhole_mX(2.5);
      translate([-29, 24.5, 0])screwhole_mX(2.5);
      translate([ 29,-24.5, 0])screwhole_mX(2.5);
      translate([-29,-24.5, 0])screwhole_mX(2.5);
      // add ventilation grid
      for (iy=[-4:4]){
        for (ix=[-3:1]){
          translate([10+10.0*ix, iy*10+10.0*0+5*ix, 0])cylinder(h=2*thickness, r=5, center=true, $fn=6);
        }
      }
    }
    // add spacers
    translate([ 29, 24.5, 0])spacer_mX(2.5, pi_spacer_height);
    translate([-29, 24.5, 0])spacer_mX(2.5, pi_spacer_height);
    translate([ 29,-24.5, 0])spacer_mX(2.5, pi_spacer_height);
    translate([-29,-24.5, 0])spacer_mX(2.5, pi_spacer_height);
    translate([-50,0,1])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("Pi-4");
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
 translate([-binder_dist/2, 0, 0])cube([2, 3, 50], center=true);
 translate([ binder_dist/2, 0, 0])cube([2, 3, 50], center=true);
}

module connector_hub(n){
  hub_hole_distance = 2*(n+1)*hub_raster;
  translate([ hub_hole_distance/2, 0, 0])simple_screwhole_mX(hub_hole_diameter);
  translate([-hub_hole_distance/2, 0, 0])simple_screwhole_mX(hub_hole_diameter);
  cube([n*hub_x+0.1, hub_y+0.1, 20], center=true);
}

module connector_hub_spacers(n){
  hub_hole_distance = 2*(n+1)*hub_raster;
  translate([ -hub_hole_distance/2, 0, 0])spacer_mX(hub_hole_diameter, hub_spacer_height);
  translate([  hub_hole_distance/2, 0, 0])spacer_mX(hub_hole_diameter, hub_spacer_height);
}

// create the body part
xleg = 40*0.95;  // position outer legs in x
yleg = 110*0.9; // position outer legs in y
wleg = 20;       // Angle of the outer legs
difference(){
  union(){
    difference(){
      scale([0.9,1.,1.]){
        linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0){
          resize([180, 230])circle(d=10, $fn=6);
        }
      }
      anchors_carveout(xleg, yleg, wleg);
      // carve out the bits for the electronics
      // POWER boards and power boards
      translate([power_pos_x, power_pos_y, 0])power_carveout(1);
      //translate([-power_pos_x, power_pos_y, 0])power_carveout(power_converter_scale);
      translate([-power_pos_x-5, power_pos_y, 0])pcb_carveout(pcb_x_size, pcb_y_size);
      //raspi
      translate([pi_pos_x, pi_pos_y, 0])pi_carveout();    
     }
    // add the motor anchors
    anchors(xleg, yleg, wleg);
    // add power and power boards
    translate([power_pos_x, power_pos_y, 0])power(1, "u2d2", 3, 0);
    //translate([-power_pos_x, power_pos_y, 0])power(power_converter_scale, "power", 2, 1);
    translate([-power_pos_x-5, power_pos_y, 0])pcb_board(pcb_x_size, pcb_y_size, "pcb", 2.5, 1);
    // add text
    translate([-18, -103, thickness/2])scale([0.5, 0.5, 1.0])linear_extrude(height=1, center=true, convexity=0, twist=0, slices=10, scale=1.0)text("this way up");
  }
  // add some screwholes
  translate([0, -110, 0])nuthole_mX(3);
  translate([16, -110, 0])nuthole_mX(3);
  translate([-16, -110, 0])nuthole_mX(3);
  translate([0, 110, 0])nuthole_mX(3);
  translate([16, 110, 0])nuthole_mX(3);
  translate([-16, 110, 0])nuthole_mX(3);
  // add binder wholes
  translate([ 0, 0,  0])rotate([0, 0, 90])binder();
  translate([ 15, 0, 0])rotate([0, 0, 90])binder();
  translate([-15, 0, 0])rotate([0, 0, 90])binder();
  translate([ 30, 0, 0])rotate([0, 0, -45])binder();
  translate([-30, 0, 0])rotate([0, 0, -45])binder();
  translate([-50, 0, 0])binder();
  translate([ 50, 0, 0])binder();
  
  translate([-20, 80, 0])binder();
  translate([  0, 80, 0])binder();
  translate([ 20, 80, 0])binder();
  
  translate([-20, -80, 0])binder();
  translate([  0, -80, 0])binder();
  translate([ 20, -80, 0])binder();
  
  // motor cables binders
  translate([ 60, 30, 0])rotate([0, 0, +18])binder();
  translate([-60, 30, 0])rotate([0, 0, -18])binder();
  translate([ 60,-30, 0])rotate([0, 0, -18])binder();
  translate([-65,-25, 0])rotate([0, 0, +18])binder();
  
  translate([ 40, 75, 0])rotate([0, 0, +18])binder();
  translate([-40, 75, 0])rotate([0, 0, -18])binder();
  translate([ 40,-75, 0])rotate([0, 0, -18])binder();
  translate([-40,-75, 0])rotate([0, 0, +18])binder();

  // Raspi USB binders
  translate([-55,-45, 0])binder();
  translate([-55,-30, 0])binder();
  translate([-55,-15, 0])binder();


  // add holes to fix connection hubs
  //translate([0,-95, 0])connector_hub(3);
  //translate([0, 95, 0])connector_hub(3);    
  //translate([ 60, 35, 0])rotate([0, 0, 90+18])connector_hub(3);
  //translate([ 60,-40, 0])rotate([0, 0, 90-18])connector_hub(3);
  //translate([-55, 35, 0])rotate([0, 0, 90-18])connector_hub(3);
  //translate([-55,-40, 0])rotate([0, 0, 90+18])connector_hub(3);

  translate([  0, 95, 0])connector_hub(3);    
  translate([-23,-93, 0])rotate([ 0, 0, 90+18])connector_hub(2);
  translate([ 23,-93, 0])rotate([ 0, 0, 90-18])connector_hub(2);
  translate([-65, 0,  0])rotate([ 0, 0, 90])connector_hub(3);
  translate([ 65, 0,  0])rotate([ 0, 0, 90])connector_hub(3);    

}
// add spacers to hub holes
//translate([0, 95, 0])connector_hub_spacers(3);
//translate([0,-95, 0])connector_hub_spacers(3);
//translate([ 60, 35, 0])rotate([0, 0, 90+18])connector_hub_spacers();
//translate([ 60,-45, 0])rotate([0, 0, 90-18])connector_hub_spacers();
//translate([-60, 35, 0])rotate([0, 0, 90-18])connector_hub_spacers();
//translate([-60,-45, 0])rotate([0, 0, 90+18])connector_hub_spacers();

// add raspberry-pi and carve out space for the SD card
translate([pi_pos_x, pi_pos_y, 0]){
  difference(){
    pi();
    pi_sdcard(pi_frame_height);
  }
}

