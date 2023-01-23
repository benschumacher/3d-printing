x = 80;
y = 96;
z = 96;
radius = 2;
base_height = 2;

hex_depth=2;
hex_width=8;
hex_pad=4;

// echo("$FN=", $fn);
// echo("$FS=", $fs);

$fn = $preview ? 8 : 64; 
use <../../modules/hexgrid.scad>

module wall(box=[x, z, hex_depth], width=hex_width, pad=hex_pad) {
    intersection() {
        hexgrid([box[0], box[1], box[2]], width, pad);
        cube([box[0], box[1], box[2]]);
    }
}

module bottom() {
    hull() {
        cylinder(r=radius, h=base_height);
        translate([x, 0, 0]) cylinder(r=radius, h=base_height);
        translate([x, y, 0]) cylinder(r=radius, h=base_height);
        translate([0, y, 0]) cylinder(r=radius, h=base_height);
    }
}

module corners() {
    cylinder(r=radius, h=z);
    translate([x, 0, 0]) cylinder(r=radius, h=z);
    translate([x, y, 0]) cylinder(r=radius, h=z);
    translate([0, y, 0]) cylinder(r=radius, h=z);
}

module top() {
    translate([0, 0, z]) {
        hull() {
            translate([0, 0, 0]) cylinder(r=radius, h=base_height);
            translate([x, 0, 0]) cylinder(r=radius, h=base_height);
        }
        hull() {
            translate([0, y, 0]) cylinder(r=radius, h=base_height);
            translate([x, y, 0]) cylinder(r=radius, h=base_height);
        }
        hull() {
            translate([0, 0, 0]) cylinder(r=radius, h=base_height);
            translate([0, y, 0]) cylinder(r=radius, h=base_height);
        }
        hull() {
            translate([x, 0, 0]) cylinder(r=radius, h=base_height);
            translate([x, y, 0]) cylinder(r=radius, h=base_height);
        }
    }
}

module sides() {
    translate([0, radius/2, 0]) rotate([90, 0, 0]) wall();
    translate([-radius/2, 0, 0]) rotate([90, 0, 90]) wall([z, z, hex_depth]);
    translate([x-radius/2, 0, 0]) rotate([90, 0, 90]) wall([z, z, hex_depth]);
    translate([0, y+radius/2, 0]) rotate([90, 0, 0]) wall();
}

module divider() {
    translate([0, y/3+radius*1.5, base_height]) rotate([90, 0, 0]) union() {
        hex_depth = 1.4;
        wall([x, x, hex_depth]);
        color("red") {
            translate([0, 0, 0]) cube([hex_depth, x, hex_depth]);
            translate([x-hex_depth, 0, 0]) cube([hex_depth, x, hex_depth]);
            translate([0, x-hex_depth, 0]) cube([x-hex_depth, hex_depth, hex_depth]);
        }
    }
}

module unit() {
    bottom();
    translate([0, 0, base_height]) corners();
    top();
    sides();
    divider();
}


// intersection() {
    unit();
    // translate([-radius, -radius, 1.5]) cube([200, 200, 6]);
// }