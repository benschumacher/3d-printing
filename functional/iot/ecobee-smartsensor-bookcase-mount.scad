
$fn = $preview ? 8 : 128;

// dimensions for bracket
buffer = 0.2;
stiffness = 1.6;
bracket_height = 22;

// approximate
ecobee_sensor_width = 40;
ecobee_sensor_height = 40;
ecobee_sensor_depth = 26.5;

// beam width is consistent
beam_width = 17.75 + buffer;

// horizontal beam
hbeam_height = 40 + buffer;
hbeam_width = beam_width;

// vertical beam
vbeam_depth = 40.5 + buffer;
vbeam_front_rad = 9.5 + (buffer/2);
vbeam_width = beam_width;

// bracket
brace_left_width = stiffness;
brace_left_depth = (vbeam_depth - vbeam_front_rad) + (buffer * 2);
brace_left_height = bracket_height;

brace_rear_width = vbeam_width + (buffer * 2);
brace_rear_depth = stiffness;
brace_rear_height = bracket_height;

brace_front_rad = vbeam_front_rad + (buffer * 2);
brace_front_height = bracket_height;

bracket_gap = (vbeam_depth - vbeam_front_rad) - (stiffness * 6);


module shelf() {
    translate([0, -100, 0]) cube([hbeam_width, 100, hbeam_height]);
    intersection() {
        cube([vbeam_width, vbeam_depth, 100], center=false);
        union() {
            cube([vbeam_width, vbeam_depth - vbeam_width/2, 100], center=false);
            translate([vbeam_width/2, vbeam_depth - vbeam_front_rad, 0]) cylinder(r=vbeam_front_rad, h=100);
        }
    }
}

module ecobee_and_shelf() {
    if ($preview) {
        color("silver") translate([-ecobee_sensor_width/2, -ecobee_sensor_depth/2, 16]) cube([ecobee_sensor_width, ecobee_sensor_depth,  ecobee_sensor_height]);
        color("grey") translate([-ecobee_sensor_width, -(vbeam_depth - ecobee_sensor_depth/2), -hbeam_height]) shelf();
    }
}

module vbeam_bracket() {
    union() {
        difference() {
            intersection() {
                translate([0, -stiffness, 0]) cube([vbeam_width + (stiffness * 2), vbeam_depth + (stiffness * 2), bracket_height]);
                union() {
                    translate([0, -stiffness, 0]) cube([vbeam_width + (stiffness * 2), vbeam_depth - vbeam_width/2, bracket_height]);
                    translate([(vbeam_width + stiffness * 2)/2, vbeam_depth - (vbeam_front_rad), 0]) cylinder(r=(vbeam_front_rad + stiffness), h=bracket_height);
                }
            }
            translate([stiffness, 0, -hbeam_height]) shelf();
            translate([-buffer/2, stiffness * 1, -buffer/2]) cube([stiffness + buffer, bracket_gap, bracket_height + buffer]);
        }
        translate([stiffness / 2, stiffness * 1, 0]) cylinder(r=stiffness / 2, h=bracket_height);
        translate([stiffness / 2, bracket_gap + stiffness * 1, 0]) cylinder(r=stiffness / 2, h=bracket_height);
    }

    // cube([brace_left_width, brace_left_depth, brace_left_height]);
    // translate([-brace_rear_width, 0, 0]) cube([brace_rear_width, brace_rear_depth, brace_rear_height]);
    // translate([-(brace_front_rad - stiffness), brace_left_depth, 0]) difference() {
    //     cylinder(r=brace_front_rad, h=brace_front_height, center=false);
    //     translate([0, 0, -0.1]) cylinder(r=(brace_front_rad - stiffness), h=brace_front_height + buffer, center=false);
    //     translate([-(brace_front_rad + buffer), -(brace_front_rad + buffer), -0.1]) cube([brace_rear_width + stiffness * 2, brace_front_rad + buffer, brace_front_height + buffer]);
    // }
    // difference() { 
    //     #translate([-(brace_front_rad * 2 - stiffness), 0, 0]) cube([brace_left_width, brace_left_depth, brace_left_height]);
    //     translate([-(brace_front_rad * 2 - stiffness) - 0.1, stiffness * 3, -0.1]) cube([brace_left_width + buffer, brace_left_depth - stiffness * 4, brace_left_height + buffer]);
    // }
}

module ecobee_stand() {
    translate([0, 0, (bracket_height * 11/16)]) cylinder(r=2.43, h = 4, $fn=8);
    intersection() {
        hull() {
            translate([-19.5, 0, -10]) rotate([0, 37.50, 0]) cylinder(r1=2.43 * 1.25, r2=2.43 * 1.25, h=50, $fn = 64);
            translate([-ecobee_sensor_width/2, 2, 0]) cylinder(r=4, h=bracket_height * 11/16);
            translate([-ecobee_sensor_width/2, -2, 0]) cylinder(r=4, h=bracket_height * 11/16);
        }
        #translate([-21.0, -5, 0]) cube([ecobee_sensor_width / 2 + 5, 10, bracket_height * 11/16]);
    }
    //cube([2.43 * 2, 2.43 * 2, 2.43 * 2], center=true);
}

ecobee_and_shelf();
intersection() {
    union() {
        translate([-(ecobee_sensor_width + stiffness), -(vbeam_depth - ecobee_sensor_depth/2), 0]) vbeam_bracket();
        ecobee_stand();
    }
    // translate([-200, -200, bracket_height * 5/8]) cube([400, 400, bracket_height / 4], center=false);
}

//import("Ecobee_SmartSensor_Stand.stl");
