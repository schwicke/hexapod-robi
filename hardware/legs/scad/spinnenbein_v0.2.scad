module screwhole_mX(d){
   height = 10;
   headlength = 0.6*d/2+0.1;
   translate([0,2,0]){
     rotate([90, 0, 0]){
       translate([0, 0, headlength/2]){
         translate([0, 0, height/2])
         cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
         cylinder(h=10*headlength, r=d+0.1, center=true, $fn=50);
       }
     }
   }
}

module baseelement(){
     difference(){
       union(){
         difference(){
         translate([0, 0, -4])cube([38, 25, 9], center=true);
         cube([32+0.2, 50, 9], center=true);
         };
       }
       #translate([-19, -8, -2])rotate([0,0,90])screwhole_mX(2);
       #translate([-19,  8, -2])rotate([0,0,90])screwhole_mX(2);
       #translate([19, -8, -2])rotate([0,0,-90])screwhole_mX(2);
       #translate([19,  8, -2])rotate([0,0,-90])screwhole_mX(2);
  }
}
z=50;

module leg(){
     rad=6;
     cylinder(h=z, r=rad, center=false, $fn=50);
     sphere(r=rad, $fn=50);
}

module fullthing(){
     difference(){
          union(){
               baseelement();
               translate([0,z/2,-z+2])rotate([30,0,0])leg();
          }
          #cube([32+0.2, 50, 9], center=true);
     }
}

fullthing();
