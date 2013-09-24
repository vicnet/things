/**
 * Minimum bed for rostock.
 * Composed with:
 * - a circular working surface
 * - some support for rod and motors
 * - plain material for solidity
 * 
 * TODO:
 * - add projection for (minimum) laser cutting
 */

use <vcad/vector.scad>

working_dim = 400; // 40x40cm
plywood_thickness = 10; // 1cm, max for laser cut
tower_dist = 300; // distance between center and tower center
rod_dist = 60; // distance between 2 rods
rod_diameter = 12;
extra_rod = 20; // distance from border to rod center

tower_radius = working_dim/2;

// p1 is the left-upper point of bed
p1 = [ tower_dist + extra_rod
	 , (rod_dist/2) + extra_rod];
// p2 is the left-lower point of bed
p2 = [ tower_dist + extra_rod
	 , -(rod_dist/2) - extra_rod];

// pp1 and pp2 are the same points rotate from 120°
pp1 = rotate2D(-120,p1);
pp2 = rotate2D(-120,p2);

2d = false;
//2d = true;

/* not working well
module multiple(n) {
	for (a=[0:360/n:360-360/n]) {
		rotate(a)
			child(0);
	}
}
*/

// helper module to rotate one child 3 times
module triple() {
	for (a=[0,120,240]) {
		rotate(a)
			child(0);	
	}
	//	multiple(3) child(0);
}

module symetric() {
	for (a=[0,180]) {
		rotate(a)
			child(0);
	}
	//	multiple(2) child(0);
}

function rotate2D(a,v) =
	[ [cos(a), -sin(a)],
	  [sin(a),  cos(a)] ] * v;


module working_surface() {
	cylinder(r=tower_radius, h=plywood_thickness, center=true);
}

module rod_support() {
	lsupport = tower_dist+extra_rod;
	wsupport = rod_dist+2*extra_rod;
	translate([lsupport/2,0,0])
		cube([lsupport,wsupport,plywood_thickness], center=true);
}

module rod_hole() {
//	for (n = [-1,1]) {
	translate([tower_dist,0])
		symetric() {
			translate([0,rod_dist/2])
				cylinder(r=rod_diameter/2, h=plywood_thickness+2, center=true);
		}
}

module rod_holes() {
	triple()
		rod_hole();
}

module timing_belt_hole() {
	pulley_width = 1.3;
	extra_pulley = 2.5;
	belt_width = 6;
	// join to cylinder fo oblong hole
	hull() {
		// put two cylinder as opposite
		symetric() {
			translate([belt_width/2+extra_pulley,0])
				cylinder(r=pulley_width/2+extra_pulley, h=plywood_thickness+2, center=true);
		}
	}
}

module timing_belt_holes() {
	pulley_diameter = 12.8;
	translate([tower_dist,0])
	//	symetric() { // non recursive module !!
		for (a=[0,180]) { rotate(a)
			translate([0,pulley_diameter/2])
				timing_belt_hole();
		}
}

module screw_holes(nb_screw_holes=4) {
	translate([tower_dist,0]) {
		for (y = [-30,30]) {
			for (x = [-70,-13]) {
				if ((nb_screw_holes==4) || (x==-13)) {
					translate([x,y])
						cylinder(r=1.9, plywood_thickness+2, center=true, $fn=12);
				}
			}
		}
	}
}

module bed_plain() {
	// hull for consolidation
	// and cut simplifcation
	hull() {
		working_surface();
		triple()
		rod_support();	
	}
}

module bed_holes(nb_screw_holes=4, with_belt_holes=true) {
	rod_holes();
	if (nb_screw_holes!=0) {
		triple()
			screw_holes(nb_screw_holes);
	}
	if (with_belt_holes) {
		triple()
			timing_belt_holes();
	}
}

// - nb_screw_holes number of screws: 0: none, 2: only front, 4: back
module bed(nb_screw_holes=4, with_belt_holes=true) {
	difference() {
		bed_plain();
		bed_holes(nb_screw_holes,with_belt_holes);
	}
}

module plywood() {
	plywood_width = p2[0]-pp2[0];
	plywood_height = -2*pp1[1];
	
	echo("plywood width:",plywood_width);
	echo("plywood height:",plywood_height);

	// in 2dn keep only dimensions of plywood, not plywood itself
	if (!2d) {
		translate([pp2[0],pp1[1],-plywood_thickness/2])
			cube([plywood_width,plywood_height,plywood_thickness],center=false);
	}
}

module smooth_rod() {
	steel = [0.8, 0.8, 0.9];
	smooth_rod_length = 1000;
	color(steel) cylinder(r=6, h=smooth_rod_length);
}

module tower() {
	translate([300, 0]) {
		translate([ 0, 30]) smooth_rod();
		translate([ 0,-30]) smooth_rod();
	}
}

module towers() {
	triple() 
		tower();
}

module pcb() {
	color("red")
		translate([0,0,plywood_thickness])
			cube([300*1.33,300*1.33,5],center=true);
}

module round_working_surface() {
	color("red")
		translate([0,0,plywood_thickness])
			working_surface();
}

// 1 bed and 1 top shifted
module beds2() {
	shift = vcad_distance(p1,p2)*1.5
		 + vcad_distance(p2,pp1)/2;
	
	echo("Shift: ", shift);
	
	translate([0, shift/2]) bed(nb_screw_holes=4, with_belt_holes=true);
	translate([0,-shift/2]) bed(nb_screw_holes=2, with_belt_holes=false);
}

module plywood2() {
	plywood2_width = p2[0]-pp2[0];
	plywood2_height = vcad_distance(p2,pp1)*1.5
			 + vcad_distance(p1,p2)*2.5;
	
	echo("plywood width  for 2 beds: ", plywood2_width);
	echo("Plywood height for 2 beds: ", plywood2_height);

	// in 2dn keep only dimensions of plywood, not plywood itself
	if (!2d) {
		translate([pp2[0],pp1[1],-plywood_thickness/2])
			cube([plywood2_width,plywood2_height,plywood_thickness], center=false);
	}
}

if (2d) {
*	projection(cut = false)
		bed_holes(nb_screw_holes=4, with_belt_holes=true);
	plywood();
} else {
	*bed(nb_screw_holes=4, with_belt_holes=true);
	*bed(nb_screw_holes=2, with_belt_holes=false);
}

*%plywood();
*%plywood2();
*round_working_surface();
*pcb();
*towers();
