$fn = $preview ? 8 : 128;

width = 43;
height = 13;

thinend_od = 4;
fatend_od = 11.5;

screwhole = 4;

module anchor() {
    difference() {
        union() {
            distance = width - (thinend_od + fatend_od) / 2;
            hull() {
                translate([distance, 0, 0]) cylinder(d=thinend_od, h=height);
                translate([distance / 2, 2.5, 0]) cylinder(d=(fatend_od + thinend_od) / 2, h=height);
            }
            hull() {
                translate([distance / 2, 2.5, 0]) cylinder(d=(fatend_od + thinend_od) / 2, h=height);
                cylinder(d=fatend_od, h=height);
            }
        }
        translate([0, 0, -0.1]) cylinder(d=screwhole, h=height + 0.2);
    }
}

anchor();