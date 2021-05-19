usg_width = 28.5;
usg_width_feet = 29.25;
usg_depth_to_feet = 21.5;
usg_depth = 135.1;
usg_height = 135.1;
usg_mounthole_front = 65.5;
usg_mounthole_bottom = 16.25;
usg_mounthole_diameter = 3;
echo(USG_DEPTH=usg_depth);
echo(USG_DEPTH_HALF=usg_depth/2);

usw860w_width = 29.25;
usw860w_width_feet = 30.5;
usw860w_depth = 100;
usw860w_height = 148;

foot_diameter = 9.525;

brace_stiffness = 1.2;
joint_buffer = 0.3;

support_depth = 12;
support_width = 6;
support_height = 19;
support_stiffness = 1.4;
support_carveout_depth = support_depth - (support_stiffness * 2);

support_rear_gap = brace_stiffness + joint_buffer;

base_width = usg_width + usw860w_width + (support_width * 3);
base_depth = max(usg_depth, usw860w_depth); //+ (support_stiffness * 2) + joint_buf;
base_height = 2;

echo("BASE_WIDTH=", base_width);
echo("BASE_DEPTH=", base_depth);

base_center_x = base_width / 2;
base_center_y = base_depth / 2;

use <../modules/roundedcube.scad>;

module usg() {
    difference() {
        cube([usg_width, usg_depth, usg_height], center=false);
        union() {
            $fn = 64;
            translate([usg_width, usg_depth / 2, usg_mounthole_bottom + usg_mounthole_diameter]) {
                #translate([-50, 0, 6]) rotate([0, 90, 0]) cylinder(h=100, r=0.5);
                hull() {
                    rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
                    translate([0, 0, 12]) rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
                }
                hull() {
                  translate([0, 6, 6]) rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
                  translate([0, -6, 6]) rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
                }
            }
            //translate([usg_width, usg_mounthole_front, usg_mounthole_bottom]) rotate([0, 90, 0]) cylinder(h=20, r=usg_mounthole_diameter);
        }
    }
}

module brace_with_foot(brace_depth) {
    radius = (support_stiffness / 2);
    cube([brace_stiffness, brace_depth, support_height]);
    translate([brace_stiffness, 0, radius]) rotate([270, 0, 0]) cylinder(h=brace_depth, r=radius, $fn=64);
}
module brace_verticals(brace_depth, rear_offset) {
//    cube([brace_stiffness, brace_depth, support_height]);
    //cube([brace_stiffness, brace_depth, support_height]);
    brace_with_foot(brace_depth);
    translate([0, rear_offset, 0]) brace_with_foot(brace_depth);
}
module usg_brace() {
    brace_depth = support_carveout_depth - joint_buffer;
    difference() {
        union() {
            brace_verticals(brace_depth=brace_depth, rear_offset=usg_depth - support_depth);
            // front round
            translate([0, brace_depth, support_height]) rotate([0, 90, 0]) cylinder(h=brace_stiffness, r=brace_depth, $fn=64);
            // back round
            translate([0, usg_depth - support_depth, support_height]) rotate([0, 90, 0]) cylinder(h=brace_stiffness, r=brace_depth);
            // cross beam
            translate([0, brace_depth, support_height]) cube([brace_stiffness, usg_depth - support_depth - brace_depth, brace_depth]);
        }
        union() {
            translate([0, brace_depth, -support_height]) roundedcube([brace_stiffness, usg_depth - (support_depth + brace_depth), support_height * 2], radius=3, apply_to="x");
            translate([0, (usg_depth - brace_depth/2)/2, support_height - (2/2) + (brace_depth)/ 2]) cube([brace_stiffness, 2, 2]);
            translate([brace_stiffness/2, (usg_depth - (brace_depth/2) - 2)/2, support_height - (2/2) + (brace_depth)/ 2]) cube([brace_stiffness/2, 4, 2]);
        }
    }
//    #translate([0, brace_depth, support_height]) rotate([0, 90, 0]) cube([brace_stiffness, brace_depth, 0]);
}

module usw860w() {
    cube([usw860w_width, usw860w_depth, usw860w_height], center=false);
}

module foot() {
    radius = (foot_diameter + joint_buffer) / 2;
    cylinder(10, r=(foot_diameter+joint_buffer)/2, center=false);
}
module feet_depressions(depression_depth = 0.4) {
    offset_depth = (base_depth / 2) - (foot_diameter / 2) - support_stiffness;
    offset_width = (base_width / 2) - (foot_diameter / 2) - support_stiffness;
    z = -10 + depression_depth;

    translate([base_center_x, base_center_y, z])
    for (i = [[offset_width, offset_depth, 0],
              [offset_width, -offset_depth, 0],
              [-offset_width, -offset_depth, 0],
              [-offset_width, offset_depth, 0]]) {
        translate(i) foot($fn=64);
    }
}

module support_with_carveout(carveout_depth) {
    difference() {
        rotate([90,0,180]) linear_extrude(height=support_depth) polygon(points=[[0,0],[support_width,0],[0,support_height]], paths=[[0,1,2]]);
        translate([-support_stiffness*2, support_stiffness, 0]) rotate([90, 0, 180]) linear_extrude(height=carveout_depth) polygon(points=[[0,0],[support_width,0],[0,support_height]], paths=[[0,1,2]]);
    }
}

module support() {
    support_carveout_depth = support_depth - (support_stiffness * 2);

    translate([support_width, 0, 0]) difference() {
        support_with_carveout(carveout_depth = support_carveout_depth);

        translate([-(support_stiffness+support_rear_gap),0,0]) union() {
            // bottom gap
            translate([0, support_stiffness, 0]) cube([support_stiffness, support_carveout_depth, support_stiffness]);
            // rear gap
            translate([support_stiffness, support_stiffness, 0]) cube([support_rear_gap+joint_buffer, support_carveout_depth, support_height]);
            // flattop
            translate([-support_stiffness, 0, support_height - 2.8]) cube([support_width, support_depth, 3], center=false);
        }
    }
}

module stand() {
    difference() {
        //rounded
        cube([base_width, base_depth, base_height], center=false, radius=3, apply_to="z");
        union() {
            feet_depressions();

            usg_airgap_width = usg_width;
            usg_airgap_depth = usg_depth - (support_depth * 2);
            usg_airgap_supports = 6;
            translate([support_width, support_depth, 0]) 
            for (i = [0:usg_airgap_supports - 1]) {
                airgep_depth = (usg_airgap_depth - (support_stiffness * (usg_airgap_supports-1))) / usg_airgap_supports;
                y_offset = i * (airgep_depth + support_stiffness);
                echo(I=i);
                echo(Y_OFFSET=y_offset);
                #translate([0, y_offset, 0]) roundedcube([usg_width, airgep_depth, base_height], radius=3, apply_to="z");
            }
//            cube([usg_width, usg_depth - (support_depth * 2), base_height], center=false);
        }
    }

    // left
    translate([0, 0, base_height]) support();
    translate([0, base_depth - support_depth, base_height]) support();

    // middle
    translate([support_width*2 + usg_width, support_depth, base_height]) rotate([0, 0, 180]) support();
    translate([support_width*2 + usg_width, base_depth, base_height]) rotate([0, 0, 180]) support();
    translate([support_width + usg_width, 0, base_height]) support();
    translate([support_width + usg_width, usw860w_depth - support_depth, 2]) support();

    // right
    translate([base_width, support_depth, base_height]) rotate([0, 0, 180]) support();
    translate([base_width, usw860w_depth, base_height]) rotate([0, 0, 180]) support();
}

//intersection() {
    stand();
//    translate([0, 0, (base_height - 0.4)]) cube([base_width, base_depth, 1.2], center=false);
//}
//translate([support_width + usg_width, support_stiffness + (joint_buffer/2), base_height]) usg_brace();
//translate([support_width, 0, base_height]) usg();
//#translate([support_width + usg_width + support_width, 0, base_height]) usw860w();