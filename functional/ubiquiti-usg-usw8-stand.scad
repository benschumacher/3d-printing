usg_width = 28.5;
usg_depth_to_feet = 21.5;
usg_width_feet = 29.25;
usg_depth = 135.1;
usg_height = 135.1;
usg_mounthole_front = 65.5;
usg_mounthole_bottom = 16.25;
usg_mounthole_diameter = 3;

usw860w_width = 29.25;
usw860w_width_feet = 30.5;
usw860w_depth = 100;
usw860w_height = 148;

foot_diameter = 9.525;

support_depth = 8;
support_width = 6;
support_height = 12;

stand_spacer = 12;
base_width = usg_width + usw860w_width + (support_width * 3);
base_depth = max(usg_depth, usw860w_depth);

echo("BASE_WIDTH=", base_width);
echo("BASE_DEPTH=", base_depth);

base_center_x = base_width / 2;
base_center_y = base_depth / 2;

use <../modules/roundedcube.scad>;

module usg() {
    cube([usg_width, usg_depth, usg_height], center=false);
}

module usw860w() {
    cube([usw860w_width, usw860w_depth, usw860w_height], center=false);
}

module foot() {
    cylinder(10, r=foot_diameter/2, center=false);
}
module feet_depressions(count = 4, depth = 0.4) {
    if(count > 0){
        for(i = [1 : 360 / count : 360]) {
            offset = (max(base_width, base_depth) / 2) - foot_diameter;
            rotate([0, 0, i - 90]) 
                translate([offset, 0, -10 + depth])
                    foot($fn=64);
        }
    }
}
module support() {
    rotate([90,0,180]) linear_extrude(height=support_depth) polygon(points=[[0,0],[support_width,0],[0,support_height]], paths=[[0,1,2]]);
}

module stand() {
    difference() {
        //rounded
        cube([base_width, base_depth, 2], center=false, radius=4, apply_to="z");
        translate([base_center_x, base_center_y, 0]) rotate([0, 0, 45]) feet_depressions();
    }
    support();
}

stand();
#translate([0, 0, 0]) usg();
#translate([usw860w_width + stand_spacer, 0, 0]) usw860w();