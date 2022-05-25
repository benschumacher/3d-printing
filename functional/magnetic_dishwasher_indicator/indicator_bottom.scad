magnet_dia = 12.70;
magnet_width = 1.56;

union() {        
    import("/Users/bschumacher/Downloads/Magnetic_Dishwasher_Clean___Dirty_Indicator_-_Multi_Color/files/bottom_10x3mm.STL");
    #translate([-73.5, -10, -3]) cube([70, 10, 0.2]);
}

    translate([-67.5, -5, -3]) cylinder(magnet_width, r=magnet_dia/2, $fn=64);


//color("cyan") translate([-3, -13, 0]) cube([10, 16, 1]);