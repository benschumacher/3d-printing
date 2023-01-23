x_diameter = 140;
y_diameter = 120;
edge = 3;
height = 3;
edge_height = 4.2;

buffer = 0.4;

//foot_diameter = 9.525;
foot_diameter = 9.6;
nub_width = 1;
foot_height = height / 2;

y_radius = y_diameter / 2;
foot_radius = foot_diameter/ 2;

$fn = $preview ? 16 : 64; 

module hexgrid() {
    // length of a hexagon side 
    s = 6;   //[1:20] 
    // distance between hexagons (grid width)
    d = 1.4;   //[0.5:10] 
    // number of hexagons in x direction (even numbers only!)
    x = 15;  //[2:100]
    // number of hexagons in y direction (even numbers only!)
    y = 24;  //[2:100]
    // height of the grid plate
    h = height;   //[1:10]

    for (j = [1:2:y]){
        for (i = [1:2:x]){
            translate([(s+(s/2)+hexhspace())*(i-1),(hexheight()/2+d/2)*j])hex(s);
            translate([(s+(s/2)+hexhspace())*i,(hexheight()/2+d/2)*(j-1)])hex(s);
        }
    }    
}

module base() {
    x_offset = x_diameter - y_diameter;

    difference() {
        difference() {
            hull() {
                cylinder(h=edge_height, r=y_radius + edge);
                translate([x_offset, 0, 0]) cylinder(h=edge_height, r=y_radius + edge);
            }
            translate([0, 0, height])
            hull() {
                cylinder(h=edge_height, r=y_radius);
                translate([x_offset, 0, 0]) cylinder(h=edge_height, r=y_radius);
            }
        }

        union() {
            intersection() {
                difference() {
                    hull() {
                        cylinder(h=height, r=y_radius);
                        translate([x_offset, 0, 0]) cylinder(h=height, r=y_radius);
                    }
                    translate([-40, -35, 0]) cylinder(h=foot_height, r=(foot_diameter+buffer+nub_width*2) / 2);
                    translate([40 + x_offset, -35, 0]) cylinder(h=foot_height, r=(foot_diameter+buffer+nub_width*2) / 2);
                    translate([-40, 35, 0]) cylinder(h=foot_height, r=(foot_diameter+buffer+nub_width*2) / 2);
                    translate([40 + x_offset, 35, 0]) cylinder(h=foot_height, r=(foot_diameter+buffer+nub_width*2) / 2);
                }
                
                translate([-70.7, -70.7, 0]) hexgrid();
            }

            translate([-40, -35, 0]) cylinder(h=foot_height/2, r=(foot_diameter+buffer) / 2);            
            translate([40 + x_offset, -35, 0]) cylinder(h=foot_height/2, r=(foot_diameter+buffer) / 2);            
            translate([-40, 35, 0]) cylinder(h=foot_height/2, r=(foot_diameter+buffer) / 2);            
            translate([40 + x_offset, 35, 0]) cylinder(h=foot_height/2, r=(foot_diameter+buffer) / 2);            
        }        
    }

    // translate([-40, -35, 0]) foot();
    // translate([40 + x_offset, -35, 0]) foot();
    // translate([-40, 35, 0]) foot();
    // translate([40 + x_offset, 35, 0]) foot();
}

module foot() {
    // $fn = $preview ? 8 : 64; 
    difference() {
        cylinder(h=foot_height, r=(foot_diameter+buffer+nub_width*2) / 2);
        cylinder(h=foot_height/2, r=(foot_diameter+buffer) / 2);
    }
}

use <../../modules/hex_mesh_1.scad>

base();

// hexgrid();