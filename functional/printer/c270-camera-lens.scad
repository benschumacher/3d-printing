use <threadlib/threadlib.scad>

$fn = $preview ? $fn : 64;

lens_base_xy = 14;
lens_base_z = 2.5;
lens_opening_ID = 10.4;
lens_opening_OD = lens_opening_ID + 2.4;

lens_base_screw_offset = 8.4;
lens_base_screw_z = 4.5;
lens_base_screw_topD = 3.2;
lens_base_screw_botD = 4.5;

buf = 0.2;

cap_base_xy = lens_base_xy + 2.4;
cap_base_z = lens_base_z + 1.2;
cap_base_screw_OD = lens_base_screw_botD + 2.4;
cap_base_screw_ID = lens_base_screw_botD + buf;
cap_base_screw_z = lens_base_screw_z + 1.2;

top_id = 16.7;
top_od = top_id + 2.6;

module base() {
    int_xy = lens_base_xy + buf;
    int_z = lens_base_z + buf;
    lens_z = lens_base_screw_z + buf;

    difference() {
        union() {
            translate([0, 0, cap_base_z/2]) cube([cap_base_xy, cap_base_xy, cap_base_z], center=true);
            translate([0, 0, cap_base_z]) {
                cylinder(h=2, r=lens_opening_OD/2 + buf);
                translate([0, 0, 2])
                    cylinder(h=3, r1=lens_opening_OD/2 + buf, r2=top_od/2);
                translate([0, 0, 5]) cylinder(h=4.5, d=top_od);
            }
            difference() {
                hull() {
                    translate([0, -lens_base_screw_offset, 0]) cylinder(h=cap_base_screw_z, d=cap_base_screw_OD);
                    translate([0, lens_base_screw_offset, 0]) cylinder(h=cap_base_screw_z, d=cap_base_screw_OD);
                }
                hull() {
                    translate([0, -lens_base_screw_offset, 0]) cylinder(h=int_z, d=cap_base_screw_ID);
                    translate([0, lens_base_screw_offset, 0]) cylinder(h=int_z, d=cap_base_screw_ID);
                }
            }
        }

        translate([0, 0, int_z/2-0.1]) cube([int_xy, int_xy, int_z+buf], center=true);
        hull() {
            translate([0, -lens_base_screw_offset, 0]) cylinder(h=int_z, d=cap_base_screw_ID);
            translate([0, lens_base_screw_offset, 0]) cylinder(h=int_z, d=cap_base_screw_ID);
        }
#        translate([0, -lens_base_screw_offset, int_z]) cylinder(h=lens_z-int_z, r1=cap_base_screw_ID/2, r2=lens_base_screw_topD/2+0.2);
        translate([0, lens_base_screw_offset, int_z]) cylinder(h=lens_z-int_z, r1=cap_base_screw_ID/2, r2=lens_base_screw_topD/2+0.2);

        translate([0, 0, cap_base_z])
            union() {
                translate([0, 0, 2]) cylinder(h=3, r1=6, r2=top_id/2);
                translate([0, 0, 5]) translate([0, 0, -0.2]) tap("M17x1", turns=4.5);
            }
        cylinder(h=10, d=lens_opening_ID);
    }
}

module bottom() {
    difference() {
        union() {
            rotate([90, 0, 0]) import("M12LensAdapter.stl");
            hull() {
                translate([0, -8.4, 0]) cylinder(h=10, d=4.4);        
                translate([0, 8.4, 0]) cylinder(h=10, d=4.4);
            }
        }

        hull() {
            translate([0, -8.4, 6]) cylinder(h=4, d=3);
            translate([0, 8.4, 6]) cylinder(h=4, d=3);
        }

        translate([0, 0, 0]) cylinder(h=10, d=12);
        translate([0, 0, 6]) cylinder(h=4, d=13.4);

        translate([-2.2, 8.4-1.5, -6.4]) rotate([45, 0, 0]) A([4.4,10,4.4]);
        mirror([0,1,0]) translate([-2.2, 8.4-1.5, -6.4]) rotate([45, 0, 0]) cube([4.4,10,4.4]);
    }
}

module top() {
    difference() {
        cylinder(h=4.5, d=top_od);
        //cylinder(h=4.5, d=top_id);
        translate([0, 0, -0.2]) tap("M17x1", turns=5);
    }    

    difference() {
        translate([0, 0, 3.5])
            union() {
                cylinder(h=1, d=top_od);
                translate([0, 0, 1])
                    cylinder(h=2, r1=top_od/2, r2=(12/2)+1);
                translate([0, 0, 3])
                    cylinder(h=3.2, r=(12/2)+0.7);
                hull() {
                    translate([-8.4, 0, 1]) cylinder(h=5.2, d=2.5);
                    translate([8.4, 0, 1]) cylinder(h=5.2, d=2.5);
                }
            }  
        
        union() {
            cylinder(h=10, d=12);
            translate([0, 0, 3.5]) cylinder(h=3, r1=top_id/2, r2=6);
        }
    }
}

translate([25, 25, 0]) 
// !color("blue") translate([0, 0, 15]) rotate([180, 0, 0])
    base();
// top();

