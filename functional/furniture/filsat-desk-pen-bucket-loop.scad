arm_depth = 39;
arm_height = 13;
//arm_width = 18;
ring_stiffness = 2.4;
arm_stiffness = 1.2;

filsat_board_width = 17.75;
arm_width = filsat_board_width + (arm_stiffness * 2);

bucket_top_dia = 96;
bucket_base_dia = 75;
bucket_height = 85;

$fn = $preview ? 16 : 128;

use <../../modules/roundedcube.scad>;

intersection() {
    difference() {
        union() {
                translate([0, 0, (-bucket_height)+ring_stiffness]) 
                    cylinder(d1=bucket_base_dia+(ring_stiffness*2), d2=bucket_top_dia+(ring_stiffness*2),h=bucket_height);
                translate([-(bucket_top_dia/2 + arm_width), -(arm_depth/2), (-arm_height+arm_stiffness/2)])
                    cube([arm_width*2, arm_depth, arm_height+arm_stiffness]);
        }

        translate([0, 0, (-bucket_height)+ring_stiffness]) 
            cylinder(d1=bucket_base_dia, d2=bucket_top_dia, h=bucket_height+ring_stiffness);
        translate([-(bucket_top_dia/2 + arm_width/2), 0, -(arm_height/2)])
            roundedcube([filsat_board_width, arm_depth+arm_stiffness, arm_height], center=true, radius=1, apply_to="zmax");
    }
    translate([0, 0, (-arm_height/2)+arm_stiffness]) cube([200, 200, arm_height+arm_stiffness], center=true);
}