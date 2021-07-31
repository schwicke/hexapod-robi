// Bohrhilfe
hub_hole_diameter = 2;
hub_spacer_height = 2;
hub_raster =  2.54;
hub_y = 5.75+0.2;
hub_x = 7.4+0.2;
dist = 4.5*hub_raster;
module screwhole_mX(d, height, fact){
   headlength = 0.6*d/2+0.1;
   translate([0, 0, headlength/2]){
        translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
        cylinder(h=10*fact*headlength, r=d+0.1, center=true, $fn=50);
   }
}

module nuthole_mX(d){
   s = (d==2) ? 4: (d==2.5)? 5: (d==3) ? 5.5: 0.0;
   if (s==0){
     echo ("Nut size not supported");
   }
   e = s/sin(60.0);
   height = 40;
   headlyength = 0.6*d/2+0.1;
   translate([0, 0, -5*headlength]){
     translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
     translate([0, 0, -1.5])cylinder(h=10*headlength, d=e+0.1, center=true, $fn=6);
   }
}

module connector_hub(mode){
  translate([-dist, 0, -5])if (mode==0) screwhole_mX(hub_hole_diameter, 10.0, 1.0); else nuthole_mX(hub_hole_diameter);
  translate([+dist, 0, -5])if (mode==0) screwhole_mX(hub_hole_diameter, 10.0, 1.0); else nuthole_mX(hub_hole_diameter);
}

module box(dist){
     length=38;
     width=14;
     height=10;
     thickness=2.5;
     difference(){
          cube([length, width, height], center=true);
          // connector hole
          cube([hub_x+0.1, hub_y+0.1, 20], center=true);
          //carve out to create a box
          translate([0, 0, 2.5])cube([length-thickness, width-thickness, height], center=true);
          //carve out to connect the sensor
          #translate([0, hub_y, 4])cube([2*hub_x, 2*hub_y, 4], center=true);
     }
     translate([-dist, 0, 0])cylinder(h=5, r=3, center=true, $fn=50);
     translate([+dist, 0, 0])cylinder(h=5, r=3, center=true, $fn=50);
}

// drilling helpers for 2 and 3 connectors
difference(){
     box(dist);
     connector_hub(0);
}

