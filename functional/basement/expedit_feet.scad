// test slice?
test_slice = false;

buffer = 0.4;
center = 13.5;

base_square = 39;
base_height = 15;
supp_width = 4.5;

//import("kallax_bolt.stl");

intersection() {
    union() {
        base();
        if ($preview) {
            translate([19.5-0.2, -0.2, 0]) color("red") cube([0.4, base_square + buffer, 40]);
            translate([-0.2, 19.5-0.2, 0]) color("blue") cube([base_square + 6.5 + supp_width + buffer, buffer, 40]);
        }
    }
    if (test_slice) {
        translate([0, 0, 12.1]) cube([100, 100, 4.0]);
    }

    // #translate([45.2, 0, 0]) cube([0.4, 500, 500], center=true);
    // #translate([0, -0.2, 0]) cube([500, 0.4, 500], center=true);
    // #translate([0, 0,  0.2+15]) cube([500, 500, 0.4], center=true);
}

module base() {
    union() {
        intersection() {
            translate([70.5, 145.4, -16.1]) rotate([0, 0, 180]) import("kallax_base.stl");
            cube([base_square + 6.5, base_square, 15]);
        }
        #translate([base_square, 0, 0]) cube([6.5, base_square, base_height]);
        translate([base_square + 6.5, 0, 0]) cube([supp_width, base_square, base_height + supp_width]);
    }
}