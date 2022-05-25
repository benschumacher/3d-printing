height = 80;
width = 18;
depth = 2;

hook_height_top = 18;
hook_height_bot = 0;

stiffness = 1.4;
buffer = 0.4;

clip_height = (height + buffer) + (stiffness * 2);
clip_width = (width + buffer) + (stiffness * 2);
clip_depth = depth;

cutout_height = (clip_height - hook_height_top - hook_height_bot);

difference() {
    cube([clip_width, clip_depth, clip_height]);
    difference() {
        union() {
            translate([stiffness, 0, stiffness]) cube([width + buffer, depth, height + buffer]);
            translate([0, 0, hook_height_bot + stiffness]) cube([stiffness, depth, cutout_height]);
        }
        union() {
            fillet_height_bot = hook_height_bot + stiffness;
            translate([stiffness/2, 0, fillet_height_bot]) rotate([-90, 0, 0]) cylinder(h=depth, r=stiffness / 2, center=false, $fn = 64);
            #translate([stiffness/2, 0, fillet_height_bot + cutout_height]) rotate([-90, 0, 0]) cylinder(h=depth, r=stiffness / 2, center=false, $fn = 64);
        }
    }
}

