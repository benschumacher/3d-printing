x_diameter = 140;
y_diameter = 120;
edge = 2;
height = 5;

buffer = 0.4;

//foot_diameter = 9.525;
foot_diameter = 9.6;
nub_width = 1;
foot_height = 0.5;

y_radius = y_diameter / 2;
foot_radius = foot_diameter/ 2;

$fn = 64;
module base() {
    x_offset = x_diameter - y_diameter;

    difference() {
        hull() {
            cylinder(h=height, r=y_radius + edge);
            translate([x_offset, 0, 0]) cylinder(h=height, r=y_radius + edge);
        }
        hull() {
            cylinder(h=height+buffer, r=y_radius);
            translate([x_offset, 0, 0]) cylinder(h=height+buffer, r=y_radius);
        }
    }

//    #rotate([0, 0, 30]) translate([0, y_radius - foot_radius, 0]) cylinder(h=0.4, r=foot_radius);
//    #rotate([0, 0, 150]) translate([0, y_radius - foot_radius, 0]) cylinder(h=0.4, r=foot_radius);
    //#foot();
    //#cylinder(h=0.4, r=foot_radius);
    //#rotate([0, 0, 0]) translate([0, y_radius - foot_radius, 0]) translate([x_offset, 0, 0]) cylinder(h=0.4, r=foot_radius);
    // #rotate([0, 0, 45]) translate([x_offset, y_radius - foot_diameter, 0]) cylinder(h=0.4, r=foot_radius);
    // #rotate([0, 0, 135]) translate([x_offset, y_radius - foot_diameter, 0]) cylinder(h=0.4, r=foot_radius);
}

module foot() {
    difference() {
        cylinder(h=foot_height, r=(foot_diameter+buffer+nub_width*2) / 2, $fn=64);
        cylinder(h=foot_height, r=(foot_diameter+buffer) / 2, $fn=64);
    }
}

base();