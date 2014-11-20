// Copyright Juan Carlos Orozco 2013
use <obiscad/bcube.scad>
// All units in mm
// CONFIG
ptr = (3/4)*25.4;
wall = 1.1; // 1/16*25.4;
slack = 0.1;
int = ptr-2*(wall+slack); // Interior
hole = 3; // Diameter
bres = 8; // Bevel resolution (how round the cubes edges are.
bsize = int/10; // Size of bevel.

// WISH: Parameter for prong length and hole position.

echo(ptr);

// Size of x, y, z of cube can be different.
module bcube3(size,cr=0,cres=0) {
	intersection() {
		bcube(size,cr,cres);
		rotate([90,0,0]) bcube([size[0],size[2],size[1]],cr,cres);
		rotate([0,90,0]) bcube([size[2],size[1],size[0]],cr,cres);
	}
}

module prong() {
	difference() {
		translate([int,0,0]) bcube3([int*1.2,int,int], cr=bsize, cres=bres);
		union() {
			translate([ptr,0,0]) cylinder(r=hole/2,h=ptr,center=true,$fn=40);
			translate([ptr,0,0]) rotate([90,0,0]) cylinder(r=hole/2,h=ptr,center=true,$fn=40);			
		}
	}
}

// Test bevel cube 3D.
//bcube3([50,100,150], cr=5, cres=4);

difference() {
	union() {
		cube([ptr,ptr,ptr], center=true);
		// Comment the prongs that are not needed in the connector design.
		// +X
		prong();
		// +Y
		rotate([0,0,90]) prong();
		// -X
		//rotate([0,0,180]) prong();
		// -Y
		//rotate([0,0,270]) prong();
		// +Z
		rotate([0,-90,0]) prong();
	}
	translate([0,0,-int]) cube([4*ptr, 4*ptr, int], center=true);
}
