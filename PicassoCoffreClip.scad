module sphereCap(a = 10, h = 4) {
	r = (a*a +h*h)/(2*h);
	translate([0,0,-r+h]) {
		difference() {
			sphere(r);
			translate([0,0,-h]) {
				cube(2*r,true);
			}
		}
	}
}

module tube(hauteur, rayon, epaisseur) {
	difference() {
		cylinder(hauteur,rayon,rayon);
		translate([0,0,-1]) {
			cylinder(hauteur+2,rayon-epaisseur,rayon-epaisseur);
		}
	}
}

module tz(z) {
	for (i = [0 : $children-1]) {
		translate([0,0,z]) {
			child(i);
		}
	}
}

$fn=20;

module bloqueur() {
	alternative = true;
	difference() {
		union() {
			cylinder(r1=3.25,r2=3.5, h=2);
			tz(2) cylinder(r1=3.5,r2=3, h=4.6);
		}
		if (alternative) {
			for (a=[0,90])
				rotate(a)
					tz((6.6-1)/2)
						cube([1, 8, 6.6+1],center=true);
		} else {
			tz(-0.5) {
				// zone vide de pinçage
				tube(8, 2.7, 0.8);
				for (angle = [0,90,180,270]) {
					rotate(angle) {
						translate([2.5,0,0]) cube([1.25,1,8]);
					}
				}
			}
		}
	}
}

module axe() {
	cylinder(r=3,h=3.4);
}

module stop() {
	sphereCap(5.5, 3.3);
}

module rotule() {
	print_epsilon = 0.25;
	difference() {
		sphereCap(5.25+print_epsilon, 4.5+print_epsilon);
		translate([-6,-6, 5-1]) cube([12,12,2]);
	}
}

union() {
	bloqueur();
	tz(6.6) stop();
	tz(8.5) axe();
	tz(11.9) rotule();
}
