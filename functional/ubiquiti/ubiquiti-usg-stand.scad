usg_width = 28.5;
usg_width_feet = 29.25;
usg_depth_to_feet = 21.5;
usg_depth = 135.1;
usg_height = 135.1;
usg_corner_fillet = 10;
usg_corner_fillet_rad = usg_corner_fillet / 2;
usg_mounthole_front = 65.5;
usg_mounthole_bottom = 16.25;
usg_mounthole_diameter = 3;

echo("USG_DEPTH=", usg_depth);
echo("USG_DEPTH_HALF=", usg_depth/2);

//foot_diameter = 9.525;

stiffness = 1.6;
tolerance = 0.6;
clearance = 3;

foot_depth = 22;
foot_width = 24;
foot_height = 30;

grip_height = 0.4;
grip_depth = grip_height * 4;

use <../../modules/roundedcube.scad>;

$fn = $preview ? 8 : 64;

module usg() {
    difference() {
        translate([usg_width, 0, 0]) rotate([0, -90, 0]) hull() {
            // bottom front
            translate([usg_corner_fillet_rad, usg_corner_fillet_rad, 0]) cylinder(h=usg_width, d=usg_corner_fillet);
            translate([usg_height - usg_corner_fillet_rad, usg_corner_fillet_rad, 0]) cylinder(h=usg_width, d=usg_corner_fillet);
            translate([usg_corner_fillet_rad, usg_height - usg_corner_fillet_rad, 0]) cylinder(h=usg_width, d=usg_corner_fillet);
            translate([usg_height - usg_corner_fillet_rad, usg_height - usg_corner_fillet_rad, 0]) cylinder(h=usg_width, d=usg_corner_fillet);
        }
        //cube([usg_width, usg_depth, usg_height], center=false);
        union() {
            translate([usg_width, usg_depth / 2, usg_mounthole_bottom + usg_mounthole_diameter]) {
                //translate([-50, 0, 6]) rotate([0, 90, 0]) cylinder(h=100, r=0.5);
                hull() {
                    rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
                    translate([0, 0, 12]) rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
                }
                hull() {
                    translate([0, 6, 6]) rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
                    translate([0, -6, 6]) rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
                }
            }
        }
    }
}

module foot_bumper() {
    foot_diameter = 9.525;
    //foot_diameter = 8;
    buffer = 0.6;
    nub_width = 1;
    foot_height = 0.5;

    difference() {
        rotate([90, 0, 0]) cylinder(h=foot_height, r=(foot_diameter+buffer+nub_width*2) / 2);
        rotate([90, 0, 0]) cylinder(h=foot_height, r=(foot_diameter+buffer) / 2, $fn=64);
    }
}

module usg_feet() {
    feet_width = foot_width * 2 + usg_width + tolerance * 2;
    usg_carveout_width = usg_width + tolerance * 2;

    translate([-(foot_width + tolerance), -stiffness, 0]) 
    difference() {
        cube([feet_width, foot_depth, foot_height]);
        translate([-stiffness, 0, foot_height + stiffness]) resize([foot_width * 2, foot_depth, foot_height * 2]) rotate([-90, 0, 0]) cylinder(h=foot_depth, d=foot_width / 2);
        translate([feet_width + stiffness, 0, foot_height + stiffness]) resize([foot_width * 2, foot_depth, foot_height * 2]) rotate([-90, 0, 0]) cylinder(h=foot_depth, d=foot_width / 2);
        translate([foot_width + tolerance, 0, 0]) cube([usg_width, foot_depth, clearance]);

        // usg carveout
        translate([foot_width, stiffness, stiffness + clearance]) resize([usg_carveout_width, usg_height, usg_depth + tolerance]) usg();
        translate([foot_width + usg_carveout_width/2, 0, foot_height]) rotate([-90, 0, 0]) resize([usg_width + - stiffness, foot_height * 1.25, foot_height * 2]) cylinder(h=foot_depth, d=usg_width - stiffness * 2);
    }

    translate([-tolerance, foot_depth - stiffness, 0]) rotate([0, 0, -90]) linear_extrude(height = foot_height, convexity = 10) polygon(points = [[0,0], [grip_depth/2,grip_height], [grip_depth,0], [grip_depth,-0.1], [0,-0.1]]);
    translate([usg_carveout_width - tolerance, foot_depth - stiffness - grip_depth, 0]) rotate([0, 0, 90]) linear_extrude(height = foot_height, convexity = 10) polygon(points = [[0,0], [grip_depth/2,grip_height], [grip_depth,0], [grip_depth,-0.1], [0,-0.1]]);
    #translate([-foot_width / 2, -stiffness + foot_depth / 2, 0]) rotate([90, 0, 0]) foot_bumper();
    #translate([-foot_width / 2 + usg_carveout_width + foot_width, -stiffness + foot_depth / 2, 0]) rotate([90, 0, 0]) foot_bumper();
}

if ($preview) { translate([0, 0, stiffness + clearance]) color("white") usg(); }
translate([0, 0, 1]) usg_feet();