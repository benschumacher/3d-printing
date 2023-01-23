
height = 11;

inner_diameter = 17.4;
inner_rad = inner_diameter / 2;
inner_height = height;

outer_diameter = 24.7;
outer_rad = outer_diameter / 2;

buffer = 0.2;
buffer_rad = buffer/2;
stiffness = 1.8;

$fn = $preview ? 8 : 64;

use <../../modules/hook_library.scad>

echo("INNER_RAD=", inner_rad-buffer/2);
echo("OUTER_RAD=", outer_rad-buffer/2);

complete();

module complete() {
    soap_cap();
}


module soap_cap() {
    union() {
        outer();
        inner();
    }
}

module inner() {
    difference() {
        cylinder(h=inner_height, r=inner_rad-buffer_rad);
        cylinder(h=inner_height, r=inner_rad-(stiffness*2));
    }
}


module outer() {
    intersection() {
        translate([0, 0, height/2]) cylinderWithFillet(height+(stiffness*2), outer_rad+stiffness+buffer_rad, 1);
        difference() {
            #cylinder(h=height+stiffness, r=outer_rad+stiffness+buffer_rad);
            cylinder(h=height, r=outer_rad-buffer_rad);
        }
    }
}
// minkowski() {
//     difference() {
//         cylinder(h=height+stiffness, r=outer_rad+stiffness+buffer_rad);
//         cylinder(h=height, r=outer_rad-buffer_rad);
//     }
//     #sphere(r=outer_rad);
// }