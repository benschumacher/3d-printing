// 3.5"/2.5" HDD/SSD Stackable Tray by TombaDude
// https://www.thingiverse.com/thing:4692256

orig_width = 115.3;
orig_depth = 148.1; 

leg_width = 5.05;

shrink_depth = 6;
target_depth = orig_depth - shrink_depth;

difference() {
    intersection() {
        import("HardDriveTray-Stackable.stl", center=true);
        translate([leg_width, shrink_depth / 2, 0]) linear_extrude(14) square([orig_width - leg_width * 2, target_depth]);
    }

#    translate([0, shrink_depth / 2, 8.20]) cube([orig_width, 16.5, 6]);
}

// difference() {
//     import("HardDriveTray-Stackable.stl", center=true);
    
//     // cut off top
//     translate([0, 0, 14]) linear_extrude(22) square([orig_width, orig_depth]);
//     // cut off legs
//     #cube([leg_width, orig_depth, 14]);
//     translate([orig_width - leg_width, 0, 0]) cube([leg_width, orig_depth, 14]);
//     // slim up the bottom
//     #cube([orig_width, orig_depth, 0.1]);
// }
