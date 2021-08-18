hole_center = 40;
hole_dia = 4;
height = 20;
stiffness = 10;
buffer = 0.2;

hole_rad = (hole_dia / 2) + buffer;
body_rad = hole_rad + stiffness;

screw_hole_fn = $preview ? 8 : 64;

clip();

module clip_body() {
    mid_offset_x = hole_center / 2;  // halfway between the hole
    mid_offset_y = stiffness * 0.50; // 50% offset towards y
    mid_rad = stiffness * 3 / 4; // 75% thicker than around the hooks

    hull() {
        cylinder(r = body_rad, h = height);
        translate([-mid_offset_x, mid_offset_y, 0]) cylinder(r = mid_rad, h = height);
    }
    hull() {
        translate([-mid_offset_x, mid_offset_y, 0]) cylinder(r = mid_rad, h = height);
        translate([-hole_center, 0, 0]) cylinder(r = body_rad, h = height);
    }
}

module clip() {
    difference() {
        clip_body();
        // cut out the center holes
        cylinder(r = hole_rad, h = height + buffer);
        translate([-hole_center, 0, 0]) cylinder(r = hole_rad, h = height + buffer);
        // cut out the hooks
    }
}