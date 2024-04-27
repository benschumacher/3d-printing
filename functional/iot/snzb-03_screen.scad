width = 40;
depth = 35;
height = 17.5;

corner_radius = 1;
sensor_radius = 13;

buffer = 0.2;
stiffness = 2.4;
nub_radius = 1;

include <../../modules/roundedcube.scad>

module sonoff_sensor() {
    translate([0, 0, height/2]) roundedcube([width, depth, height], radius = corner_radius, center = true);
    translate([0, 0, height]) sphere(r=sensor_radius-1.5);
}

module screen() {
    screen_width = width + (stiffness * 2) + (buffer * 2);
    screen_depth = depth + stiffness + buffer;
    screen_support_height = height + buffer + stiffness;
    screen_screen_height = screen_support_height + sensor_radius - 2;

    // make the screen sphere shaped
    // translate([width/2, -depth/2+buffer, height]) 
    // sphere(r=sensor_radius);

    // back
    translate([-(stiffness+buffer), 0, 0]) {
        translate([0, 0, 0]) rotate([0, 90, 0]) cylinder(r=nub_radius, h=screen_width);
        roundedcube([screen_width, stiffness, screen_support_height], radius = corner_radius, apply_to="z");
        roundedcube([screen_width, stiffness, screen_screen_height*1.25], radius = corner_radius);
    }

    // right
    translate([0, 0, 0]) rotate([90, 0, 0]) cylinder(r=nub_radius, h=depth);
    translate([-(stiffness+buffer), -(depth+buffer), 0])
    {
        roundedcube([stiffness, screen_depth, screen_support_height], radius = corner_radius, apply_to="z");        
        translate([0, screen_depth/3*2, 0]) roundedcube([stiffness, screen_depth/3, screen_screen_height], radius = corner_radius);        
    }

    // left
    translate([width+buffer, -(depth+buffer), 0]) {
        translate([0, buffer, 0]) rotate([270, 0, 0]) cylinder(r=nub_radius, h=depth);
        roundedcube([stiffness, screen_depth, screen_support_height], radius = corner_radius, apply_to="z");
        translate([0, screen_depth/3-stiffness, 0]) roundedcube([stiffness, screen_depth/3*2+stiffness, screen_screen_height*1.25], radius = corner_radius);
    }

    // top
    translate([width+stiffness-buffer*2, stiffness-stiffness/2, screen_screen_height-stiffness-buffer/2]) {
        linear_extrude(stiffness/2)
            polygon(points = [[0, 0], [0, -(screen_depth/3*2)], [-screen_width+stiffness, -(screen_depth/3)+stiffness], [-screen_width+stiffness, 0]]);
    }
}

if ($preview) {
    sonoff_sensor();
}

difference() {
    translate([-width/2, depth/2+buffer, 0]) screen();
    translate([0, 0, -1]) cube([200, 200, 2], center=true);
}
