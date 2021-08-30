knob_height = 4.75;
knob_od = 7.3;

stiffness = 1.4;
buffer = 0.2;

knob_orad = (knob_od / 2) - buffer;
knob_irad = (knob_od / 2) - stiffness - buffer;
knob_theight = knob_height * 2;
knob_iheight = knob_theight - stiffness + buffer;

$fn = $preview ? 8 : 64;

intersection() {
    knob();
    union() {
        cube_width = 2;
        cube_depth = knob_od + (stiffness * 2);

        translate([0, 0, knob_height]) cylinder(r = knob_orad + stiffness, h = knob_height);
        translate([-cube_width / 2, -cube_depth / 2, 0]) cube([cube_width, cube_depth, knob_height + stiffness]);
        rotate(90, [0, 0, 1]) translate([-cube_width / 2, -cube_depth / 2, 0]) cube([cube_width, cube_depth, knob_height + stiffness]);
    }
}

module knob() {
    difference() {
        union() {
            cylinder(r = knob_orad, h = knob_theight);
            translate([0, 0, knob_height]) cylinder(r1 = knob_orad + stiffness, r2 = knob_orad, h = stiffness);
            translate([0, 0, 0]) cylinder(r1 = knob_orad, r2 = knob_orad + stiffness, h = knob_height - stiffness);

            difference() {
                translate([0, 0, knob_height - stiffness]) cylinder(r = knob_orad + stiffness, h = stiffness);
                translate([0, 0, knob_height - stiffness]) cylinder(r = knob_orad + stiffness - (buffer / 2), h = stiffness);
            }
        }
        translate([0, 0, -(buffer / 2)]) cylinder(r = knob_irad, h = knob_iheight);
    }
}