// A single integer creates a cube with the specified wall distance. Default [1, 1, 1]
// size = 5;

// An [x, y, z] vector specifies distance on each axis. Default [1, 1, 1]
// size = [2, 3, 5];

// Whether or not to place the object centered on the origin. Default false
// center = true|false;

// Specify a rounding radius. Default 0.5
// radius = 0.5

// Specify where to apply the rounded corners. Default "all"
// apply_to = "all"|"x"|"y"|"z"|"zmax"|"zmin"|"xmax"|"xmin"|"ymax"|"ymin"

// Higher definition curves
//$fs = 0.01;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

    echo(str("roundedcube(",size,", radius=", radius, ", apply_to=",apply_to));

	translate_min = 0;
	translate_xmax = size[0];
	translate_ymax = size[1];
	translate_zmax = size[2];

	diameter = radius * 2;

    function adj2(i,dt,df) = (i==0)?dt:df;
    function adj(i,d) = adj2(i,d,-d);
    function adjR(i) = adj(i,radius);
    
	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (xi = [0:1]) {
                translate_x = [translate_min, translate_xmax][xi];
				x_at = (xi == 0) ? "min" : "max";
				for (yi = [0:1]) {
                    translate_y = [translate_min, translate_ymax][yi];
   				    y_at = (yi == 0) ? "min" : "max";
					for (zi = [0:1]) {
                        translate_z = [translate_min, translate_zmax][zi];
    	     			z_at = (zi == 0) ? "min" : "max";

						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
                            // GGS: Separate translates to asccomodate changes allowing sizes < 3 x radius
    						translate(v = [translate_x+adjR(xi), translate_y+adjR(yi), translate_z+adjR(zi)])
							  sphere(r = radius);
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
                            //Compute cylinder height to make it work with cubbe sizes up to 3xradius which did not work
                            // in original because cylinders would "eat" spheres
                            h1 =
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? size[0]-radius : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? size[1]-radius :
								size[2]-radius
							);
                            h2 =
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? size[0]/4 : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? size[1]/4 :
								size[2]/4
							);
                            h=(h1<h2 && h1>0)?h1:h2;
                            height=(h<radius)?h:radius;
                            //echo(str("h1=",h1));
                            //echo(str("h2=",h2));
                            //echo(str("h=",h));
                            //echo(str("height=",height));
                            trans =
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [adj2(xi,0,-height),adjR(yi),adjR(zi)] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [adjR(xi),adj2(yi,0,-height),adjR(zi)] :
								[adjR(xi),adjR(yi),adj2(zi,0,-height)]
							);
                            //echo(trans);
                            translate(v = [translate_x+trans[0], translate_y+trans[1], translate_z+trans[2]])
		  					  rotate(a = rotate)
							    cylinder(h = height, r = radius, center = false);
						}
					}
				}
			}
		}
	}
}