module sidepart(){
  difference(){
    translate([0, -120, 0]){
      xleg = 40*0.95;  // position outer legs in x
      yleg = 110*0.9;  // position outer legs in y
      wleg = 20;       // Angle of the outer legs
      difference(){
        cube([90.0, 245.0, 31.8],center=true);
        union(){
          scale([0.9,1.,1.])linear_extrude(height=thickness, center=true, convexity=0, twist=0, slices=10, scale=1.0)resize([180, 230])circle(d=10, $fn=6);
        // add the motor anchors
          anchors(xleg, yleg, wleg);
        }
        translate([0, -100, 0])cube([150, 50, thickness], center=true);
      }
    }
  }
}
