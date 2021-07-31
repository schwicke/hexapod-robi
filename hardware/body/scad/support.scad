// global parameters
thickness = 4;
delta=0.4;
raster =  2.54;
// motors
space = 42.0;// motor hight 
screwdim=3; // m3 screws
nut_width=5.4+delta;
nut_hight=2.4+delta;

wx = 4*raster+raster/2;
wy = 8*raster+raster/2;
wyp = (wy-nut_width)/4.0;
module mount(){
     //translate([0., 0., space/2  ])cube([10, 20, space+thickness/2], center=true);
     difference(){
          translate([-wx/2, -wy/2, 0])cube([wx, wy, space+thickness/2]);
          // holes
          translate([0, -wy/4, space+10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          translate([0, +wy/4, space+10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          translate([0, -wy/4, 10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          translate([0, +wy/4, 10])cylinder(h=50, r=screwdim/2+0.1, center=true, $fn=50);
          // nuts 5.4mm x 2.4mm
          translate([0, +wy/4-nut_width/4, space-3])translate([-nut_width/2, -nut_width/2, -nut_hight/2])cube([nut_width, 4*nut_width, nut_hight], center=false);
          translate([0, -wy/4+nut_width/4, space-3])rotate([0,0,180])translate([-nut_width/2, -nut_width/2, -nut_hight/2])cube([nut_width, 4*nut_width, nut_hight], center=false);
          translate([0, +wy/4-nut_width/4, 5])translate([-nut_width/2, -nut_width/2, -nut_hight/2])cube([nut_width, 4*nut_width, nut_hight], center=false);
          translate([0, -wy/4+nut_width/4, 5])rotate([0,0,180])translate([-nut_width/2, -nut_width/2, -nut_hight/2])cube([nut_width, 4*nut_width, nut_hight], center=false);

     }
}
mount();
