//This scad file carries all the variables needed to adjust it to whatver fits your lawn lights. adjust as needed.

facets = 64;
$fn = $preview ? 8 : facets;
wallThickness = 1.8;

//main stem variables
LengthOfSpike = 103;
pieceRatio = 0.90;
cylinderDiameter = 4;

//top plug values, this will be what fits into the garden light
ringDiameter = 12.8;
holdingCylinderHeight = 23; 
holdingCylinderDiameter = 20;
numberOfRibs = 8;
ribsThickness = 1.2;

cylinderRadius = cylinderDiameter/2;
ringRadius = ringDiameter/2;

module mainCylinder() {
	cylinder(h=LengthOfSpike*(1-pieceRatio), r1=0.5, r2=cylinderRadius);
	translate([0,0,LengthOfSpike*(1-pieceRatio)]) cylinder(h=LengthOfSpike*pieceRatio, d=cylinderDiameter);
};

module coneWingsA() {
	pointA = [LengthOfSpike*(1-pieceRatio), cylinderRadius];
	pointB = [LengthOfSpike*(1-pieceRatio), cylinderRadius-1];
	pointC = [LengthOfSpike, cylinderRadius-1];
	pointD = [LengthOfSpike, ringDiameter * 0.75];
	pointE = [LengthOfSpike*((1-pieceRatio)*1.5), cylinderRadius*1.5];
	for (i = [0:3]) {
		rotate([90,-90,i*90])
			linear_extrude(height=wallThickness,center=true)
				polygon([pointA,pointB,pointC, pointD, pointE]);
	}
};

module coneWingsB() {
	m = LengthOfSpike*(1/3)/ringRadius;
	pointA = [0, LengthOfSpike*(2/3)];
	pointB = [0,m*(wallThickness - ringRadius)+LengthOfSpike];
	pointC = [ringRadius - wallThickness, LengthOfSpike];
	pointD = [ringRadius, LengthOfSpike];
	for (i = [0:1]) {
		rotate([90,0,i*180])
			linear_extrude(height= cylinderDiameter*2, center= true)
				polygon([pointA, pointB, pointC, pointD]);
	}			
}

module ring() {
	translate([0,0,LengthOfSpike])
		difference() {
			cylinder(h=wallThickness, d=holdingCylinderDiameter);
			// drainage hole
			translate([holdingCylinderDiameter/2/4, holdingCylinderDiameter/2/4, 0])
				union() {
					translate([0, 1.2, 0]) cylinder(h=wallThickness*2, d=1.2, center=true);
					translate([0, 0, 0]) cube([0.8, 2.4, wallThickness * 2], center=true);
				}
		}
};

module holdingCylinder() {
	// holdingCyl =
	// 	concat(
	// 		[for (i = [0:$fn]) [sin((i/$fn)*360)* ringDiameter,cos((i/$fn)*360)* ringDiameter]],
	// 		[for (i = [0:$fn]) [sin((i/$fn)*360)*(ringDiameter-wallThickness),cos((i/$fn)*360)*(ringDiameter-wallThickness)]]);
	// translate([0,0,LengthOfSpike+wallThickness])
	// 	linear_extrude(height = holdingCylinderHeight)
	// 		polygon(holdingCyl);

	translate([0,0,LengthOfSpike+wallThickness])
		difference() {
			cylinder(h=holdingCylinderHeight, d=ringDiameter+(wallThickness*2));
			cylinder(h=holdingCylinderHeight+0.2, d=ringDiameter);
		}
	pointA = [holdingCylinderHeight,ringRadius+wallThickness/2];
	pointB = [holdingCylinderHeight,ringRadius+wallThickness+ribsThickness];
	pointC = [0,ringRadius+wallThickness+ribsThickness];
	pointD = [0,ringRadius+wallThickness/2];
	for (i = [0:numberOfRibs-1]) {
		translate([0,0,LengthOfSpike+wallThickness])
			rotate([90,-90,i*(360/numberOfRibs)])
				linear_extrude(height = wallThickness,center = true)
					polygon([pointA, pointB, pointC, pointD]);
	}
}

module light_spike() {
	mainCylinder();
	coneWingsA();
	coneWingsB();
	ring();
	holdingCylinder();
}

light_spike();

if ($preview) {
	translate([0, 0, 150]) color("red") cube([12.5, 0.4, 300], center=true);
	translate([0, 0, 150]) color("blue") cube([0.4, 12.5, 300], center=true);
}