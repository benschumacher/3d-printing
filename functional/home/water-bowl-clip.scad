hole_center = 40;
hole_dia = 4;
height = 2;
stiffness = 6;
buffer = 0.2;

hole_rad = (hole_dia / 2) + buffer;
body_rad = hole_rad + stiffness;

$fn = $preview ? 8 : 64;

if ($preview) {
    clip();
}
else {
    minkowski() {
        clip();
        sphere(height / 4);
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
                translate([-mid_offset_x * 1.5, mid_offset_y + body_rad, 0]) cylinder(r = body_rad, h = height + buffer);
            }
        }
    }
}