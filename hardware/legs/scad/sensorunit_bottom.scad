
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
rad=6;
fn=150;
module leg(){
     cylinder(h=z, r=rad, center=false, $fn=fn);
     sphere(r=rad, $fn=fn);
}

translate([0,0,-z])leg();

difference(){
     sphere(r=rad+1, $fn=fn);
     translate([0,0,rad])cube([20,20,10], center=true);
}
translate([rad-0.2,0,-8.5-3.5+4])cube([2.,2.,7], center=true);

//difference(){
//     translate([0,0,rad-9])sphere(r=rad, $fn=fn);
//     translate([0,0,rad+1])cube([20,20,10], center=true);
//}
