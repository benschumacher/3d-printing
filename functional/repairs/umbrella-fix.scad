supp_dia = 3.5;
supp_hgt = 3.4;
supp_len = 40;
supp_stf = 1.2;

tooth_hgt = 1.0;
tooth_gap_len = 30;
tooth_gap_offset = (supp_len/2) - (tooth_gap_len/2);

narrow_len = 4.8;
narrow_offset = (supp_len/2) - (narrow_len/2);

buffer = 0.2;

supp_dia_buf = supp_dia + buffer;
supp_irad = (supp_dia / 2) + (buffer / 2);
supp_orad = supp_irad + supp_stf;

intersection() {
    difference() {
        cube_x_offset=-(supp_orad);
        union() {
            translate([cube_x_offset, 0, 0]) cube([supp_orad * 2, supp_len, supp_hgt]);
            rotate([-90, 0, 0]) cylinder(h=supp_len, r=supp_orad, $fn = 64);
        }
        union() {
            difference() {
                x_offset=-(supp_irad);
                union() {
                    translate([x_offset, 0, 0]) cube([supp_dia_buf, supp_len, supp_hgt-tooth_hgt]);
                    translate([x_offset + 0.4, 0, 0]) cube([supp_dia_buf - tooth_hgt, supp_len, supp_hgt]);
                    translate([x_offset, tooth_gap_offset, 0]) cube([supp_dia_buf, tooth_gap_len, supp_hgt]);
                    rotate([-90, 0, 0]) cylinder(h=supp_len, r=supp_irad, $fn = 64);
                }
                #union() {
                    narrow_x = (supp_stf - buffer)/2;
                    translate([x_offset, narrow_offset, -1.5]) cube([narrow_x, narrow_len, supp_hgt+1.5]);
                    translate([x_offset + (supp_dia_buf - narrow_x), narrow_offset, -1.5]) cube([narrow_x, narrow_len, supp_hgt+1.5]);
                }
            }
            translate([0, supp_len / 2, 0.8]) rotate([0, -90, 0]) cylinder(h=supp_orad*2, r=1, center=true, $fn=64);
            translate([3, supp_len / 2, 0.8]) rotate([90, 0, 0]) rotate([0, -90, 0]) cylinder(h=1.6, r=(2 + 0.4), center=true, $fn=6);
            translate([-3, supp_len / 2, 0.8]) rotate([90, 0, 0]) rotate([0, -90, 0]) cylinder(h=1.6, r=2, center=true, $fn=64);
        }
    }
    // translate([-5, 15, -5]) cube([10, 10, 10]);
}