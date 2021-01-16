module screwhole_mX(d){
   height = 40;
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

difference(){
  hull(){
    hull(){
      translate([0, 0, 5])
        cube([50, 7.5, 38], center=true);
      translate([0, 0, -100])
        cylinder(h=40, r=5, center=true);
    }
    translate([0, 0, -130])
    sphere(r=10);
  }
  translate([-16, 4.1, 13]){
    screwhole_mX(2);
  }
  translate([-8, 4.1, 13]){
    screwhole_mX(2);
  }
  translate([0, 4.1, 13]){
    screwhole_mX(2);
  }
  translate([8, 4.1, 13]){
    screwhole_mX(2);
  }
  translate([16, 4.1, 13]){
    screwhole_mX(2);
  }
  translate([-16, 4.1, 5]){
    screwhole_mX(2);
  }
  translate([-8, 4.1, 5]){
    screwhole_mX(2);
  }
  translate([0, 4.1, 5]){
    cube([10,50,6], center=true);
  }
  translate([8, 4.1, 5]){
    screwhole_mX(2);
  }
  translate([16, 4.1, 5]){
    screwhole_mX(2);
  }
  translate([-16, 4.1, -3]){
    screwhole_mX(2);
  }
  translate([-8, 4.1, -3]){
    screwhole_mX(2);
  }
  translate([0, 4.1, -3]){
    screwhole_mX(2);
  }
  translate([8, 4.1, -3]){
    screwhole_mX(2);
  }
  translate([16, 4.1, -3]){
    screwhole_mX(2);
  }
 }
 
translate([0, 0, -140])
sphere(r=10);
