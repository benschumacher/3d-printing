$fn = $preview ? $fn : 32;

module base() {
    difference() {
        union() {
            rotate([90, 0, 0]) import("/Users/ben/Downloads/M12LensAdapter.stl");
            translate([-8.2, 0, 4]) cylinder(h=6, d=4);
            translate([8.2, 0, 4]) cylinder(h=6, d=4);
        }
        translate([-8.2, 0, 4]) cylinder(h=6.2, d=3);
        translate([8.2, 0, 4]) cylinder(h=6.2, d=3);
    }
}

module top() {
    difference() {
        union() {
            import("/Users/ben/Downloads/lensadapter.stl");
            cylinder(h=1, d=18); 

            intersection() {
                cylinder(h=1.2, d=40);
                translate([6, -20, 0]) cube([(40-12/2), 40, 1.4]);
            }
            intersection() {
                cylinder(h=1.2, d=40);
                translate([-(40-12/2)-6, -20, 0]) cube([(40-12/2), 40, 1.4]);
            }        

        }

        translate([0, 0, -0.1]) cylinder(h=1.4, d=12);
    }    

    translate([-8.2, 0, -5]) cylinder(h=5, d=2.8, $fn = 16);
    translate([8.2, 0, -5]) cylinder(h=5, d=2.8, $fn = 16);
}

translate([25, 25, 0]) base();
rotate([180, 0, 0]) top();

