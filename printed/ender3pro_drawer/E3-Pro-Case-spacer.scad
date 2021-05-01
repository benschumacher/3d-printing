length = 10; // 158
width = 10.3;
height = 27.3;
curve = 1;

//translate([-188.2, 114.5, -2.05]) {
//    rotate([0, 0, 90]) import("/Users/bschumacher/Downloads/43134889/files/E3-Pro-Case.stl");
//}

module drawer_spacer() {
    twice_curve = curve * 2;
    
#    hull() {
       translate([0, curve, curve]) rotate([0,90,0]) cylinder(h=length, r=curve,$fn=64);
       translate([0, 1, height-1]) rotate([0,90,0]) cylinder(h=length, r=curve, $fn=64);
        translate([0, twice_curve, 0]) cube(size = [length, width - twice_curve, height]);
    }
}

drawer_spacer();