// Inspiration: https://www.amazon.com/dp/B07SHR6LMX
// Dimensions: 
// - Plate Thickness: 2mm/ 0.08"
// - Groove Distance: 12mm/0.67"
// - Mount Hole Dia: 4.5mm/ 0.177"
// - Holes Center Distance: 19mm/ 0.75"
// - Front Guard Plate Height: 15.5mm/ 0.61"
// - Total Size: 40mm/1.57" x 16.5mm/0.65" x 35mm/1.37"(L x W x H) 
// Schematic: https://m.media-amazon.com/images/I/51lwsASLTUL._AC_SL1001_.jpg

width = 30;
height = 28.2;
front_height = 10.2;
groove_height = 8;
thickness = 2.2;
curve = 0.5;

groove_idepth = groove_height;
groove_odepth = groove_idepth + (thickness * 2);
groove_buffer = 0.6;

hole_count = 2;

hole_dia = 4.5;
hole_distance = 19;

include <../../modules/roundedcube.scad>
include <../../modules/screw_holes.scad>
screw_hole_fn = $preview ? 8 : 64;

$fn = screw_hole_fn;

tile_bracket();

module tile_bracket() {
  screw_x = (width / 2);
  screw_z = front_height + ((height - front_height) / 2);
  hole_offset_x = width / (hole_count);

  echo("HOLE_OFFSET_X=", hole_offset_x);

  difference() {
    bracket_form();
    for (h = [0:hole_count]) {
      translate([(h * hole_offset_x) + (hole_offset_x / 2), thickness, screw_z])
        rotate(90, [1, 0, 0])
          screw_hole(DIN965, M4, 10);
    }
  }
}

module bracket_form() {
    translate([0, 0, 0])
      roundedcube([width, thickness, height], radius=curve, apply_to="ymax");

    translate([0, -0.25, 0])
      roundedcube([width, groove_odepth, thickness], radius=curve);
    translate([0, groove_odepth - thickness - 0.125])
      roundedcube([width, thickness, front_height], radius=curve);
    
    difference() {
        translate([1, thickness - 0.1, thickness - 0.125])
          cube([width - (curve * 4), groove_idepth + 0.2, groove_height / 2]);
        #translate([curve - 0.1, thickness + (groove_idepth / 2) - 0.1, thickness + (groove_height / 2)])
          rotate(90, [0, 1, 0])
            cylinder(r=(groove_idepth / 2) + groove_buffer, h = 0.2 + (width - (curve * 2)));
    }
}
