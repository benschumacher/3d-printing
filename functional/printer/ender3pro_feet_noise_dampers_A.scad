difference() {
    import("/Users/bschumacher/Downloads/Creality_Ender_3_PRO_-_Feet_Noise_Dampers-A.stl");
    translate([-29, -9.25, 13]) rotate([180, 0, 0]) cube([58, 3, 20]);
}


foot_diameter = 9.525;
//foot_diameter = 8;
buffer = 0.5;
nub_width = 1;
foot_height = 0.5;

module foot() {
    difference() {
        rotate([90, 0, 0]) cylinder(h=foot_height, r=(foot_diameter+buffer+nub_width*2) / 2, $fn=64);
        rotate([90, 0, 0]) cylinder(h=foot_height, r=(foot_diameter+buffer) / 2, $fn=64);
    }
}

translate([-19,-9.25, 6]) foot();
translate([19,-9.25, 6]) foot();