x_diameter = 140;
y_diameter = 120;
edge = 2;
height = 5;
foot_diameter = 9.6;

y_radius = y_diameter / 2;
foot_radius = foot_diameter/ 2;

$fn = 64;
module base() {
    x_offset = x_diameter - y_diameter;

    hull() {
        cylinder(h=height, r=y_radius);
        translate([x_offset, 0, 0]) cylinder(h=height, r=y_radius);
    }

    hull() {
        cylinder(h=height+0.4, r=y_radius + edge);
        translate([x_offset, 0, 0]) cylinder(h=height+0.4, r=y_radius + edge);

    }

//    #rotate([0, 0, 30]) translate([0, y_radius - foot_radius, 0]) cylinder(h=0.4, r=foot_radius);
//    #rotate([0, 0, 150]) translate([0, y_radius - foot_radius, 0]) cylinder(h=0.4, r=foot_radius);
    #cylinder(h=0.4, r=foot_radius);
    #rotate([0, 0, 0]) translate([0, y_radius - foot_radius, 0]) translate([x_offset, 0, 0]) cylinder(h=0.4, r=foot_radius);
    // #rotate([0, 0, 45]) translate([x_offset, y_radius - foot_diameter, 0]) cylinder(h=0.4, r=foot_radius);
    // #rotate([0, 0, 135]) translate([x_offset, y_radius - foot_diameter, 0]) cylinder(h=0.4, r=foot_radius);
}

base();