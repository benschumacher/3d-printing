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

    // brace shelf
    hull() {
        translate([1, -(tongue_depth/2+3)-1, brace_shelf+2.75]) sphere(d=3);
        translate([width-1, -(tongue_depth/2+3)-1, brace_shelf+2.75]) sphere(d=3);
        translate([1, (tongue_depth/6), brace_shelf+2.75]) sphere(d=3);
        translate([width-1, (tongue_depth/6), brace_shelf+2.75]) sphere(d=3);
    }

    // back
    hull() {
        translate([1, -(tongue_depth/2+3.2)-1, (brace_height*2/3)+2.75]) sphere(d=2);
        translate([width-1, -(tongue_depth/2+3.2)-1, (brace_height*2/3)+2.75]) sphere(d=2);
        translate([1, -(tongue_depth/2+3)-1, brace_shelf+2]) sphere(d=2);
        translate([width-1, -(tongue_depth/2+3)-1, brace_shelf+2]) sphere(d=2);
    }

    // triangle right
    hull() {
        translate([1, -(tongue_depth/2+3.2)-1, (brace_height*2/3)+2.75]) sphere(d=2);
        translate([1, -(tongue_depth/2+3)-1, brace_shelf+2.75]) sphere(d=2);
        #translate([1, -(tongue_depth/2+3), brace_shelf+2.75]) sphere(d=2);
    }

    // triangle left
    hull() {
        translate([width-1, -(tongue_depth/2+3.2)-1, (brace_height*2/3)+2.75]) sphere(d=2);
#        translate([width-1, -(tongue_depth/2+3)-1, brace_shelf+2.75]) sphere(d=2);
        translate([width-1, -(tongue_depth/2+2.5), brace_shelf+2.75]) sphere(d=2);
    }

    // nub
    hull() {
        translate([width-1, -3.5, brace_shelf+3.75]) sphere(d=4);
        translate([1, -1, brace_shelf+3.5]) sphere(d=2);
    }
}

difference() {
    brace();
    union() {
        translate([-1.9, -14, -10]) cube([2, 30, 40]);
        translate([width-0.1, -14, -10]) cube([2, 30, 40]);
    }
}

//translate([0, tongue_depth/3+1.5, brace_shelf+2.5]) rotate([0, 90, 0]) cylinder(h=width, d=2);