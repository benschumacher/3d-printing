max_height = 13.9;
min_height = 12;
diameter = 14.6;
cutout_width = 3;
cutout_height = 4.9;
edge_width = 1.2;
leg_depth = 2.3;
leg_height = 5.1;

$fn = 128;

module angled_cylinder(max_h, min_h, r) {
    d = r * 2;
    
    b = max_h - min_h;
    c = d;
    a = sqrt((b*b) + (c*c));
    angle_b = acos(((a*a) + (c*c) - (b*b)) / (2 * a * c));
    
    echo(b, angle_b);

    difference() {
        cylinder(max_h, r= r);

        // cut the top off
        color("cyan") translate([-(d / 2), -(d / 2), max_h]) rotate([0, angle_b, 0]) cube([d + min_h, d + min_h, (max_h - min_h)]);
    }
}


radius = diameter / 2;
inner_radius = radius - edge_width;

module plug() {
    inner_max_h = max_height - edge_width;
    inner_min_h = min_height - edge_width;
    
    difference() {
        angled_cylinder(max_height, min_height, radius);
  
        // hollow out the inside
        angled_cylinder(inner_max_h, inner_min_h, r= inner_radius);

        // remove the notch
        color("green") translate([-radius, -(cutout_width / 2), 0]) cube([(edge_width * 2), cutout_width, cutout_height]);
    }
}


module feet() {
    feet_width = edge_width * 2;

    translate([0, 0, -leg_height])
    intersection() {
        difference() {
            union() {
                cylinder(leg_height, r= radius);
                //cylinder(edge_width + 0.4, r1= (radius + edge_width), r2 = radius);
                 translate([0, 0, feet_width / 4]) resize([diameter+(1*feet_width), diameter+(1*feet_width), (1*feet_width)]) sphere(r= (radius+feet_width));
            }
            
            cylinder(leg_height, r= inner_radius);
        }
           
        rotate([0, 0, 45]) union() {
            width = diameter + (2 * edge_width);
            
            translate([-(width / 2), -(leg_depth/2), 0]) cube([width, leg_depth, leg_height]);
            rotate([0, 0, 90]) translate([-(width / 2), -(leg_depth/2), 0]) cube([width, leg_depth, leg_height]);
        }       
    }
}

difference() {
    union() {
        plug();
        color("orange") feet();
    }
    

/* difference() {
    color("purple") cylinder(max_height, r= radius);
    color("purple") cylinder(max_height, r= inner_radius); 
}*/
}
