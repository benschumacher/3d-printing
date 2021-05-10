// commnad strip width
cs_width = 18.2;

// command strip depth
cs_depth = 70.2;

// command strip height
cs_height = 3;

// hook depth
hook_depth = 44;
// hook thickness
hook_thickness = 4;
// hook height multiplier
hook_multiplier = 0.66;
// upper hook multiplier
upper_hook_multiplier = 0.70;
// hook height
hook_height = hook_depth * hook_multiplier;

// edge thickness
edge_thickness = 2;
// corner radius
radius = 2;

//translate([60,50,0]) import("/Users/bschumacher/Downloads/DoubleHook.stl");

use <../modules/roundedcube.scad>;

base_width = cs_width + (edge_thickness * 2);
base_depth = cs_depth + (edge_thickness * 2);
base_height = cs_height + (edge_thickness);

// resolution
$fn = 64;

difference() {    
    roundedcube([base_width, base_depth, base_height], radius=radius, apply_to="z", center=false);
    translate([edge_thickness, edge_thickness, 0]) cube([cs_width, cs_depth, cs_height], center=false);
}

hook_orad = hook_depth / 2;
//#translate([0, hook_orad, base_height+hook_thickness]) rotate([0, 90, 0]) cylinder(h=base_width, r=1);
//translate([0, hook_orad+hook_thickness+1, base_height+1]) rotate([0, 90, 0]) cylinder(h=base_width, r=1);

difference() {
    intersection() {
        union() {
            translate([0, hook_orad, base_height+hook_thickness]) rotate([0, 90, 0]) cylinder(h=base_width, r=hook_orad);
            translate([0, 0, base_height]) cube([base_width, hook_thickness, hook_thickness], center=false);
        }
        translate([0, 0, base_height]) roundedcube([base_width, hook_height, hook_depth], radius=radius, apply_to="z", center=false);
    }

    translate([-24, hook_orad, base_height+hook_thickness]) rotate([0, 90, 0]) cylinder(h=48, r=hook_orad-hook_thickness);
}

offset = base_depth * upper_hook_multiplier;
translate([0, offset, 0]) intersection() {
    #translate([0, -offset, cs_height]) roundedcube([base_width, base_depth-edge_thickness, hook_height], radius=radius, apply_to="z", center=false);
    translate([0, 0, 0]) rotate([45,0,0]) roundedcube([base_width, hook_height+1, hook_thickness], radius=radius, apply_to="z", center=false);
}

//#roundedcube([base_width, hook_bottom_height*0.75, 2], radius=radius, apply_to="z", center=true);
