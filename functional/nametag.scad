include <../modules/roundedcube.scad>;

width = 39;
depth = 10;
thickness = 1.8;
corner_r = depth * 0.20;
buffer = 0.2;
bevel_w = 2;
font="Liberation Sans:style=Bold";
name = "JJ";

$fn = $preview ? 8 : 128;

module corner(w, d, t, corner_r) {
    difference() {
        cube([w, d, t]);
        translate([w, d, -buffer/2]) cylinder(r=corner_r, h=t+buffer);
    }
}

module nameplate(w, d, t, corner_r) {
    // corner_w = w/2;
    // corner_d = d/2;
    // corner_t = t;

    // union() {
    //     corner(corner_w, corner_d, corner_t, corner_r);
    //     mirror([1, 0, 0]) corner(corner_w, corner_d, corner_t, corner_r);
    //     mirror([0, 1, 0]) corner(corner_w, corner_d, corner_t, corner_r);
    //     mirror([0, 1, 0]) mirror([1, 0, 0]) corner(corner_w, corner_d, corner_t, corner_r);
    // }

    roundedcube([w, d, t], center=true);
}

difference() {
    hole_r = 1.2;
    hole_offset = width - (bevel_w + (hole_r * 2));

    nameplate(width, depth, thickness, corner_r);
    translate([0, 0, thickness - buffer * 2]) nameplate(width - bevel_w, depth - bevel_w, thickness, corner_r);
    translate([hole_offset / 2, 0, -buffer/2]) cylinder(r=hole_r, h=thickness + buffer, center=true);
    translate([-hole_offset / 2, 0, -buffer/2]) cylinder(r=hole_r, h=thickness + buffer, center=true);
}

translate([0, 0, (thickness / 2) - buffer * 2]) linear_extrude(height = buffer * 2)  text(text=name, font=font, halign="center", valign="center", size=5);