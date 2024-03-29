width = 10;
depth = 3.5;

tongue_depth = 10;

brace_shelf = 2.8;
brace_height = 30;

$fn = $preview ? 8 : 64;

module brace() {
    // leg
    hull() {
        rotate([0, 90, 0]) cylinder(h=width, d=3);
    //     translate([0, 0, brace_shelf+2.2]) rotate([0, 90, 0]) cylinder(h=width, d=2.5);
        translate([1.4, -0.25, brace_shelf+1.8]) sphere(d=3);
        translate([width-1.4, -0.25, brace_shelf+1.8]) sphere(d=3);
    }

    // tongue
    hull() {
        rotate([0, 90, 0]) cylinder(h=width, d=3);
        translate([0, tongue_depth, 0]) rotate([0, 90, 0]) cylinder(h=width, d=3);
    }

    brace_rear_left = -(tongue_depth+1)-1;
    brace_rear_right = -(tongue_depth+1)-3;

    // brace shelf
    hull() {
        // left
        hull() {
            translate([width-1, (tongue_depth/6), brace_shelf+2.75]) sphere(d=3);
            translate([width-1, brace_rear_left, brace_shelf+2.75]) sphere(d=3);
        }

        // right
        hull() {
            translate([1, (tongue_depth/6), brace_shelf+2.25]) sphere(d=2);
            translate([1, brace_rear_right-0.5, brace_shelf+2.25]) sphere(d=2);
        }
    }

    // back
    hull() {
        // left
        hull() {
            translate([width-1, brace_rear_left, brace_shelf+2.75]) sphere(d=2);
            translate([width-1, brace_rear_left-3, (brace_height*2/3)+2.75]) sphere(d=2);
        }

        // right
        hull() {
            translate([1, brace_rear_right, brace_shelf+2.75]) sphere(d=2);
            translate([1, brace_rear_right-3, (brace_height*2/3)+2.75]) sphere(d=2);
        }
    }

    // triangle left
    hull() {
        translate([width-1, brace_rear_left, brace_shelf+2.75]) sphere(d=3);
        translate([width-1, brace_rear_left+3, brace_shelf+2.75]) sphere(d=3);
        translate([width-1, brace_rear_left-3, (brace_height*2/3)+2.75]) sphere(d=3);
    }

    // triangle right
    hull() {
        translate([1, brace_rear_right, brace_shelf+2.75]) sphere(d=3);
        translate([1, brace_rear_right+2, brace_shelf+2.75]) sphere(d=3);
        translate([1, brace_rear_right-3, (brace_height*2/3)+2.75]) sphere(d=3);
    }

    // // nub
    // hull() {
    //     translate([width-1, -3.5, brace_shelf+3.75]) sphere(d=4);
    //     translate([1, -1, brace_shelf+3.5]) sphere(d=2);
    // }
}

difference() {
    brace();
    union() {
        translate([-1.9, -20, -10]) cube([2, 40, 40]);
        translate([width-0.1, -20, -10]) cube([2, 40, 40]);
    }
}

//translate([0, tongue_depth/3+1.5, brace_shelf+2.5]) rotate([0, 90, 0]) cylinder(h=width, d=2);