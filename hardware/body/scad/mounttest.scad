// global parameters
thickness = 4;
delta=0.4;
// motors
space = 5.2; // motor hight
screwdim=3; // m3 screws
nut_width=5.4+delta;
nut_hight=2.4+delta;

module mount(){
     //translate([0., 0., space/2  ])cube([10, 20, space+thickness/2], center=true);
     wx = 10;
     wy = 20;
     difference(){
          translate([-wx/2, -wy/2, 0])cube([wx, wy, space+thickness/2]);
          // holes
          translate([0, -wy/4, space+10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          translate([0, +wy/4, space+10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          // nuts 5.4mm x 2.4mm
          translate([0, +wy/4+delta, space-2])translate([-nut_width/2, -nut_width/2, -nut_hight/2])cube([nut_width, 3*nut_width, nut_hight], center=false);
          translate([0, -wy/4-delta, space-2])rotate([0,0,180])translate([-nut_width/2, -nut_width/2, -nut_hight/2])cube([nut_width, 3*nut_width, nut_hight], center=false);

     }
}
mount();
