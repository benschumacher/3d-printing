cs_width = 16;
cs_depth = 54.2;
cs_height = 3;

hook_bottom_height = 25;

edge_thickness = 2;
radius = 2;

translate([60,50,0]) import("/Users/bschumacher/Downloads/DoubleHook.stl");

use <../modules/roundedcube.scad>;

base_width = cs_width + (edge_thickness * 2);
base_depth = cs_depth + (edge_thickness * 2);
base_height = cs_height + (edge_thickness);

difference() {    
    roundedcube([base_width, base_depth, base_height], radius=radius, apply_to="z", center=false);
    translate([edge_thickness, edge_thickness, 0]) cube([cs_width, cs_depth, cs_height], center=false);
}

intersection() {
    #translate([0, radius, cs_height + radius]) cube([base_width, cs_width, hook_bottom_height], center=false);
    
}