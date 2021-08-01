module screwhole_mX_basic(d, height, fact){
     headlength = 0.6*d/2+0.1;
     translate([0, 0, headlength/2]){
          translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
          cylinder(h=10*fact*headlength, r=d+0.1, center=true, $fn=50);
     }
}

module screwhole_mX(d, height, fact){
     headlength = 0.6*d/2+0.1;
     translate([0,2,0]){
          rotate([90, 0, 0]){
               translate([0, 0, headlength/2]){
                    translate([0, 0, height/2])cylinder(h=height, r=d/2+0.1, center=true, $fn=50);
                    cylinder(h=10*fact*headlength, r=d+0.1, center=true, $fn=50);
               }
          }
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
