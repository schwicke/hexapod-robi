// global parameters
thickness = 4;
raster =  2.54;
// motors
space = 42.2; // motor hight
// battery box dimensions
batt_x = 50;
batt_y = 160;
batt_z = 25;
batt_thickness = 3;
// connector hubs
hub_raster = 2.54;
hub_hole_diameter = 2;
hub_spacer_height = 2;
hub_x = 4.9;
hub_y = 9.9;
// supports
delta = 0.4;
m3s_nut_width=5.4+delta;
m3s_nut_hight=2.4+delta;
screwdim=3; // m3 screws

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
     translate([0, -5, 0])difference(){
          translate([0,5,0])cube([40,30,thickness],center=true);
          translate([ 0, 2,  0])cylinder(h=20, d=8.1, center=true, $fn=200);
          translate([ 8, 2, 0])screwhole_mX(2);
          translate([-8, 2, 0])screwhole_mX(2);
          translate([0,  10, 0])screwhole_mX(2);
          translate([0, -6, 0])screwhole_mX(2);
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

module battery_box(){
     difference(){
          translate([0, 0, batt_z/2+batt_thickness-3.0])cube([batt_x+batt_thickness, batt_y+batt_thickness, batt_z+batt_thickness], center=true); 
          translate([0, 0, batt_z/2+3*batt_thickness-6.0])cube([batt_x, batt_y, batt_z+batt_thickness], center=true);
          translate([0, -batt_y/2, batt_z/2+3*batt_thickness-3])cube([batt_x-10, batt_y-10, batt_z+batt_thickness], center=true);
    }
}
// create the body part
xleg = 40*0.95;  // position outer legs in x
yleg = 110*0.9; // position outer legs in y
wleg = 20;       // Angle of the outer legs
module bodypart(){
     difference(){
          union(){
               translate([0, 5, 0])battery_box();
               difference(){
                    scale([0.9,1.,1.]){
                         linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0){
                              resize([180, 230])circle(d=10, $fn=6);
                         }
                    }
                    anchors_carveout(xleg, yleg, wleg);
                    // carve out the bits for the electronics
                    // POWER boards and power boards
                    //translate([power_pos_x, power_pos_y, 0])power_carveout(1);
                    //translate([-power_pos_x, power_pos_y, 0])power_carveout(power_converter_scale);
                    //translate([-power_pos_x-5, power_pos_y, 0])pcb_carveout(pcb_x_size, pcb_y_size);
                    //raspi
                    //translate([pi_pos_x, pi_pos_y, 0])pi_carveout();    
               }
               // add the motor anchors
               anchors(xleg, yleg, wleg);
               // add power and power boards
               //translate([power_pos_x, power_pos_y, 0])power(1, "u2d2", 3, 0);
               //translate([-power_pos_x, power_pos_y, 0])power(power_converter_scale, "power", 2, 1);
               //translate([-power_pos_x-5, power_pos_y, 0])pcb_board(pcb_x_size, pcb_y_size, "pcb", 2.5, 1);
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
          //translate([ 0, 0,  0])rotate([0, 0, 90])binder();
          //translate([ 15, 0, 0])rotate([0, 0, 90])binder();
          //translate([-15, 0, 0])rotate([0, 0, 90])binder();
          //translate([ 30, 0, 0])rotate([0, 0, -45])binder();
          //translate([-30, 0, 0])rotate([0, 0, -45])binder();
          //translate([-50, 0, 0])binder();
          //translate([ 50, 0, 0])binder();
          
          //translate([-20, 80, 0])binder();
          //translate([  0, 80, 0])binder();
          //translate([ 20, 80, 0])binder();
          
          //translate([-20, -80, 0])binder();
          //translate([  0, -80, 0])binder();
          //translate([ 20, -80, 0])binder();
          
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
          //translate([-55,-45, 0])binder();
          //translate([-55,-30, 0])binder();
          //translate([-55,-15, 0])binder();
          
          
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
}
// add spacers to hub holes
//translate([0, 95, 0])connector_hub_spacers(3);
//translate([0,-95, 0])connector_hub_spacers(3);
//translate([ 60, 35, 0])rotate([0, 0, 90+18])connector_hub_spacers();
//translate([ 60,-45, 0])rotate([0, 0, 90-18])connector_hub_spacers();
//translate([-60, 35, 0])rotate([0, 0, 90-18])connector_hub_spacers();
//translate([-60,-45, 0])rotate([0, 0, 90+18])connector_hub_spacers();

// add raspberry-pi and carve out space for the SD card
//translate([pi_pos_x, pi_pos_y, 0]){
//  difference(){
//    pi();
//    pi_sdcard(pi_frame_height);
//  }
//}

module mount(){
     wx = 4*raster+raster/2;
     wy = 8*raster+raster/2;
     wyp = (wy-m3s_nut_width)/4.0;

     //translate([0., 0., space/2  ])cube([10, 20, space+thickness/2], center=true);
     difference(){
          translate([-wx/2, -wy/2, 0])cube([wx, wy, space+thickness/2]);
          // holes
          translate([0, -wy/4, space+10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          translate([0, +wy/4, space+10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          translate([0, -wy/4, 10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          translate([0, +wy/4, 10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          // nuts 5.4mm x 2.4mm
          translate([0, +wyp, space-3])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 4*m3s_nut_width, m3s_nut_hight], center=false);
          translate([0, -wyp, space-3])rotate([0,0,180])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 4*m3s_nut_width, m3s_nut_hight], center=false);
          translate([0, +wyp, 5])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 4*m3s_nut_width, m3s_nut_hight], center=false);
          translate([0, -wyp, 5])rotate([0,0,180])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 4*m3s_nut_width, m3s_nut_hight], center=false);

     }
}

//module mount(){
//     //translate([0., 0., space/2  ])cube([10, 20, space+thickness/2], center=true);
//     wx = 10;
//     wy = 20;
//     screwdim=3; // m3 screws
//     headlength = 0.6*screwdim/2+0.1;
//     difference(){
//          translate([-wx/2, -wy/2, 0])cube([wx, wy, space+thickness/2]);
//          // holes
//          translate([0, -wy/4, space+10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
//          translate([0, +wy/4, space+10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
//          // m3s nuts
//          translate([0, +wy/4, space-2])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 3*m3s_nut_width, m3s_nut_hight], center=false);
//          translate([0, -wy/4, space-2])rotate([0,0,180])translate([-m3s_nut_width/2, -m3s_nut_width/2, -m3s_nut_hight/2])cube([m3s_nut_width, 3*m3s_nut_width, m3s_nut_hight], center=false);
//     }
//}
// add ventilation grid
difference(){
     bodypart();
     translate([11,0,0]){
          for (iy=[-7:7]){
               for (ix=[-5:1]){
                    translate([10+10.0*ix, iy*10+10.0*0+5*(ix-2*floor(ix/2)), -thickness/2])cylinder(h=4*thickness, r=5, center=true, $fn=6);
               }
          }
     }
}
// add mounts to fix to upper part
pos_x = batt_x/2+2*batt_thickness;
translate([-pos_x, 0, 0])mount();
translate([+pos_x, 0, 0])mount();
