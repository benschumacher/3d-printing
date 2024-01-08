width = 10;
depth = 3.5;

tongue_depth = 10;

brace_shelf = 2.8;
brace_height = 30;

$fn = $preview ? 8 : 64;

hull() {
    rotate([0, 90, 0]) cylinder(h=width, d=3);
//     translate([0, 0, brace_shelf+2.2]) rotate([0, 90, 0]) cylinder(h=width, d=2.5);
#    translate([1, -1, brace_shelf+2.5]) sphere(d=2);
#    translate([width-1, -1, brace_shelf+2.5]) sphere(d=2);
}

hull() {
    rotate([0, 90, 0]) cylinder(h=width, d=3);
    translate([0, tongue_depth, 0]) rotate([0, 90, 0]) cylinder(h=width, d=3);
}

hull() {
    translate([1, -(tongue_depth/2+1.5)-1, brace_shelf+2.5]) sphere(d=2);
    translate([width-1, -(tongue_depth/2+1.5)-1, brace_shelf+2.5]) sphere(d=2);
    translate([1, (tongue_depth/2+1.5), brace_shelf+2.5]) sphere(d=2);
    translate([width-1, (tongue_depth/2+1.5), brace_shelf+2.5]) sphere(d=2);
}

hull() {
    translate([1, -2.5, (brace_height*2/3)+2.5]) sphere(d=2);
    translate([width-1, -2.5, (brace_height*2/3)+2.5]) sphere(d=2);
    translate([1, -1, brace_shelf+2.5]) sphere(d=2);
    translate([width-1, -1, brace_shelf+2.5]) sphere(d=2);
}

hull() {
    translate([1, -(tongue_depth/2+1.5)-1, brace_shelf+2.5]) sphere(d=2);
    translate([1, -2.5, (brace_height*2/3)+2.5]) sphere(d=2);
    translate([1, -1, brace_shelf+2.5]) sphere(d=2);
}

hull() {
    translate([width-1, -(tongue_depth/2+1.5)-1, brace_shelf+2.5]) sphere(d=2);
    translate([width-1, -2.5, (brace_height*2/3)+2.5]) sphere(d=2);
    translate([width-1, -1, brace_shelf+2.5]) sphere(d=2);
}

//translate([0, tongue_depth/3+1.5, brace_shelf+2.5]) rotate([0, 90, 0]) cylinder(h=width, d=2);