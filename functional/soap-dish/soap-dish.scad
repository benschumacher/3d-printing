include <../modules/roundedcube.scad>;

length = 122; // 158
width = 98;
height = 16;
curve = 3;
edge_width = 4;

//translate([-188.2, 114.5, -2.05]) {
//    rotate([0, 0, 90]) import("/Users/bschumacher/Downloads/43134889/files/E3-Pro-Case.stl");
//}

$fn = 64;
//$fs = 0.01;
module soap_dish(x, y, z, r) {
    ew = edge_width;
    shelf_z = (z) / 2;
    shelf_r_bot = ew * 2;
    shelf_r_top = ew * 3;
    ew_x2 = ew * 2;
    ew_x3 = ew * 3;

    difference() {
        roundedcube([x + ew_x2, y + ew_x2, z], radius= r, apply_to = "zmin");
        translate([ew, ew, ew]) roundedcube([x, y, z + ew], radius = r / 2, apply_to = "zmin");
    }
    
#    translate([ew, ew, 0])         cylinder(shelf_z, shelf_r_bot, shelf_r_top);
#    translate([ew, ew, 0])         cylinder(z*2, r, r);
    translate([ew, y + ew, ew])     cylinder(shelf_z, shelf_r_bot, shelf_r_top);
    translate([x + ew, ew, ew])     cylinder(shelf_z, shelf_r_bot, shelf_r_top);
    translate([x + ew, y + ew, ew]) cylinder(shelf_z, shelf_r_bot, shelf_r_top);
}

intersection() {
    soap_dish(length, width, height, curve);
    
//    # translate([0, 0, ((edge_width + height) / 2) - 0.4]) cube([length + (edge_width * 2), width + (edge_width * 2), 0.8], center=false);
}
