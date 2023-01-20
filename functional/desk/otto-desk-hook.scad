use <../../modules/hook_library.scad>

//height = 0;
//width = 18;

/* [Dimensions of hook]*/
//vertical length of rectangular back the hook 
length1 = 49;

//width of hook
width = 18;

//horizontal length of rectangular part of the hook
length2 = 26;

//vertical length of rectangular front of the hook
length3 = 12;

radius1 = width/2;

//thickness of the hook
thickness = 6;

//rear slot brace offset
brace_offset = 18.5;

//rear slot brace height (half of length1?)
brace_height = 49;

//rear slot brace thickness
brace_thickness = 1.2;

/*[Type of hook ] */

//size of the fillet
fillet = 1;

//radius of the hook (also changes the total length of the hook)
hookRadius = 10;

/* [Other] */
//number of fragments
$fn = 30;

//diameter of the screw holes
diameter = 0; // [5,6,8,10]

//enable countersunk in screw hole
countersunk = false;


intersection() {
	//translate([0,0,length1-fillet*6]) cube([100, 100, thickness]);
difference() {
	union() {
		roundedCube(length1,width,thickness,fillet);
		translate([-hookRadius,0,0]) rotate([-90,0,0]) bendedCubeWithFillet(length1, width, thickness, hookRadius);
		translate([-length2-hookRadius,0,-hookRadius]) rotate([0,90,0]) roundedCube(length2,width,thickness,fillet);
		translate([-length2-hookRadius,0,0]) rotate([-90,90,0]) bendedCubeWithFillet(length1, width, thickness, hookRadius);
		translate([thickness/2,radius1,length1]) rotate([0,90,90]) halfCylinderWithFillet(width,thickness/2,fillet);
		translate([thickness/2,radius1,length1]) rotate([0,90,90]) halfCylinderWithFillet(width,thickness/2,fillet);
		translate([-length2-(2*hookRadius)-thickness,0,0]) roundedCube(length3,width,thickness,fillet);
		translate([-length2-(2*hookRadius)-thickness/2,radius1,length3]) rotate([0,90,0]) halfCylinderWithFillet(thickness,radius1,fillet);
		
		// rear brace
		if (brace_offset > 0) {
			brace_top_length = brace_offset*2 + brace_thickness;
			translate([thickness/2,0, length1+(thickness/2)]) rotate([0,90,0]) roundedCube(brace_top_length,width,thickness, fillet);
			translate([thickness+brace_offset,0,length1]) rotate([0,90,0]) roundedCube(brace_thickness, width, brace_height, fillet);
			translate([brace_top_length+(thickness/2),radius1,length1])  rotate([90,180,0]) halfCylinderWithFillet(width,thickness/2,fillet);
		}
	}
	screwHoles(diameter,countersunk);
}
}
