flower_dia = 25;
buffer = 2;
thickness = 2.2;
lip_rad = thickness * 2;
shelf_irad = (flower_dia / 2) + buffer;
shelf_orad = (flower_dia / 2) + buffer + thickness;

width = 40;
height = 28.2;
front_height = 10.2;
groove = 8;
curve = 0.5;

include <../../modules/screw_holes.scad>
screw_hole_fn = $preview ? 8 : 64;

$fn = screw_hole_fn;

difference() {
    union() {
        shelf();
        translate([0, -(shelf_irad - thickness), shelf_irad])
          rotate(90, [1, 0, 0])
            back();
    }
    translate([-50, -50, -100])
      cube(100);
    translate([0, -(shelf_irad - thickness), shelf_irad])
      rotate(90, [1, 0, 0])
        #screw_hole(DIN965, M3, 10);
}


module shelf() {
    cylinder(r=shelf_irad, h=thickness);
    translate([-shelf_irad, -shelf_irad, 0])
      resize([0, shelf_irad, thickness])
        cube((shelf_irad * 2));
    translate([0, 0, thickness])
      rotate_extrude(angle=180, convexity=10) 
        translate([shelf_irad, 0, 0])
          resize([lip_rad, lip_rad * 2, 0])
            circle(r=lip_rad);
    translate([-shelf_irad, 0, thickness])
      rotate(90, [1, 0, 0])
        resize([lip_rad, lip_rad * 2, 0]) 
          cylinder(r=lip_rad, h=shelf_irad);
    translate([shelf_irad, 0, thickness])
      rotate(90, [1, 0, 0])
        resize([lip_rad, lip_rad * 2, 0]) 
          cylinder(r=lip_rad, h=shelf_irad);
}

module back() {
   cylinder(r=shelf_orad, h=thickness);
   translate([-shelf_orad, -shelf_orad, 0])
      resize([0, shelf_orad, thickness])
        cube((shelf_orad * 2));
}