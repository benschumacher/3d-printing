hole_center = 39;
hole_dia = 4;
height = 2.2;
stiffness = 6;
buffer = 0.2;
minkowski_rounding = 0.5;

hole_rad = (hole_dia / 2) + buffer + minkowski_rounding;
body_rad = hole_rad + stiffness;

screw_hole_fn = $preview ? 8 : 64;

if ($preview) {
    clip();
}
else {
    minkowski() {
        clip();
        sphere(minkowski_rounding);
    }
}

mid_offset_x = (hole_center / 2);  // halfway between the hole
mid_offset_y = stiffness * 0.5; // 50% offset towards y
mid_rad = stiffness * 3 / 4; // 75% of the thickness around the hooks

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
        translate([0, 0, -buffer / 2]) {
            // cut out the holes and hooks
            hull() {
                cylinder(r = hole_rad, h = height + buffer);
                translate([-mid_offset_x, mid_offset_y + body_rad, 0]) cylinder(r = body_rad, h = height + buffer);
            }
            hull() {
                translate([-hole_center, 0, 0]) cylinder(r = hole_rad, h = height + buffer);
                translate([-mid_offset_x, mid_offset_y + body_rad, 0]) cylinder(r = body_rad, h = height + buffer);
                translate([-mid_offset_x * 1.25, mid_offset_y + body_rad, 0]) cylinder(r = body_rad, h = height + buffer);
            }
        }
    }
}