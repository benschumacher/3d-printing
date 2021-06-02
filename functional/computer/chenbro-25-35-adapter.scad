stiffness = 2;
tolerance = 0.4;

twohalf_bracket_tab_height = 1.5;
twohalf_bracket_width = 100;

twohalf_hole_front_offset = 8;
twohalf_hole_back_offset = 12.5;
twohalf_hole_z_offset = 4.5;
twohalf_hole_distance = 73.5;

bracket_height = 10;
inside_dia = 2;
inside_rad = inside_dia / 2;

threehalf_drive_width = 146.5;
threehalf_drive_depth = 102;
threehalf_hole_width = 102.5;
threehalf_hole_height = 6.5;
threehalf_bracket_width = twohalf_hole_back_offset + threehalf_hole_width + twohalf_hole_back_offset;

gap_depth = 19;

hole_dia = 3;
hole_rad = (hole_dia / 2) + tolerance / 2;

$fn = $preview ? 8 : 64;

module screw_hole() {
    cylinder(h=stiffness + tolerance, r=hole_rad);
}

module twohalf_bracket() {
    back_offset = tolerance + twohalf_hole_back_offset + hole_rad;
    front_offset = tolerance + twohalf_bracket_width - twohalf_hole_front_offset - hole_rad;
    hole_z_offset = bracket_height - (twohalf_hole_z_offset + hole_rad);
    difference() {
        cube([twohalf_bracket_width + tolerance * 2, stiffness, bracket_height]);
        translate([back_offset, -0.1, hole_z_offset]) rotate([-90, 0, 0]) screw_hole();
        translate([back_offset + twohalf_hole_distance + hole_rad + tolerance, -0.1, hole_z_offset]) rotate([-90, 0, 0]) screw_hole();
        #translate([front_offset, -0.1, hole_z_offset]) rotate([-90, 0, 0]) screw_hole();
    }
}

module crossbeams(width = twohalf_bracket_width, depth = gap_depth, height = bracket_height, ends = true) {
    //#translate([stiffness, 0, 0.1]) cube([stiffness, gap_depth + stiffness, bracket_height + tolerance]);
    if (ends) {
        translate([-stiffness * 2, 0, 0])
        difference() {
            cube([stiffness * 2, depth + stiffness, height]);
            scale([0.25, 1, 1]) translate([depth / 2 + stiffness * 4, depth / 2 + stiffness/2, -0.1]) cylinder(h=height + 0.2, d=depth - tolerance * 2);
        }
        translate([width + stiffness * 2, depth + stiffness, 0])
        rotate([0, 0, 180]) 
        difference() {
            cube([stiffness * 2, depth + stiffness, bracket_height]);
            scale([0.25, 1, 1]) translate([depth / 2 + stiffness * 4, depth / 2 + stiffness/2, -0.1]) cylinder(h=height + 0.2, d=depth - tolerance * 2);
        }
    }

    difference() {
        x_offset = ends ? -stiffness * 2 : 0;
        y = ends ? width + stiffness * 4 : width;
        translate([x_offset, 0, height]) cube([y, depth + stiffness, stiffness]);
        hull() {
            translate([0, depth - inside_dia, 0]) cylinder(h=height + stiffness * 2, d=inside_dia);
            translate([0, stiffness + inside_rad, 0]) cylinder(h=height + stiffness * 2, d=inside_dia);
            #translate([(width + inside_dia) / 2, (depth / 2), 0]) cylinder(h=height * 2 + stiffness * 2, d=inside_dia);
        }
        #rotate([0, 0, 180]) translate([-y - (x_offset * 2), -(depth + stiffness- inside_dia), 0])
        hull() {
            translate([0, depth - inside_rad, 0]) cylinder(h=height + stiffness * 2, d=2);
            translate([0, stiffness + inside_rad, 0]) cylinder(h=height + stiffness * 2, d=2);
            #translate([(width + inside_dia) / 2, (depth / 2), 0]) cylinder(h=height * 2 + stiffness * 2, d=inside_dia);
        }
    }

    #translate([0, depth / 2, 0]) cube([width, 0.1, 12]);
}

module threehalf_bracket() {
    back_hole_offset = tolerance + twohalf_hole_back_offset + hole_rad;
    front_hole_offset = back_hole_offset + threehalf_hole_width;
    // top
    difference() {
        cube([threehalf_bracket_width + tolerance * 2, stiffness, bracket_height]);
        translate([back_hole_offset, -0.1, bracket_height - 6.5]) rotate([-90, 0, 0]) screw_hole();
        translate([front_hole_offset, -0.1, bracket_height - 6.5]) rotate([-90, 0, 0]) screw_hole();
    }
    // bottom
    translate([0, threehalf_drive_depth + tolerance, 0])
    difference() {
        cube([threehalf_bracket_width + tolerance * 2, stiffness, bracket_height]);
        translate([back_hole_offset, -0.1, bracket_height - 6.5]) rotate([-90, 0, 0]) screw_hole();
        translate([front_hole_offset, -0.1, bracket_height - 6.5]) rotate([-90, 0, 0]) screw_hole();
    }
}

union() {
    translate([-tolerance, 0, 0]) twohalf_bracket();
    crossbeams();
    translate([-tolerance, gap_depth, 0]) threehalf_bracket();
    //translate([0, gap_depth + stiffness, 0]) crossbeams(width=threehalf_bracket_width, depth=threehalf_drive_depth, ends = false);
}