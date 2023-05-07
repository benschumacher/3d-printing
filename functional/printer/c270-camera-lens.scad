$fn = $preview ? $fn : 64;

top_id = 16.7;
top_od = top_id + 2.4;

module base() {
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

        #translate([-2.2, 8.4-1.5, -6.4]) rotate([45, 0, 0]) cube([4.4,10,4.4]);
        #mirror([0,1,0]) translate([-2.2, 8.4-1.5, -6.4]) rotate([45, 0, 0]) cube([4.4,10,4.4]);
    }
}

module top() {
    difference() {
        cylinder(h=3, d=top_od);
        cylinder(h=3, d=top_id);
    }    

    difference() {
        translate([0, 0, 2])
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
            cylinder(h=8.2, d=12);
            #translate([0, 0, 2]) cylinder(h=3, r1=top_id/2, r2=6);
        }
    }
}

translate([25, 25, 0]) 
// !color("blue") translate([0, 0, 15]) rotate([180, 0, 0])
    base();
top();

