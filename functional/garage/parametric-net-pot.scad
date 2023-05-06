
diameter_top=8.5;
diameter_bottom=8.5;

height=60;

overhang_extent=2;
overhang_height=1;
overhang_angle=55;

thickness_bottom=1.2;
thickness_walls= 1.0;

width_connections=1.0;

pie_segments_1=8;
pie_segments_2=16;
pie_segments_3=24;

pie_segments_wall=12;


// Hidden variables:

eps=0.03*1;
echo("$FA", $fa);
echo("$FS", $fs);
echo("$FN", $fn);
//$fa = $preview ? $fa : 1;

//echo(n=($fn>0?($fn>=3?$fn:3):ceil(max(min(360/$fa,r*2*PI/$fs),5))),a_based=360/$fa,s_based=r*2*PI/$fs);

$fn=64*1;


// HELPERS
module cyl_sect(r1, r2, h) {
    difference() {
        cylinder(r=r1, h=h);
        translate([0,0,-eps])
            cylinder(r=r2, h=h+2*eps);
    }
}
module connect(r, w, h, phi) {
    rotate(phi, [0,0,1])
        translate([0,-w/2,0])
            cube([r,w,h]);
}



// OBJECT PARTS
module positive() {
    cylinder(r1=diameter_bottom/2, r2=diameter_top/2, h=height);

    // Overhang
    translate([0,0,height-overhang_height]) {
        cylinder(r=diameter_top/2+overhang_extent, h=overhang_height);
        // printing aid (overhang_angle degrees of overhang are assumed to be printable)
        mirror([0,0,1]) {
            intersection() {
                cylinder(r2=0, r1=diameter_top/2+overhang_extent,
                         h=(diameter_top/2+overhang_extent)/tan(overhang_angle));
                cylinder(r=diameter_top/2+overhang_extent, h=height-overhang_height);
            }
        }
    }
}

module negative() {
    module make_bottom_holes(begin,end,pie_segments) {
        translate([0,0,-eps])
        difference() {
            cyl_sect(r1=end*diameter_bottom, r2=begin*diameter_bottom, h=thickness_bottom+2*eps);
            for (i=[0:pie_segments]) {
                connect(r=diameter_bottom,
                        w=width_connections,
                        h=thickness_bottom+2*eps,
                        phi=i*360/pie_segments);
            }
        }
    }
    module make_wall_holes(begin,end,pie_segments) {
        translate([0,0,begin*height])
        difference() {
            cylinder(r=diameter_bottom+diameter_top, h=(end-begin)*height);
            for (i=[0:pie_segments]) {
                connect(r=diameter_bottom+diameter_top,
                        w=width_connections,
                        h=(end-begin)*height,
                        phi=i*360/pie_segments);
            }
        }
    }

    union() {
        // inside
        difference() {
            difference() {
                cylinder(r1=diameter_bottom/2-thickness_walls, r2=diameter_top/2-thickness_walls, h=height+eps);
                translate([0, diameter_bottom/3, thickness_bottom+0.2]) cube([diameter_bottom, diameter_bottom/3, 0.4], center=true);
                translate([0, -diameter_bottom/3, thickness_bottom+0.2]) cube([diameter_bottom, diameter_bottom/3, 0.4], center=true);
            }
            cylinder(r=diameter_top+diameter_bottom, h=thickness_bottom);
        }

        // holes on wall
        union() {
            make_wall_holes(.05, .10, pie_segments_wall);
            rotate([0, 0, 40]) make_wall_holes(.15, .20, pie_segments_wall);
            rotate([0, 0, 80]) make_wall_holes(.25, .30, pie_segments_wall);
            rotate([0, 0, 120]) make_wall_holes(.35, .40, pie_segments_wall);
            rotate([0, 0, 160]) make_wall_holes(.45, .50, pie_segments_wall);
            rotate([0, 0, 200]) make_wall_holes(.55, .60, pie_segments_wall);
            rotate([0, 0, 240]) make_wall_holes(.65, .70, pie_segments_wall);
            rotate([0, 0, 280]) make_wall_holes(.75, .80, pie_segments_wall);
            rotate([0, 0, 320]) make_wall_holes(.85, .90, pie_segments_wall);
        }

        // holes on bottom
        // union() {
        //     make_bottom_holes(.08, .18, pie_segments_1);
        //     make_bottom_holes(.22, .32, pie_segments_2);
        //     make_bottom_holes(.36, .46, pie_segments_3);
        // }
    }
}

// MAIN
difference() {
    positive();
    negative();
}
