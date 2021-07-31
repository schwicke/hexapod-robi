
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

module nuthole_mX(d){
   s = (d==2) ? 4: (d==2.5)? 5: (d==3) ? 5.5: 0.0;
   if (s==0){
     echo ("Nut size not supported");
   }
   echo(s);
   e = s/sin(60.0);
   height = 40;
   headlength = 0.6*d/2+0.1;
   translate([0, 0, -5*headlength]){
     translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
     cylinder(h=10*headlength, d=e+0.1, center=true, $fn=6);
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
module leg(radius){
     cylinder(h=z, r=radius, center=false, $fn=fn);
     sphere(r=radius, $fn=fn);
}

//translate([0,0,-z])leg();
//cylinder(h=4, r=rad+1, center=true, $fn=fn);
//sphere(r=rad-2, $fn=fn);
thickness=3;
module half_shell(){
     difference(){
          union(){
               difference(){
                    sphere( r=rad+1.2+thickness, $fn=fn);
                    sphere(r=rad+1.2, $fn=fn);
               };
               translate([-rad-5,0,0])cube([7,7,10], center=true);
               translate([+rad+5,0,0])cube([7,7,10], center=true);
          }
          translate([0,0,rad])cube([30,30,10], center=true);
          translate([0,0,-30])leg(rad+0.2);
          #translate([0,rad,-5])cube([2.1,2.1,7], center=true);
     }
}

difference(){
     half_shell();
     //#translate([-rad-5,0,-4])rotate([90,180,0])screwhole_mX(2);
     //#translate([+rad+5,0,-4])rotate([90,180,0])screwhole_mX(2);
     #translate([-rad-5,0,-3])rotate([00,00,30])nuthole_mX(2);
     #translate([+rad+5,0,-3])rotate([00,00,30])nuthole_mX(2);
}

//translate([0,0,10])baseelement();

